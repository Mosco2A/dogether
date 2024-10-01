// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PhoneContactStruct extends FFFirebaseStruct {
  PhoneContactStruct({
    String? displayName,
    String? phone,
    bool? reponse,
    bool? contactExistInBase,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _displayName = displayName,
        _phone = phone,
        _reponse = reponse,
        _contactExistInBase = contactExistInBase,
        super(firestoreUtilData);

  // "displayName" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  set displayName(String? val) => _displayName = val;

  bool hasDisplayName() => _displayName != null;

  // "phone" field.
  String? _phone;
  String get phone => _phone ?? '';
  set phone(String? val) => _phone = val;

  bool hasPhone() => _phone != null;

  // "reponse" field.
  bool? _reponse;
  bool get reponse => _reponse ?? false;
  set reponse(bool? val) => _reponse = val;

  bool hasReponse() => _reponse != null;

  // "contactExistInBase" field.
  bool? _contactExistInBase;
  bool get contactExistInBase => _contactExistInBase ?? false;
  set contactExistInBase(bool? val) => _contactExistInBase = val;

  bool hasContactExistInBase() => _contactExistInBase != null;

  static PhoneContactStruct fromMap(Map<String, dynamic> data) =>
      PhoneContactStruct(
        displayName: data['displayName'] as String?,
        phone: data['phone'] as String?,
        reponse: data['reponse'] as bool?,
        contactExistInBase: data['contactExistInBase'] as bool?,
      );

  static PhoneContactStruct? maybeFromMap(dynamic data) => data is Map
      ? PhoneContactStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'displayName': _displayName,
        'phone': _phone,
        'reponse': _reponse,
        'contactExistInBase': _contactExistInBase,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'displayName': serializeParam(
          _displayName,
          ParamType.String,
        ),
        'phone': serializeParam(
          _phone,
          ParamType.String,
        ),
        'reponse': serializeParam(
          _reponse,
          ParamType.bool,
        ),
        'contactExistInBase': serializeParam(
          _contactExistInBase,
          ParamType.bool,
        ),
      }.withoutNulls;

  static PhoneContactStruct fromSerializableMap(Map<String, dynamic> data) =>
      PhoneContactStruct(
        displayName: deserializeParam(
          data['displayName'],
          ParamType.String,
          false,
        ),
        phone: deserializeParam(
          data['phone'],
          ParamType.String,
          false,
        ),
        reponse: deserializeParam(
          data['reponse'],
          ParamType.bool,
          false,
        ),
        contactExistInBase: deserializeParam(
          data['contactExistInBase'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'PhoneContactStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PhoneContactStruct &&
        displayName == other.displayName &&
        phone == other.phone &&
        reponse == other.reponse &&
        contactExistInBase == other.contactExistInBase;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([displayName, phone, reponse, contactExistInBase]);
}

PhoneContactStruct createPhoneContactStruct({
  String? displayName,
  String? phone,
  bool? reponse,
  bool? contactExistInBase,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PhoneContactStruct(
      displayName: displayName,
      phone: phone,
      reponse: reponse,
      contactExistInBase: contactExistInBase,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PhoneContactStruct? updatePhoneContactStruct(
  PhoneContactStruct? phoneContact, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    phoneContact
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPhoneContactStructData(
  Map<String, dynamic> firestoreData,
  PhoneContactStruct? phoneContact,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (phoneContact == null) {
    return;
  }
  if (phoneContact.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && phoneContact.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final phoneContactData =
      getPhoneContactFirestoreData(phoneContact, forFieldValue);
  final nestedData =
      phoneContactData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = phoneContact.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPhoneContactFirestoreData(
  PhoneContactStruct? phoneContact, [
  bool forFieldValue = false,
]) {
  if (phoneContact == null) {
    return {};
  }
  final firestoreData = mapToFirestore(phoneContact.toMap());

  // Add any Firestore field values
  phoneContact.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPhoneContactListFirestoreData(
  List<PhoneContactStruct>? phoneContacts,
) =>
    phoneContacts?.map((e) => getPhoneContactFirestoreData(e, true)).toList() ??
    [];
