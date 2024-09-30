import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class InvitationsEmisesRecord extends FirestoreRecord {
  InvitationsEmisesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "eInvitation" field.
  InvitationStruct? _eInvitation;
  InvitationStruct get eInvitation => _eInvitation ?? InvitationStruct();
  bool hasEInvitation() => _eInvitation != null;

  void _initializeFields() {
    _eInvitation = InvitationStruct.maybeFromMap(snapshotData['eInvitation']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('invitationsEmises');

  static Stream<InvitationsEmisesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => InvitationsEmisesRecord.fromSnapshot(s));

  static Future<InvitationsEmisesRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => InvitationsEmisesRecord.fromSnapshot(s));

  static InvitationsEmisesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      InvitationsEmisesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static InvitationsEmisesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      InvitationsEmisesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'InvitationsEmisesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is InvitationsEmisesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createInvitationsEmisesRecordData({
  InvitationStruct? eInvitation,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'eInvitation': InvitationStruct().toMap(),
    }.withoutNulls,
  );

  // Handle nested data for "eInvitation" field.
  addInvitationStructData(firestoreData, eInvitation, 'eInvitation');

  return firestoreData;
}

class InvitationsEmisesRecordDocumentEquality
    implements Equality<InvitationsEmisesRecord> {
  const InvitationsEmisesRecordDocumentEquality();

  @override
  bool equals(InvitationsEmisesRecord? e1, InvitationsEmisesRecord? e2) {
    return e1?.eInvitation == e2?.eInvitation;
  }

  @override
  int hash(InvitationsEmisesRecord? e) =>
      const ListEquality().hash([e?.eInvitation]);

  @override
  bool isValidKey(Object? o) => o is InvitationsEmisesRecord;
}
