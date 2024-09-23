// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DureeStruct extends FFFirebaseStruct {
  DureeStruct({
    String? typeDuree,
    DureeDateHeureStruct? dateHeure,
    String? typeDeDuree,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _typeDuree = typeDuree,
        _dateHeure = dateHeure,
        _typeDeDuree = typeDeDuree,
        super(firestoreUtilData);

  // "typeDuree" field.
  String? _typeDuree;
  String get typeDuree => _typeDuree ?? '';
  set typeDuree(String? val) => _typeDuree = val;

  bool hasTypeDuree() => _typeDuree != null;

  // "DateHeure" field.
  DureeDateHeureStruct? _dateHeure;
  DureeDateHeureStruct get dateHeure => _dateHeure ?? DureeDateHeureStruct();
  set dateHeure(DureeDateHeureStruct? val) => _dateHeure = val;

  void updateDateHeure(Function(DureeDateHeureStruct) updateFn) {
    updateFn(_dateHeure ??= DureeDateHeureStruct());
  }

  bool hasDateHeure() => _dateHeure != null;

  // "TypeDeDuree" field.
  String? _typeDeDuree;
  String get typeDeDuree => _typeDeDuree ?? '';
  set typeDeDuree(String? val) => _typeDeDuree = val;

  bool hasTypeDeDuree() => _typeDeDuree != null;

  static DureeStruct fromMap(Map<String, dynamic> data) => DureeStruct(
        typeDuree: data['typeDuree'] as String?,
        dateHeure: DureeDateHeureStruct.maybeFromMap(data['DateHeure']),
        typeDeDuree: data['TypeDeDuree'] as String?,
      );

  static DureeStruct? maybeFromMap(dynamic data) =>
      data is Map ? DureeStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'typeDuree': _typeDuree,
        'DateHeure': _dateHeure?.toMap(),
        'TypeDeDuree': _typeDeDuree,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'typeDuree': serializeParam(
          _typeDuree,
          ParamType.String,
        ),
        'DateHeure': serializeParam(
          _dateHeure,
          ParamType.DataStruct,
        ),
        'TypeDeDuree': serializeParam(
          _typeDeDuree,
          ParamType.String,
        ),
      }.withoutNulls;

  static DureeStruct fromSerializableMap(Map<String, dynamic> data) =>
      DureeStruct(
        typeDuree: deserializeParam(
          data['typeDuree'],
          ParamType.String,
          false,
        ),
        dateHeure: deserializeStructParam(
          data['DateHeure'],
          ParamType.DataStruct,
          false,
          structBuilder: DureeDateHeureStruct.fromSerializableMap,
        ),
        typeDeDuree: deserializeParam(
          data['TypeDeDuree'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'DureeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DureeStruct &&
        typeDuree == other.typeDuree &&
        dateHeure == other.dateHeure &&
        typeDeDuree == other.typeDeDuree;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([typeDuree, dateHeure, typeDeDuree]);
}

DureeStruct createDureeStruct({
  String? typeDuree,
  DureeDateHeureStruct? dateHeure,
  String? typeDeDuree,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    DureeStruct(
      typeDuree: typeDuree,
      dateHeure:
          dateHeure ?? (clearUnsetFields ? DureeDateHeureStruct() : null),
      typeDeDuree: typeDeDuree,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

DureeStruct? updateDureeStruct(
  DureeStruct? duree, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    duree
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addDureeStructData(
  Map<String, dynamic> firestoreData,
  DureeStruct? duree,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (duree == null) {
    return;
  }
  if (duree.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && duree.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final dureeData = getDureeFirestoreData(duree, forFieldValue);
  final nestedData = dureeData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = duree.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getDureeFirestoreData(
  DureeStruct? duree, [
  bool forFieldValue = false,
]) {
  if (duree == null) {
    return {};
  }
  final firestoreData = mapToFirestore(duree.toMap());

  // Handle nested data for "DateHeure" field.
  addDureeDateHeureStructData(
    firestoreData,
    duree.hasDateHeure() ? duree.dateHeure : null,
    'DateHeure',
    forFieldValue,
  );

  // Add any Firestore field values
  duree.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getDureeListFirestoreData(
  List<DureeStruct>? durees,
) =>
    durees?.map((e) => getDureeFirestoreData(e, true)).toList() ?? [];
