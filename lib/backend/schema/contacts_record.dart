import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ContactsRecord extends FirestoreRecord {
  ContactsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "cContact" field.
  ContactStruct? _cContact;
  ContactStruct get cContact => _cContact ?? ContactStruct();
  bool hasCContact() => _cContact != null;

  void _initializeFields() {
    _cContact = ContactStruct.maybeFromMap(snapshotData['cContact']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('contacts');

  static Stream<ContactsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ContactsRecord.fromSnapshot(s));

  static Future<ContactsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ContactsRecord.fromSnapshot(s));

  static ContactsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ContactsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ContactsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ContactsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ContactsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ContactsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createContactsRecordData({
  ContactStruct? cContact,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'cContact': ContactStruct().toMap(),
    }.withoutNulls,
  );

  // Handle nested data for "cContact" field.
  addContactStructData(firestoreData, cContact, 'cContact');

  return firestoreData;
}

class ContactsRecordDocumentEquality implements Equality<ContactsRecord> {
  const ContactsRecordDocumentEquality();

  @override
  bool equals(ContactsRecord? e1, ContactsRecord? e2) {
    return e1?.cContact == e2?.cContact;
  }

  @override
  int hash(ContactsRecord? e) => const ListEquality().hash([e?.cContact]);

  @override
  bool isValidKey(Object? o) => o is ContactsRecord;
}
