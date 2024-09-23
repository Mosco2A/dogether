// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DureeDateHeureStruct extends FFFirebaseStruct {
  DureeDateHeureStruct({
    String? duree,
    DateTime? date,
    String? heureMinute,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _duree = duree,
        _date = date,
        _heureMinute = heureMinute,
        super(firestoreUtilData);

  // "Duree" field.
  String? _duree;
  String get duree => _duree ?? '';
  set duree(String? val) => _duree = val;

  bool hasDuree() => _duree != null;

  // "Date" field.
  DateTime? _date;
  DateTime? get date => _date;
  set date(DateTime? val) => _date = val;

  bool hasDate() => _date != null;

  // "HeureMinute" field.
  String? _heureMinute;
  String get heureMinute => _heureMinute ?? '';
  set heureMinute(String? val) => _heureMinute = val;

  bool hasHeureMinute() => _heureMinute != null;

  static DureeDateHeureStruct fromMap(Map<String, dynamic> data) =>
      DureeDateHeureStruct(
        duree: data['Duree'] as String?,
        date: data['Date'] as DateTime?,
        heureMinute: data['HeureMinute'] as String?,
      );

  static DureeDateHeureStruct? maybeFromMap(dynamic data) => data is Map
      ? DureeDateHeureStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'Duree': _duree,
        'Date': _date,
        'HeureMinute': _heureMinute,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'Duree': serializeParam(
          _duree,
          ParamType.String,
        ),
        'Date': serializeParam(
          _date,
          ParamType.DateTime,
        ),
        'HeureMinute': serializeParam(
          _heureMinute,
          ParamType.String,
        ),
      }.withoutNulls;

  static DureeDateHeureStruct fromSerializableMap(Map<String, dynamic> data) =>
      DureeDateHeureStruct(
        duree: deserializeParam(
          data['Duree'],
          ParamType.String,
          false,
        ),
        date: deserializeParam(
          data['Date'],
          ParamType.DateTime,
          false,
        ),
        heureMinute: deserializeParam(
          data['HeureMinute'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'DureeDateHeureStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DureeDateHeureStruct &&
        duree == other.duree &&
        date == other.date &&
        heureMinute == other.heureMinute;
  }

  @override
  int get hashCode => const ListEquality().hash([duree, date, heureMinute]);
}

DureeDateHeureStruct createDureeDateHeureStruct({
  String? duree,
  DateTime? date,
  String? heureMinute,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    DureeDateHeureStruct(
      duree: duree,
      date: date,
      heureMinute: heureMinute,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

DureeDateHeureStruct? updateDureeDateHeureStruct(
  DureeDateHeureStruct? dureeDateHeure, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    dureeDateHeure
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addDureeDateHeureStructData(
  Map<String, dynamic> firestoreData,
  DureeDateHeureStruct? dureeDateHeure,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (dureeDateHeure == null) {
    return;
  }
  if (dureeDateHeure.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && dureeDateHeure.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final dureeDateHeureData =
      getDureeDateHeureFirestoreData(dureeDateHeure, forFieldValue);
  final nestedData =
      dureeDateHeureData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = dureeDateHeure.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getDureeDateHeureFirestoreData(
  DureeDateHeureStruct? dureeDateHeure, [
  bool forFieldValue = false,
]) {
  if (dureeDateHeure == null) {
    return {};
  }
  final firestoreData = mapToFirestore(dureeDateHeure.toMap());

  // Add any Firestore field values
  dureeDateHeure.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getDureeDateHeureListFirestoreData(
  List<DureeDateHeureStruct>? dureeDateHeures,
) =>
    dureeDateHeures
        ?.map((e) => getDureeDateHeureFirestoreData(e, true))
        .toList() ??
    [];
