// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ContactStruct extends FFFirebaseStruct {
  ContactStruct({
    String? name,
    String? cRef,
    String? cPrenom,
    String? cNom,
    String? cPhone,
    bool? cExiste,
    bool? ouiNon,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _cRef = cRef,
        _cPrenom = cPrenom,
        _cNom = cNom,
        _cPhone = cPhone,
        _cExiste = cExiste,
        _ouiNon = ouiNon,
        super(firestoreUtilData);

  // "Name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "cRef" field.
  String? _cRef;
  String get cRef => _cRef ?? '';
  set cRef(String? val) => _cRef = val;

  bool hasCRef() => _cRef != null;

  // "cPrenom" field.
  String? _cPrenom;
  String get cPrenom => _cPrenom ?? '';
  set cPrenom(String? val) => _cPrenom = val;

  bool hasCPrenom() => _cPrenom != null;

  // "cNom" field.
  String? _cNom;
  String get cNom => _cNom ?? '';
  set cNom(String? val) => _cNom = val;

  bool hasCNom() => _cNom != null;

  // "cPhone" field.
  String? _cPhone;
  String get cPhone => _cPhone ?? '';
  set cPhone(String? val) => _cPhone = val;

  bool hasCPhone() => _cPhone != null;

  // "cExiste" field.
  bool? _cExiste;
  bool get cExiste => _cExiste ?? false;
  set cExiste(bool? val) => _cExiste = val;

  bool hasCExiste() => _cExiste != null;

  // "ouiNon" field.
  bool? _ouiNon;
  bool get ouiNon => _ouiNon ?? false;
  set ouiNon(bool? val) => _ouiNon = val;

  bool hasOuiNon() => _ouiNon != null;

  static ContactStruct fromMap(Map<String, dynamic> data) => ContactStruct(
        name: data['Name'] as String?,
        cRef: data['cRef'] as String?,
        cPrenom: data['cPrenom'] as String?,
        cNom: data['cNom'] as String?,
        cPhone: data['cPhone'] as String?,
        cExiste: data['cExiste'] as bool?,
        ouiNon: data['ouiNon'] as bool?,
      );

  static ContactStruct? maybeFromMap(dynamic data) =>
      data is Map ? ContactStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'Name': _name,
        'cRef': _cRef,
        'cPrenom': _cPrenom,
        'cNom': _cNom,
        'cPhone': _cPhone,
        'cExiste': _cExiste,
        'ouiNon': _ouiNon,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'Name': serializeParam(
          _name,
          ParamType.String,
        ),
        'cRef': serializeParam(
          _cRef,
          ParamType.String,
        ),
        'cPrenom': serializeParam(
          _cPrenom,
          ParamType.String,
        ),
        'cNom': serializeParam(
          _cNom,
          ParamType.String,
        ),
        'cPhone': serializeParam(
          _cPhone,
          ParamType.String,
        ),
        'cExiste': serializeParam(
          _cExiste,
          ParamType.bool,
        ),
        'ouiNon': serializeParam(
          _ouiNon,
          ParamType.bool,
        ),
      }.withoutNulls;

  static ContactStruct fromSerializableMap(Map<String, dynamic> data) =>
      ContactStruct(
        name: deserializeParam(
          data['Name'],
          ParamType.String,
          false,
        ),
        cRef: deserializeParam(
          data['cRef'],
          ParamType.String,
          false,
        ),
        cPrenom: deserializeParam(
          data['cPrenom'],
          ParamType.String,
          false,
        ),
        cNom: deserializeParam(
          data['cNom'],
          ParamType.String,
          false,
        ),
        cPhone: deserializeParam(
          data['cPhone'],
          ParamType.String,
          false,
        ),
        cExiste: deserializeParam(
          data['cExiste'],
          ParamType.bool,
          false,
        ),
        ouiNon: deserializeParam(
          data['ouiNon'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'ContactStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ContactStruct &&
        name == other.name &&
        cRef == other.cRef &&
        cPrenom == other.cPrenom &&
        cNom == other.cNom &&
        cPhone == other.cPhone &&
        cExiste == other.cExiste &&
        ouiNon == other.ouiNon;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([name, cRef, cPrenom, cNom, cPhone, cExiste, ouiNon]);
}

ContactStruct createContactStruct({
  String? name,
  String? cRef,
  String? cPrenom,
  String? cNom,
  String? cPhone,
  bool? cExiste,
  bool? ouiNon,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ContactStruct(
      name: name,
      cRef: cRef,
      cPrenom: cPrenom,
      cNom: cNom,
      cPhone: cPhone,
      cExiste: cExiste,
      ouiNon: ouiNon,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ContactStruct? updateContactStruct(
  ContactStruct? contact, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    contact
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addContactStructData(
  Map<String, dynamic> firestoreData,
  ContactStruct? contact,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (contact == null) {
    return;
  }
  if (contact.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && contact.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final contactData = getContactFirestoreData(contact, forFieldValue);
  final nestedData = contactData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = contact.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getContactFirestoreData(
  ContactStruct? contact, [
  bool forFieldValue = false,
]) {
  if (contact == null) {
    return {};
  }
  final firestoreData = mapToFirestore(contact.toMap());

  // Add any Firestore field values
  contact.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getContactListFirestoreData(
  List<ContactStruct>? contacts,
) =>
    contacts?.map((e) => getContactFirestoreData(e, true)).toList() ?? [];
