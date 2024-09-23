// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ReponseStruct extends FFFirebaseStruct {
  ReponseStruct({
    List<ContactStruct>? rContact,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _rContact = rContact,
        super(firestoreUtilData);

  // "rContact" field.
  List<ContactStruct>? _rContact;
  List<ContactStruct> get rContact => _rContact ?? const [];
  set rContact(List<ContactStruct>? val) => _rContact = val;

  void updateRContact(Function(List<ContactStruct>) updateFn) {
    updateFn(_rContact ??= []);
  }

  bool hasRContact() => _rContact != null;

  static ReponseStruct fromMap(Map<String, dynamic> data) => ReponseStruct(
        rContact: getStructList(
          data['rContact'],
          ContactStruct.fromMap,
        ),
      );

  static ReponseStruct? maybeFromMap(dynamic data) =>
      data is Map ? ReponseStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'rContact': _rContact?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'rContact': serializeParam(
          _rContact,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static ReponseStruct fromSerializableMap(Map<String, dynamic> data) =>
      ReponseStruct(
        rContact: deserializeStructParam<ContactStruct>(
          data['rContact'],
          ParamType.DataStruct,
          true,
          structBuilder: ContactStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'ReponseStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ReponseStruct &&
        listEquality.equals(rContact, other.rContact);
  }

  @override
  int get hashCode => const ListEquality().hash([rContact]);
}

ReponseStruct createReponseStruct({
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ReponseStruct(
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ReponseStruct? updateReponseStruct(
  ReponseStruct? reponse, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    reponse
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addReponseStructData(
  Map<String, dynamic> firestoreData,
  ReponseStruct? reponse,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (reponse == null) {
    return;
  }
  if (reponse.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && reponse.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final reponseData = getReponseFirestoreData(reponse, forFieldValue);
  final nestedData = reponseData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = reponse.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getReponseFirestoreData(
  ReponseStruct? reponse, [
  bool forFieldValue = false,
]) {
  if (reponse == null) {
    return {};
  }
  final firestoreData = mapToFirestore(reponse.toMap());

  // Add any Firestore field values
  reponse.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getReponseListFirestoreData(
  List<ReponseStruct>? reponses,
) =>
    reponses?.map((e) => getReponseFirestoreData(e, true)).toList() ?? [];
