// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $LocationTableEntityTable extends LocationTableEntity
    with TableInfo<$LocationTableEntityTable, LocationTableEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocationTableEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _latitudeMeta =
      const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
      'latitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _longitudeMeta =
      const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
      'longitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _accuracyMeta =
      const VerificationMeta('accuracy');
  @override
  late final GeneratedColumn<double> accuracy = GeneratedColumn<double>(
      'accuracy', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _altitudeMeta =
      const VerificationMeta('altitude');
  @override
  late final GeneratedColumn<double> altitude = GeneratedColumn<double>(
      'altitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _altitudeAccuracyMeta =
      const VerificationMeta('altitudeAccuracy');
  @override
  late final GeneratedColumn<double> altitudeAccuracy = GeneratedColumn<double>(
      'altitude_accuracy', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _speedMeta = const VerificationMeta('speed');
  @override
  late final GeneratedColumn<double> speed = GeneratedColumn<double>(
      'speed', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _speedAccuracyMeta =
      const VerificationMeta('speedAccuracy');
  @override
  late final GeneratedColumn<double> speedAccuracy = GeneratedColumn<double>(
      'speed_accuracy', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _headingMeta =
      const VerificationMeta('heading');
  @override
  late final GeneratedColumn<double> heading = GeneratedColumn<double>(
      'heading', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _headingAccuracyMeta =
      const VerificationMeta('headingAccuracy');
  @override
  late final GeneratedColumn<double> headingAccuracy = GeneratedColumn<double>(
      'heading_accuracy', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        latitude,
        longitude,
        accuracy,
        altitude,
        altitudeAccuracy,
        speed,
        speedAccuracy,
        heading,
        headingAccuracy
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'location_table_entity';
  @override
  VerificationContext validateIntegrity(
      Insertable<LocationTableEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('accuracy')) {
      context.handle(_accuracyMeta,
          accuracy.isAcceptableOrUnknown(data['accuracy']!, _accuracyMeta));
    }
    if (data.containsKey('altitude')) {
      context.handle(_altitudeMeta,
          altitude.isAcceptableOrUnknown(data['altitude']!, _altitudeMeta));
    }
    if (data.containsKey('altitude_accuracy')) {
      context.handle(
          _altitudeAccuracyMeta,
          altitudeAccuracy.isAcceptableOrUnknown(
              data['altitude_accuracy']!, _altitudeAccuracyMeta));
    }
    if (data.containsKey('speed')) {
      context.handle(
          _speedMeta, speed.isAcceptableOrUnknown(data['speed']!, _speedMeta));
    }
    if (data.containsKey('speed_accuracy')) {
      context.handle(
          _speedAccuracyMeta,
          speedAccuracy.isAcceptableOrUnknown(
              data['speed_accuracy']!, _speedAccuracyMeta));
    }
    if (data.containsKey('heading')) {
      context.handle(_headingMeta,
          heading.isAcceptableOrUnknown(data['heading']!, _headingMeta));
    }
    if (data.containsKey('heading_accuracy')) {
      context.handle(
          _headingAccuracyMeta,
          headingAccuracy.isAcceptableOrUnknown(
              data['heading_accuracy']!, _headingAccuracyMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocationTableEntityData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocationTableEntityData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      latitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}latitude'])!,
      longitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}longitude'])!,
      accuracy: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}accuracy']),
      altitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}altitude']),
      altitudeAccuracy: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}altitude_accuracy']),
      speed: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}speed']),
      speedAccuracy: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}speed_accuracy']),
      heading: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}heading']),
      headingAccuracy: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}heading_accuracy']),
    );
  }

  @override
  $LocationTableEntityTable createAlias(String alias) {
    return $LocationTableEntityTable(attachedDatabase, alias);
  }
}

