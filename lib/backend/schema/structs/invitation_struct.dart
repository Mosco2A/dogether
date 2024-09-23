// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class InvitationStruct extends FFFirebaseStruct {
  InvitationStruct({
    String? iRef,
    String? iTitre,
    String? iType,
    String? iDetail,
    DateTime? idateInvite,
    DateTime? iDateReponse,
    DureeStruct? iDuree,
    PhoneContactStruct? iInvites,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _iRef = iRef,
        _iTitre = iTitre,
        _iType = iType,
        _iDetail = iDetail,
        _idateInvite = idateInvite,
        _iDateReponse = iDateReponse,
        _iDuree = iDuree,
        _iInvites = iInvites,
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

  // "iDateReponse" field.
  DateTime? _iDateReponse;
  DateTime? get iDateReponse => _iDateReponse;
  set iDateReponse(DateTime? val) => _iDateReponse = val;

  bool hasIDateReponse() => _iDateReponse != null;

  // "iDuree" field.
  DureeStruct? _iDuree;
  DureeStruct get iDuree => _iDuree ?? DureeStruct();
  set iDuree(DureeStruct? val) => _iDuree = val;

  void updateIDuree(Function(DureeStruct) updateFn) {
    updateFn(_iDuree ??= DureeStruct());
  }

  bool hasIDuree() => _iDuree != null;

  // "iInvites" field.
  PhoneContactStruct? _iInvites;
  PhoneContactStruct get iInvites => _iInvites ?? PhoneContactStruct();
  set iInvites(PhoneContactStruct? val) => _iInvites = val;

  void updateIInvites(Function(PhoneContactStruct) updateFn) {
    updateFn(_iInvites ??= PhoneContactStruct());
  }

  bool hasIInvites() => _iInvites != null;

  static InvitationStruct fromMap(Map<String, dynamic> data) =>
      InvitationStruct(
        iRef: data['iRef'] as String?,
        iTitre: data['iTitre'] as String?,
        iType: data['iType'] as String?,
        iDetail: data['iDetail'] as String?,
        idateInvite: data['IdateInvite'] as DateTime?,
        iDateReponse: data['iDateReponse'] as DateTime?,
        iDuree: DureeStruct.maybeFromMap(data['iDuree']),
        iInvites: PhoneContactStruct.maybeFromMap(data['iInvites']),
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
        'iDateReponse': _iDateReponse,
        'iDuree': _iDuree?.toMap(),
        'iInvites': _iInvites?.toMap(),
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
        'iDateReponse': serializeParam(
          _iDateReponse,
          ParamType.DateTime,
        ),
        'iDuree': serializeParam(
          _iDuree,
          ParamType.DataStruct,
        ),
        'iInvites': serializeParam(
          _iInvites,
          ParamType.DataStruct,
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
        iDateReponse: deserializeParam(
          data['iDateReponse'],
          ParamType.DateTime,
          false,
        ),
        iDuree: deserializeStructParam(
          data['iDuree'],
          ParamType.DataStruct,
          false,
          structBuilder: DureeStruct.fromSerializableMap,
        ),
        iInvites: deserializeStructParam(
          data['iInvites'],
          ParamType.DataStruct,
          false,
          structBuilder: PhoneContactStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'InvitationStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is InvitationStruct &&
        iRef == other.iRef &&
        iTitre == other.iTitre &&
        iType == other.iType &&
        iDetail == other.iDetail &&
        idateInvite == other.idateInvite &&
        iDateReponse == other.iDateReponse &&
        iDuree == other.iDuree &&
        iInvites == other.iInvites;
  }

  @override
  int get hashCode => const ListEquality().hash([
        iRef,
        iTitre,
        iType,
        iDetail,
        idateInvite,
        iDateReponse,
        iDuree,
        iInvites
      ]);
}

InvitationStruct createInvitationStruct({
  String? iRef,
  String? iTitre,
  String? iType,
  String? iDetail,
  DateTime? idateInvite,
  DateTime? iDateReponse,
  DureeStruct? iDuree,
  PhoneContactStruct? iInvites,
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
      iDateReponse: iDateReponse,
      iDuree: iDuree ?? (clearUnsetFields ? DureeStruct() : null),
      iInvites: iInvites ?? (clearUnsetFields ? PhoneContactStruct() : null),
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

  // Handle nested data for "iDuree" field.
  addDureeStructData(
    firestoreData,
    invitation.hasIDuree() ? invitation.iDuree : null,
    'iDuree',
    forFieldValue,
  );

  // Handle nested data for "iInvites" field.
  addPhoneContactStructData(
    firestoreData,
    invitation.hasIInvites() ? invitation.iInvites : null,
    'iInvites',
    forFieldValue,
  );

  // Add any Firestore field values
  invitation.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getInvitationListFirestoreData(
  List<InvitationStruct>? invitations,
) =>
    invitations?.map((e) => getInvitationFirestoreData(e, true)).toList() ?? [];
