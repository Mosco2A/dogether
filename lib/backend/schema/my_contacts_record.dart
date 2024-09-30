import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MyContactsRecord extends FirestoreRecord {
  MyContactsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "phone" field.
  String? _phone;
  String get phone => _phone ?? '';
  bool hasPhone() => _phone != null;

  // "validatedUser" field.
  bool? _validatedUser;
  bool get validatedUser => _validatedUser ?? false;
  bool hasValidatedUser() => _validatedUser != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _phone = snapshotData['phone'] as String?;
    _validatedUser = snapshotData['validatedUser'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('myContacts');

  static Stream<MyContactsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MyContactsRecord.fromSnapshot(s));

  static Future<MyContactsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MyContactsRecord.fromSnapshot(s));

  static MyContactsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      MyContactsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MyContactsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MyContactsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MyContactsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MyContactsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMyContactsRecordData({
  String? name,
  String? phone,
  bool? validatedUser,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'phone': phone,
      'validatedUser': validatedUser,
    }.withoutNulls,
  );

  return firestoreData;
}

class MyContactsRecordDocumentEquality implements Equality<MyContactsRecord> {
  const MyContactsRecordDocumentEquality();

  @override
  bool equals(MyContactsRecord? e1, MyContactsRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.phone == e2?.phone &&
        e1?.validatedUser == e2?.validatedUser;
  }

  @override
  int hash(MyContactsRecord? e) =>
      const ListEquality().hash([e?.name, e?.phone, e?.validatedUser]);

  @override
  bool isValidKey(Object? o) => o is MyContactsRecord;
}
