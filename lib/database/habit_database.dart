import 'package:flutter/cupertino.dart';
import 'package:habbi_tracker/models/app_settings.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/habit.dart';

class HabitDatabase extends ChangeNotifier {
  static late Isar isar;

  // Setup //

  // Initialize Database
  static Future<void> initialize() async {
    final dir = await getApplicationCacheDirectory();
    isar = await Isar.open(
      [HabitSchema, AppSettingsSchema],
      directory: dir.path,
    );
  }

  // Save first date of app starup (for heatmap)
  Future<void> saveFirstLaunchDate() async {
    final existingSettings = await isar.appSettings.where().findFirst();

    if (existingSettings == null) {
      final settings = AppSettings()..firstLaunchDate = DateTime.now();
      await isar.writeTxn(() => isar.appSettings.put(settings));
    }
  }

  // Get first date of app starup (for heatmap)
  Future<DateTime?> getFirstLaunchDate() async {
    final settings = await isar.appSettings.where().findFirst();
    return settings?.firstLaunchDate;
  }

  // CRUD Operations //

  // List of habits
  final List<Habit> currentHabits = [];

  // CREATE - add a new habit
  Future<void> addHabit(String habitName) async {
    // create a new habit
    final newHabit = Habit()..name = habitName;

    // save to db
    await isar.writeTxn(() => isar.habits.put(newHabit));

    // re-read from db
    readHabits();
  }

  // READ - read saved habits from db
  Future<void> readHabits() async {
    // fetch all habits from db
    List<Habit> fetchedHabits = await isar.habits.where().findAll();

    // give to current habits
    currentHabits.clear();
    currentHabits.addAll(fetchedHabits);

    // update UI
    notifyListeners();
  }

  // UPDATE - check habit on and off
  Future<void> updateHabitCompletion(int id, bool isCompleted) async {
    // find the specific habit
    final habit = await isar.habits.get(id);

    // update completion status
    if (habit != null) {
      await isar.writeTxn(() async {
        // if habit is completed => add the current date to completedDays list
        if (isCompleted && !habit.completedDays.contains(DateTime.now())) {
          // today
          final today = DateTime.now();

          // add the current date if it's not already in the list
          habit.completedDays.add(DateTime(
            today.year,
            today.month,
            today.day,
          ));
        }

        // if habit is NOT completed => remove the current date to completedDays list
        else {
          habit.completedDays.removeWhere(
            (date) =>
                date.year == DateTime.now().year &&
                date.month == DateTime.now().month &&
                date.day == DateTime.now().day,
          );
        }
        // save the update habits back to the db

        await isar.habits.put(habit);
      });
    }

    // re-read from db
    readHabits();
  }

  // UPDATE - edit habit name
  Future<void> updateHabitName(int id, String newName) async {
    // find the specific habit
    final habit = await isar.habits.get(id);

    // update habit name
    if (habit != null) {
      // update name
      await isar.writeTxn(() async {
        habit.name = newName;
        // save update habit back to the db
        await isar.habits.put(habit);
      });
    }

    // re-read from db
    readHabits();
  }

  // DELETE - delete habit
  Future<void> deleteHabit(int id) async {
    // perform the delete
    await isar.writeTxn(() async {
      await isar.habits.delete(id);
    });

    // re-read from db
    readHabits();
  }
}
