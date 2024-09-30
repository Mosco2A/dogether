import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class InvitationRecuesRecord extends FirestoreRecord {
  InvitationRecuesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "rInvitation" field.
  InvitationStruct? _rInvitation;
  InvitationStruct get rInvitation => _rInvitation ?? InvitationStruct();
  bool hasRInvitation() => _rInvitation != null;

  void _initializeFields() {
    _rInvitation = InvitationStruct.maybeFromMap(snapshotData['rInvitation']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('invitationRecues');

  static Stream<InvitationRecuesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => InvitationRecuesRecord.fromSnapshot(s));

  static Future<InvitationRecuesRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => InvitationRecuesRecord.fromSnapshot(s));

  static InvitationRecuesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      InvitationRecuesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static InvitationRecuesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      InvitationRecuesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'InvitationRecuesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is InvitationRecuesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createInvitationRecuesRecordData({
  InvitationStruct? rInvitation,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'rInvitation': InvitationStruct().toMap(),
    }.withoutNulls,
  );

  // Handle nested data for "rInvitation" field.
  addInvitationStructData(firestoreData, rInvitation, 'rInvitation');

  return firestoreData;
}

class InvitationRecuesRecordDocumentEquality
    implements Equality<InvitationRecuesRecord> {
  const InvitationRecuesRecordDocumentEquality();

  @override
  bool equals(InvitationRecuesRecord? e1, InvitationRecuesRecord? e2) {
    return e1?.rInvitation == e2?.rInvitation;
  }

  @override
  int hash(InvitationRecuesRecord? e) =>
      const ListEquality().hash([e?.rInvitation]);

  @override
  bool isValidKey(Object? o) => o is InvitationRecuesRecord;
}
