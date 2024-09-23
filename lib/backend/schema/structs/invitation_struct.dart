// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class InvitationStruct extends FFFirebaseStruct {
  InvitationStruct({
    String? iRef,
    String? iTitre,
    String? iType,
    String? iDetail,
    DateTime? idateInvite,
    String? iDuree,
    List<PhoneContactStruct>? iListeInvites,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _iRef = iRef,
        _iTitre = iTitre,
        _iType = iType,
        _iDetail = iDetail,
        _idateInvite = idateInvite,
        _iDuree = iDuree,
        _iListeInvites = iListeInvites,
        super(firestoreUtilData);

  // "iRef" field.
  String? _iRef;
  String get iRef => _iRef ?? '';
  set iRef(String? val) => _iRef = val;

  bool hasIRef() => _iRef != null;

  // "iTitre" field.
  String? _iTitre;
  String get iTitre => _iTitre ?? '';
  set iTitre(String? val) => _iTitre = val;

  bool hasITitre() => _iTitre != null;

  // "iType" field.
  String? _iType;
  String get iType => _iType ?? '';
  set iType(String? val) => _iType = val;

  bool hasIType() => _iType != null;

  // "iDetail" field.
  String? _iDetail;
  String get iDetail => _iDetail ?? '';
  set iDetail(String? val) => _iDetail = val;

  bool hasIDetail() => _iDetail != null;

  // "IdateInvite" field.
  DateTime? _idateInvite;
  DateTime? get idateInvite => _idateInvite;
  set idateInvite(DateTime? val) => _idateInvite = val;

  bool hasIdateInvite() => _idateInvite != null;

  // "iDuree" field.
  String? _iDuree;
  String get iDuree => _iDuree ?? '';
  set iDuree(String? val) => _iDuree = val;

  bool hasIDuree() => _iDuree != null;

  // "iListeInvites" field.
  List<PhoneContactStruct>? _iListeInvites;
  List<PhoneContactStruct> get iListeInvites => _iListeInvites ?? const [];
  set iListeInvites(List<PhoneContactStruct>? val) => _iListeInvites = val;

  void updateIListeInvites(Function(List<PhoneContactStruct>) updateFn) {
    updateFn(_iListeInvites ??= []);
  }

  bool hasIListeInvites() => _iListeInvites != null;

  static InvitationStruct fromMap(Map<String, dynamic> data) =>
      InvitationStruct(
        iRef: data['iRef'] as String?,
        iTitre: data['iTitre'] as String?,
        iType: data['iType'] as String?,
        iDetail: data['iDetail'] as String?,
        idateInvite: data['IdateInvite'] as DateTime?,
        iDuree: data['iDuree'] as String?,
        iListeInvites: getStructList(
          data['iListeInvites'],
          PhoneContactStruct.fromMap,
        ),
      );

  static InvitationStruct? maybeFromMap(dynamic data) => data is Map
      ? InvitationStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'iRef': _iRef,
        'iTitre': _iTitre,
        'iType': _iType,
        'iDetail': _iDetail,
        'IdateInvite': _idateInvite,
        'iDuree': _iDuree,
        'iListeInvites': _iListeInvites?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'iRef': serializeParam(
          _iRef,
          ParamType.String,
        ),
        'iTitre': serializeParam(
          _iTitre,
          ParamType.String,
        ),
        'iType': serializeParam(
          _iType,
          ParamType.String,
        ),
        'iDetail': serializeParam(
          _iDetail,
          ParamType.String,
        ),
        'IdateInvite': serializeParam(
          _idateInvite,
          ParamType.DateTime,
        ),
        'iDuree': serializeParam(
          _iDuree,
          ParamType.String,
        ),
        'iListeInvites': serializeParam(
          _iListeInvites,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static InvitationStruct fromSerializableMap(Map<String, dynamic> data) =>
      InvitationStruct(
        iRef: deserializeParam(
          data['iRef'],
          ParamType.String,
          false,
        ),
        iTitre: deserializeParam(
          data['iTitre'],
          ParamType.String,
          false,
        ),
        iType: deserializeParam(
          data['iType'],
          ParamType.String,
          false,
        ),
        iDetail: deserializeParam(
          data['iDetail'],
          ParamType.String,
          false,
        ),
        idateInvite: deserializeParam(
          data['IdateInvite'],
          ParamType.DateTime,
          false,
        ),
        iDuree: deserializeParam(
          data['iDuree'],
          ParamType.String,
          false,
        ),
        iListeInvites: deserializeStructParam<PhoneContactStruct>(
          data['iListeInvites'],
          ParamType.DataStruct,
          true,
          structBuilder: PhoneContactStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'InvitationStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is InvitationStruct &&
        iRef == other.iRef &&
        iTitre == other.iTitre &&
        iType == other.iType &&
        iDetail == other.iDetail &&
        idateInvite == other.idateInvite &&
        iDuree == other.iDuree &&
        listEquality.equals(iListeInvites, other.iListeInvites);
  }

  @override
  int get hashCode => const ListEquality()
      .hash([iRef, iTitre, iType, iDetail, idateInvite, iDuree, iListeInvites]);
}

InvitationStruct createInvitationStruct({
  String? iRef,
  String? iTitre,
  String? iType,
  String? iDetail,
  DateTime? idateInvite,
  String? iDuree,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    InvitationStruct(
      iRef: iRef,
      iTitre: iTitre,
      iType: iType,
      iDetail: iDetail,
      idateInvite: idateInvite,
      iDuree: iDuree,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

InvitationStruct? updateInvitationStruct(
  InvitationStruct? invitation, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    invitation
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addInvitationStructData(
  Map<String, dynamic> firestoreData,
  InvitationStruct? invitation,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (invitation == null) {
    return;
  }
  if (invitation.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && invitation.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final invitationData = getInvitationFirestoreData(invitation, forFieldValue);
  final nestedData = invitationData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = invitation.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getInvitationFirestoreData(
  InvitationStruct? invitation, [
  bool forFieldValue = false,
]) {
  if (invitation == null) {
    return {};
  }
  final firestoreData = mapToFirestore(invitation.toMap());

  // Add any Firestore field values
  invitation.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getInvitationListFirestoreData(
  List<InvitationStruct>? invitations,
) =>
    invitations?.map((e) => getInvitationFirestoreData(e, true)).toList() ?? [];
