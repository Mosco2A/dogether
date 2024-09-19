import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _vName = prefs.getString('ff_vName') ?? _vName;
    });
    _safeInit(() {
      _vFirstName = prefs.getString('ff_vFirstName') ?? _vFirstName;
    });
    _safeInit(() {
      _VPhoneNum = prefs.getString('ff_VPhoneNum') ?? _VPhoneNum;
    });
    _safeInit(() {
      _vMyID = prefs.getString('ff_vMyID') ?? _vMyID;
    });
    _safeInit(() {
      _VMyUID = prefs.getString('ff_VMyUID') ?? _VMyUID;
    });
    _safeInit(() {
      _vUserRecordRef =
          prefs.getString('ff_vUserRecordRef')?.ref ?? _vUserRecordRef;
    });
    _safeInit(() {
      _vEnvVarSet = prefs.getBool('ff_vEnvVarSet') ?? _vEnvVarSet;
    });
    _safeInit(() {
      _vLigthDark = prefs.getBool('ff_vLigthDark') ?? _vLigthDark;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _vName = '';
  String get vName => _vName;
  set vName(String value) {
    _vName = value;
    prefs.setString('ff_vName', value);
  }

  String _vFirstName = '';
  String get vFirstName => _vFirstName;
  set vFirstName(String value) {
    _vFirstName = value;
    prefs.setString('ff_vFirstName', value);
  }

  String _VPhoneNum = '';
  String get VPhoneNum => _VPhoneNum;
  set VPhoneNum(String value) {
    _VPhoneNum = value;
    prefs.setString('ff_VPhoneNum', value);
  }

  String _vMyID = '';
  String get vMyID => _vMyID;
  set vMyID(String value) {
    _vMyID = value;
    prefs.setString('ff_vMyID', value);
  }

  String _VMyUID = '';
  String get VMyUID => _VMyUID;
  set VMyUID(String value) {
    _VMyUID = value;
    prefs.setString('ff_VMyUID', value);
  }

  DocumentReference? _vUserRecordRef;
  DocumentReference? get vUserRecordRef => _vUserRecordRef;
  set vUserRecordRef(DocumentReference? value) {
    _vUserRecordRef = value;
    value != null
        ? prefs.setString('ff_vUserRecordRef', value.path)
        : prefs.remove('ff_vUserRecordRef');
  }

  bool _vEnvVarSet = false;
  bool get vEnvVarSet => _vEnvVarSet;
  set vEnvVarSet(bool value) {
    _vEnvVarSet = value;
    prefs.setBool('ff_vEnvVarSet', value);
  }

  bool _vValideSuppCompte = false;
  bool get vValideSuppCompte => _vValideSuppCompte;
  set vValideSuppCompte(bool value) {
    _vValideSuppCompte = value;
  }

  String _vUidToClean = '';
  String get vUidToClean => _vUidToClean;
  set vUidToClean(String value) {
    _vUidToClean = value;
  }

  bool _vTest = false;
  bool get vTest => _vTest;
  set vTest(bool value) {
    _vTest = value;
  }

  bool _vLigthDark = false;
  bool get vLigthDark => _vLigthDark;
  set vLigthDark(bool value) {
    _vLigthDark = value;
    prefs.setBool('ff_vLigthDark', value);
  }

  List<dynamic> _contactsJson = [];
  List<dynamic> get contactsJson => _contactsJson;
  set contactsJson(List<dynamic> value) {
    _contactsJson = value;
  }

  void addToContactsJson(dynamic value) {
    contactsJson.add(value);
  }

  void removeFromContactsJson(dynamic value) {
    contactsJson.remove(value);
  }

  void removeAtIndexFromContactsJson(int index) {
    contactsJson.removeAt(index);
  }

  void updateContactsJsonAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    contactsJson[index] = updateFn(_contactsJson[index]);
  }

  void insertAtIndexInContactsJson(int index, dynamic value) {
    contactsJson.insert(index, value);
  }

  List<dynamic> _globalJsonContacts = [];
  List<dynamic> get globalJsonContacts => _globalJsonContacts;
  set globalJsonContacts(List<dynamic> value) {
    _globalJsonContacts = value;
  }

  void addToGlobalJsonContacts(dynamic value) {
    globalJsonContacts.add(value);
  }

  void removeFromGlobalJsonContacts(dynamic value) {
    globalJsonContacts.remove(value);
  }

  void removeAtIndexFromGlobalJsonContacts(int index) {
    globalJsonContacts.removeAt(index);
  }

  void updateGlobalJsonContactsAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    globalJsonContacts[index] = updateFn(_globalJsonContacts[index]);
  }

  void insertAtIndexInGlobalJsonContacts(int index, dynamic value) {
    globalJsonContacts.insert(index, value);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
