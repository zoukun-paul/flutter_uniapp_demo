import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

class LocationTableEntity extends Table {

  IntColumn get id => integer().autoIncrement()();

  DateTimeColumn get createdAt => dateTime().nullable()();

  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  RealColumn get accuracy => real().nullable()();

  RealColumn get altitude => real().nullable()();
  RealColumn get altitudeAccuracy => real().nullable()();

  RealColumn get speed => real().nullable()();
  RealColumn get speedAccuracy => real().nullable()();

  RealColumn get heading => real().nullable()();
  RealColumn get headingAccuracy => real().nullable()();

}

@DriftDatabase(tables: [LocationTableEntity, ])
class AppDatabase extends _$AppDatabase {

  AppDatabase():super(_openConnection());

  static QueryExecutor _openConnection() {
    // `driftDatabase` from `package:drift_flutter` stores the database in
    // `getApplicationDocumentsDirectory()`.
    return driftDatabase(name: 'octopus.flutter');
  }

  @override
  int get schemaVersion => 1;

}