class LocationTableEntityData extends DataClass
    implements Insertable<LocationTableEntityData> {
  final int id;
  final DateTime? createdAt;
  final double latitude;
  final double longitude;
  final double? accuracy;
  final double? altitude;
  final double? altitudeAccuracy;
  final double? speed;
  final double? speedAccuracy;
  final double? heading;
  final double? headingAccuracy;
  const LocationTableEntityData(
      {required this.id,
      this.createdAt,
      required this.latitude,
      required this.longitude,
      this.accuracy,
      this.altitude,
      this.altitudeAccuracy,
      this.speed,
      this.speedAccuracy,
      this.heading,
      this.headingAccuracy});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    if (!nullToAbsent || accuracy != null) {
      map['accuracy'] = Variable<double>(accuracy);
    }
    if (!nullToAbsent || altitude != null) {
      map['altitude'] = Variable<double>(altitude);
    }
    if (!nullToAbsent || altitudeAccuracy != null) {
      map['altitude_accuracy'] = Variable<double>(altitudeAccuracy);
    }
    if (!nullToAbsent || speed != null) {
      map['speed'] = Variable<double>(speed);
    }
    if (!nullToAbsent || speedAccuracy != null) {
      map['speed_accuracy'] = Variable<double>(speedAccuracy);
    }
    if (!nullToAbsent || heading != null) {
      map['heading'] = Variable<double>(heading);
    }
    if (!nullToAbsent || headingAccuracy != null) {
      map['heading_accuracy'] = Variable<double>(headingAccuracy);
    }
    return map;
  }

  LocationTableEntityCompanion toCompanion(bool nullToAbsent) {
    return LocationTableEntityCompanion(
      id: Value(id),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      latitude: Value(latitude),
      longitude: Value(longitude),
      accuracy: accuracy == null && nullToAbsent
          ? const Value.absent()
          : Value(accuracy),
      altitude: altitude == null && nullToAbsent
          ? const Value.absent()
          : Value(altitude),
      altitudeAccuracy: altitudeAccuracy == null && nullToAbsent
          ? const Value.absent()
          : Value(altitudeAccuracy),
      speed:
          speed == null && nullToAbsent ? const Value.absent() : Value(speed),
      speedAccuracy: speedAccuracy == null && nullToAbsent
          ? const Value.absent()
          : Value(speedAccuracy),
      heading: heading == null && nullToAbsent
          ? const Value.absent()
          : Value(heading),
      headingAccuracy: headingAccuracy == null && nullToAbsent
          ? const Value.absent()
          : Value(headingAccuracy),
    );
  }

  factory LocationTableEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocationTableEntityData(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      accuracy: serializer.fromJson<double?>(json['accuracy']),
      altitude: serializer.fromJson<double?>(json['altitude']),
      altitudeAccuracy: serializer.fromJson<double?>(json['altitudeAccuracy']),
      speed: serializer.fromJson<double?>(json['speed']),
      speedAccuracy: serializer.fromJson<double?>(json['speedAccuracy']),
      heading: serializer.fromJson<double?>(json['heading']),
      headingAccuracy: serializer.fromJson<double?>(json['headingAccuracy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'accuracy': serializer.toJson<double?>(accuracy),
      'altitude': serializer.toJson<double?>(altitude),
      'altitudeAccuracy': serializer.toJson<double?>(altitudeAccuracy),
      'speed': serializer.toJson<double?>(speed),
      'speedAccuracy': serializer.toJson<double?>(speedAccuracy),
      'heading': serializer.toJson<double?>(heading),
      'headingAccuracy': serializer.toJson<double?>(headingAccuracy),
    };
  }

  LocationTableEntityData copyWith(
          {int? id,
          Value<DateTime?> createdAt = const Value.absent(),
          double? latitude,
          double? longitude,
          Value<double?> accuracy = const Value.absent(),
          Value<double?> altitude = const Value.absent(),
          Value<double?> altitudeAccuracy = const Value.absent(),
          Value<double?> speed = const Value.absent(),
          Value<double?> speedAccuracy = const Value.absent(),
          Value<double?> heading = const Value.absent(),
          Value<double?> headingAccuracy = const Value.absent()}) =>
      LocationTableEntityData(
        id: id ?? this.id,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        accuracy: accuracy.present ? accuracy.value : this.accuracy,
        altitude: altitude.present ? altitude.value : this.altitude,
        altitudeAccuracy: altitudeAccuracy.present
            ? altitudeAccuracy.value
            : this.altitudeAccuracy,
        speed: speed.present ? speed.value : this.speed,
        speedAccuracy:
            speedAccuracy.present ? speedAccuracy.value : this.speedAccuracy,
        heading: heading.present ? heading.value : this.heading,
        headingAccuracy: headingAccuracy.present
            ? headingAccuracy.value
            : this.headingAccuracy,
      );
  LocationTableEntityData copyWithCompanion(LocationTableEntityCompanion data) {
    return LocationTableEntityData(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      accuracy: data.accuracy.present ? data.accuracy.value : this.accuracy,
      altitude: data.altitude.present ? data.altitude.value : this.altitude,
      altitudeAccuracy: data.altitudeAccuracy.present
          ? data.altitudeAccuracy.value
          : this.altitudeAccuracy,
      speed: data.speed.present ? data.speed.value : this.speed,
      speedAccuracy: data.speedAccuracy.present
          ? data.speedAccuracy.value
          : this.speedAccuracy,
      heading: data.heading.present ? data.heading.value : this.heading,
      headingAccuracy: data.headingAccuracy.present
          ? data.headingAccuracy.value
          : this.headingAccuracy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocationTableEntityData(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('accuracy: $accuracy, ')
          ..write('altitude: $altitude, ')
          ..write('altitudeAccuracy: $altitudeAccuracy, ')
          ..write('speed: $speed, ')
          ..write('speedAccuracy: $speedAccuracy, ')
          ..write('heading: $heading, ')
          ..write('headingAccuracy: $headingAccuracy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      createdAt,
      latitude,
      longitude,
      accuracy,
      altitude,
      altitudeAccuracy,
      speed,
      speedAccuracy,
      heading,
      headingAccuracy);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocationTableEntityData &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.accuracy == this.accuracy &&
          other.altitude == this.altitude &&
          other.altitudeAccuracy == this.altitudeAccuracy &&
          other.speed == this.speed &&
          other.speedAccuracy == this.speedAccuracy &&
          other.heading == this.heading &&
          other.headingAccuracy == this.headingAccuracy);
}

class LocationTableEntityCompanion
    extends UpdateCompanion<LocationTableEntityData> {
  final Value<int> id;
  final Value<DateTime?> createdAt;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<double?> accuracy;
  final Value<double?> altitude;
  final Value<double?> altitudeAccuracy;
  final Value<double?> speed;
  final Value<double?> speedAccuracy;
  final Value<double?> heading;
  final Value<double?> headingAccuracy;
  const LocationTableEntityCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.accuracy = const Value.absent(),
    this.altitude = const Value.absent(),
    this.altitudeAccuracy = const Value.absent(),
    this.speed = const Value.absent(),
    this.speedAccuracy = const Value.absent(),
    this.heading = const Value.absent(),
    this.headingAccuracy = const Value.absent(),
  });
  LocationTableEntityCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    required double latitude,
    required double longitude,
    this.accuracy = const Value.absent(),
    this.altitude = const Value.absent(),
    this.altitudeAccuracy = const Value.absent(),
    this.speed = const Value.absent(),
    this.speedAccuracy = const Value.absent(),
    this.heading = const Value.absent(),
    this.headingAccuracy = const Value.absent(),
  })  : latitude = Value(latitude),
        longitude = Value(longitude);
  static Insertable<LocationTableEntityData> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<double>? accuracy,
    Expression<double>? altitude,
    Expression<double>? altitudeAccuracy,
    Expression<double>? speed,
    Expression<double>? speedAccuracy,
    Expression<double>? heading,
    Expression<double>? headingAccuracy,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (accuracy != null) 'accuracy': accuracy,
      if (altitude != null) 'altitude': altitude,
      if (altitudeAccuracy != null) 'altitude_accuracy': altitudeAccuracy,
      if (speed != null) 'speed': speed,
      if (speedAccuracy != null) 'speed_accuracy': speedAccuracy,
      if (heading != null) 'heading': heading,
      if (headingAccuracy != null) 'heading_accuracy': headingAccuracy,
    });
  }

  LocationTableEntityCompanion copyWith(
      {Value<int>? id,
      Value<DateTime?>? createdAt,
      Value<double>? latitude,
      Value<double>? longitude,
      Value<double?>? accuracy,
      Value<double?>? altitude,
      Value<double?>? altitudeAccuracy,
      Value<double?>? speed,
      Value<double?>? speedAccuracy,
      Value<double?>? heading,
      Value<double?>? headingAccuracy}) {
    return LocationTableEntityCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      accuracy: accuracy ?? this.accuracy,
      altitude: altitude ?? this.altitude,
      altitudeAccuracy: altitudeAccuracy ?? this.altitudeAccuracy,
      speed: speed ?? this.speed,
      speedAccuracy: speedAccuracy ?? this.speedAccuracy,
      heading: heading ?? this.heading,
      headingAccuracy: headingAccuracy ?? this.headingAccuracy,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (accuracy.present) {
      map['accuracy'] = Variable<double>(accuracy.value);
    }
    if (altitude.present) {
      map['altitude'] = Variable<double>(altitude.value);
    }
    if (altitudeAccuracy.present) {
      map['altitude_accuracy'] = Variable<double>(altitudeAccuracy.value);
    }
    if (speed.present) {
      map['speed'] = Variable<double>(speed.value);
    }
    if (speedAccuracy.present) {
      map['speed_accuracy'] = Variable<double>(speedAccuracy.value);
    }
    if (heading.present) {
      map['heading'] = Variable<double>(heading.value);
    }
    if (headingAccuracy.present) {
      map['heading_accuracy'] = Variable<double>(headingAccuracy.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocationTableEntityCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('accuracy: $accuracy, ')
          ..write('altitude: $altitude, ')
          ..write('altitudeAccuracy: $altitudeAccuracy, ')
          ..write('speed: $speed, ')
          ..write('speedAccuracy: $speedAccuracy, ')
          ..write('heading: $heading, ')
          ..write('headingAccuracy: $headingAccuracy')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LocationTableEntityTable locationTableEntity =
      $LocationTableEntityTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [locationTableEntity];
}

typedef $$LocationTableEntityTableCreateCompanionBuilder
    = LocationTableEntityCompanion Function({
  Value<int> id,
  Value<DateTime?> createdAt,
  required double latitude,
  required double longitude,
  Value<double?> accuracy,
  Value<double?> altitude,
  Value<double?> altitudeAccuracy,
  Value<double?> speed,
  Value<double?> speedAccuracy,
  Value<double?> heading,
  Value<double?> headingAccuracy,
});
typedef $$LocationTableEntityTableUpdateCompanionBuilder
    = LocationTableEntityCompanion Function({
  Value<int> id,
  Value<DateTime?> createdAt,
  Value<double> latitude,
  Value<double> longitude,
  Value<double?> accuracy,
  Value<double?> altitude,
  Value<double?> altitudeAccuracy,
  Value<double?> speed,
  Value<double?> speedAccuracy,
  Value<double?> heading,
  Value<double?> headingAccuracy,
});

class $$LocationTableEntityTableFilterComposer
    extends Composer<_$AppDatabase, $LocationTableEntityTable> {
  $$LocationTableEntityTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get accuracy => $composableBuilder(
      column: $table.accuracy, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get altitude => $composableBuilder(
      column: $table.altitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get altitudeAccuracy => $composableBuilder(
      column: $table.altitudeAccuracy,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get speed => $composableBuilder(
      column: $table.speed, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get speedAccuracy => $composableBuilder(
      column: $table.speedAccuracy, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get heading => $composableBuilder(
      column: $table.heading, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get headingAccuracy => $composableBuilder(
      column: $table.headingAccuracy,
      builder: (column) => ColumnFilters(column));
}

class $$LocationTableEntityTableOrderingComposer
    extends Composer<_$AppDatabase, $LocationTableEntityTable> {
  $$LocationTableEntityTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get accuracy => $composableBuilder(
      column: $table.accuracy, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get altitude => $composableBuilder(
      column: $table.altitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get altitudeAccuracy => $composableBuilder(
      column: $table.altitudeAccuracy,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get speed => $composableBuilder(
      column: $table.speed, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get speedAccuracy => $composableBuilder(
      column: $table.speedAccuracy,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get heading => $composableBuilder(
      column: $table.heading, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get headingAccuracy => $composableBuilder(
      column: $table.headingAccuracy,
      builder: (column) => ColumnOrderings(column));
}

class $$LocationTableEntityTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocationTableEntityTable> {
  $$LocationTableEntityTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<double> get accuracy =>
      $composableBuilder(column: $table.accuracy, builder: (column) => column);

  GeneratedColumn<double> get altitude =>
      $composableBuilder(column: $table.altitude, builder: (column) => column);

  GeneratedColumn<double> get altitudeAccuracy => $composableBuilder(
      column: $table.altitudeAccuracy, builder: (column) => column);

  GeneratedColumn<double> get speed =>
      $composableBuilder(column: $table.speed, builder: (column) => column);

  GeneratedColumn<double> get speedAccuracy => $composableBuilder(
      column: $table.speedAccuracy, builder: (column) => column);

  GeneratedColumn<double> get heading =>
      $composableBuilder(column: $table.heading, builder: (column) => column);

  GeneratedColumn<double> get headingAccuracy => $composableBuilder(
      column: $table.headingAccuracy, builder: (column) => column);
}

class $$LocationTableEntityTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LocationTableEntityTable,
    LocationTableEntityData,
    $$LocationTableEntityTableFilterComposer,
    $$LocationTableEntityTableOrderingComposer,
    $$LocationTableEntityTableAnnotationComposer,
    $$LocationTableEntityTableCreateCompanionBuilder,
    $$LocationTableEntityTableUpdateCompanionBuilder,
    (
      LocationTableEntityData,
      BaseReferences<_$AppDatabase, $LocationTableEntityTable,
          LocationTableEntityData>
    ),
    LocationTableEntityData,
    PrefetchHooks Function()> {
  $$LocationTableEntityTableTableManager(
      _$AppDatabase db, $LocationTableEntityTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocationTableEntityTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocationTableEntityTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocationTableEntityTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<double> latitude = const Value.absent(),
            Value<double> longitude = const Value.absent(),
            Value<double?> accuracy = const Value.absent(),
            Value<double?> altitude = const Value.absent(),
            Value<double?> altitudeAccuracy = const Value.absent(),
            Value<double?> speed = const Value.absent(),
            Value<double?> speedAccuracy = const Value.absent(),
            Value<double?> heading = const Value.absent(),
            Value<double?> headingAccuracy = const Value.absent(),
          }) =>
              LocationTableEntityCompanion(
            id: id,
            createdAt: createdAt,
            latitude: latitude,
            longitude: longitude,
            accuracy: accuracy,
            altitude: altitude,
            altitudeAccuracy: altitudeAccuracy,
            speed: speed,
            speedAccuracy: speedAccuracy,
            heading: heading,
            headingAccuracy: headingAccuracy,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            required double latitude,
            required double longitude,
            Value<double?> accuracy = const Value.absent(),
            Value<double?> altitude = const Value.absent(),
            Value<double?> altitudeAccuracy = const Value.absent(),
            Value<double?> speed = const Value.absent(),
            Value<double?> speedAccuracy = const Value.absent(),
            Value<double?> heading = const Value.absent(),
            Value<double?> headingAccuracy = const Value.absent(),
          }) =>
              LocationTableEntityCompanion.insert(
            id: id,
            createdAt: createdAt,
            latitude: latitude,
            longitude: longitude,
            accuracy: accuracy,
            altitude: altitude,
            altitudeAccuracy: altitudeAccuracy,
            speed: speed,
            speedAccuracy: speedAccuracy,
            heading: heading,
            headingAccuracy: headingAccuracy,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocationTableEntityTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LocationTableEntityTable,
    LocationTableEntityData,
    $$LocationTableEntityTableFilterComposer,
    $$LocationTableEntityTableOrderingComposer,
    $$LocationTableEntityTableAnnotationComposer,
    $$LocationTableEntityTableCreateCompanionBuilder,
    $$LocationTableEntityTableUpdateCompanionBuilder,
    (
      LocationTableEntityData,
      BaseReferences<_$AppDatabase, $LocationTableEntityTable,
          LocationTableEntityData>
    ),
    LocationTableEntityData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LocationTableEntityTableTableManager get locationTableEntity =>
      $$LocationTableEntityTableTableManager(_db, _db.locationTableEntity);
}
