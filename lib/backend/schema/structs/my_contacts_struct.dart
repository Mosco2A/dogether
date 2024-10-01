// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MyContactsStruct extends FFFirebaseStruct {
  MyContactsStruct({
    String? name,
    String? phone,
    bool? validatedUser,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _phone = phone,
        _validatedUser = validatedUser,
        super(firestoreUtilData);

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "phone" field.
  String? _phone;
  String get phone => _phone ?? '';
  set phone(String? val) => _phone = val;

  bool hasPhone() => _phone != null;

  // "validatedUser" field.
  bool? _validatedUser;
  bool get validatedUser => _validatedUser ?? false;
  set validatedUser(bool? val) => _validatedUser = val;

  bool hasValidatedUser() => _validatedUser != null;

  static MyContactsStruct fromMap(Map<String, dynamic> data) =>
      MyContactsStruct(
        name: data['name'] as String?,
        phone: data['phone'] as String?,
        validatedUser: data['validatedUser'] as bool?,
      );

  static MyContactsStruct? maybeFromMap(dynamic data) => data is Map
      ? MyContactsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'phone': _phone,
        'validatedUser': _validatedUser,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'phone': serializeParam(
          _phone,
          ParamType.String,
        ),
        'validatedUser': serializeParam(
          _validatedUser,
          ParamType.bool,
        ),
      }.withoutNulls;

  static MyContactsStruct fromSerializableMap(Map<String, dynamic> data) =>
      MyContactsStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        phone: deserializeParam(
          data['phone'],
          ParamType.String,
          false,
        ),
        validatedUser: deserializeParam(
          data['validatedUser'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'MyContactsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is MyContactsStruct &&
        name == other.name &&
        phone == other.phone &&
        validatedUser == other.validatedUser;
  }

  @override
  int get hashCode => const ListEquality().hash([name, phone, validatedUser]);
}

MyContactsStruct createMyContactsStruct({
  String? name,
  String? phone,
  bool? validatedUser,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    MyContactsStruct(
      name: name,
      phone: phone,
      validatedUser: validatedUser,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

MyContactsStruct? updateMyContactsStruct(
  MyContactsStruct? myContacts, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    myContacts
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addMyContactsStructData(
  Map<String, dynamic> firestoreData,
  MyContactsStruct? myContacts,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (myContacts == null) {
    return;
  }
  if (myContacts.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && myContacts.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final myContactsData = getMyContactsFirestoreData(myContacts, forFieldValue);
  final nestedData = myContactsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = myContacts.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getMyContactsFirestoreData(
  MyContactsStruct? myContacts, [
  bool forFieldValue = false,
]) {
  if (myContacts == null) {
    return {};
  }
  final firestoreData = mapToFirestore(myContacts.toMap());

  // Add any Firestore field values
  myContacts.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getMyContactsListFirestoreData(
  List<MyContactsStruct>? myContactss,
) =>
    myContactss?.map((e) => getMyContactsFirestoreData(e, true)).toList() ?? [];
