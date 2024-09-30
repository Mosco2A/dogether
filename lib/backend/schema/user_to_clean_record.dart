import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserToCleanRecord extends FirestoreRecord {
  UserToCleanRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "uidToClean" field.
  String? _uidToClean;
  String get uidToClean => _uidToClean ?? '';
  bool hasUidToClean() => _uidToClean != null;

  void _initializeFields() {
    _uidToClean = snapshotData['uidToClean'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('userToClean');

  static Stream<UserToCleanRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UserToCleanRecord.fromSnapshot(s));

  static Future<UserToCleanRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UserToCleanRecord.fromSnapshot(s));

  static UserToCleanRecord fromSnapshot(DocumentSnapshot snapshot) =>
      UserToCleanRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UserToCleanRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UserToCleanRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UserToCleanRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UserToCleanRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUserToCleanRecordData({
  String? uidToClean,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'uidToClean': uidToClean,
    }.withoutNulls,
  );

  return firestoreData;
}

class UserToCleanRecordDocumentEquality implements Equality<UserToCleanRecord> {
  const UserToCleanRecordDocumentEquality();

  @override
  bool equals(UserToCleanRecord? e1, UserToCleanRecord? e2) {
    return e1?.uidToClean == e2?.uidToClean;
  }

  @override
  int hash(UserToCleanRecord? e) => const ListEquality().hash([e?.uidToClean]);

  @override
  bool isValidKey(Object? o) => o is UserToCleanRecord;
}
