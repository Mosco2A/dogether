import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
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
    _safeInit(() {
      _maListeDeContacts = prefs
              .getStringList('ff_maListeDeContacts')
              ?.map((x) {
                try {
                  return PhoneContactStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _maListeDeContacts;
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

  List<PhoneContactStruct> _maListeDeContacts = [];
  List<PhoneContactStruct> get maListeDeContacts => _maListeDeContacts;
  set maListeDeContacts(List<PhoneContactStruct> value) {
    _maListeDeContacts = value;
    prefs.setStringList(
        'ff_maListeDeContacts', value.map((x) => x.serialize()).toList());
  }

  void addToMaListeDeContacts(PhoneContactStruct value) {
    maListeDeContacts.add(value);
    prefs.setStringList('ff_maListeDeContacts',
        _maListeDeContacts.map((x) => x.serialize()).toList());
  }

  void removeFromMaListeDeContacts(PhoneContactStruct value) {
    maListeDeContacts.remove(value);
    prefs.setStringList('ff_maListeDeContacts',
        _maListeDeContacts.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromMaListeDeContacts(int index) {
    maListeDeContacts.removeAt(index);
    prefs.setStringList('ff_maListeDeContacts',
        _maListeDeContacts.map((x) => x.serialize()).toList());
  }

  void updateMaListeDeContactsAtIndex(
    int index,
    PhoneContactStruct Function(PhoneContactStruct) updateFn,
  ) {
    maListeDeContacts[index] = updateFn(_maListeDeContacts[index]);
    prefs.setStringList('ff_maListeDeContacts',
        _maListeDeContacts.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInMaListeDeContacts(int index, PhoneContactStruct value) {
    maListeDeContacts.insert(index, value);
    prefs.setStringList('ff_maListeDeContacts',
        _maListeDeContacts.map((x) => x.serialize()).toList());
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
