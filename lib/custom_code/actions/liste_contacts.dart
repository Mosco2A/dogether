// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

// Remove global variables
class ContactsPage extends StatefulWidget {
  final List<Map<String, dynamic>> contacts;
  ContactsPage({required this.contacts});

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Map<String, dynamic>> maListeDeContacts = [];
  List<Map<String, dynamic>> searchResults = [];
  TextEditingController _searchController = TextEditingController();
  Map<String, bool> contactValidationStatus = {};
  Map<String, String?> contactDocIds = {};
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    loadContacts(); // Charger les contacts au démarrage
    prefetchValidationStatus();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void loadContacts() {
    maListeDeContacts = List<Map<String, dynamic>>.from(widget.contacts);
    maListeDeContacts
        .sort((a, b) => a['displayName']!.compareTo(b['displayName']!));
  }

  Future<void> prefetchValidationStatus() async {
    String? userId = _auth.currentUser?.uid;
    if (userId == null) return;

    List<String> phoneNumbers = maListeDeContacts
        .expand((contact) => (contact['phones'] as List<dynamic>)
            .map((e) => formatPhoneNumber(e.toString())))
        .toSet()
        .toList();

    // Firestore allows up to 10 elements in a 'whereIn' query
    const int batchSize = 10;
    Set<String> validatedNumbers = {};

    for (int i = 0; i < phoneNumbers.length; i += batchSize) {
      var batch = phoneNumbers.skip(i).take(batchSize).toList();
      var querySnapshot = await _firestore
          .collection('users')
          .where('phoneNumber', whereIn: batch)
          .get();

      validatedNumbers.addAll(
          querySnapshot.docs.map((doc) => doc['phoneNumber'] as String));
    }

    setState(() {
      for (var contact in maListeDeContacts) {
        String formattedPhone = formatPhoneNumber(contact['phones'].first);
        contactValidationStatus[contact['displayName']] =
            validatedNumbers.contains(formattedPhone);
      }
    });
  }

  Future<String?> _getContactDocId(String name) async {
    if (contactDocIds.containsKey(name)) {
      return contactDocIds[name];
    }

    String? userId = _auth.currentUser?.uid;
    if (userId == null) return null;

    var querySnapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('myContacts')
        .where('name', isEqualTo: name)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      contactDocIds[name] = querySnapshot.docs.first.id;
      return contactDocIds[name];
    }
    return null;
  }

  String formatPhoneNumber(String phone) {
    phone = phone.replaceAll(' ', '');

    if (phone.startsWith('06')) {
      return '+336' + phone.substring(2);
    } else if (phone.startsWith('07')) {
      return '+337' + phone.substring(2);
    }

    return phone;
  }

  void _searchContacts(String query) {
    setState(() {
      searchResults = maListeDeContacts
          .where((contact) => contact['displayName']!
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<bool> _isPhoneNumberValidated(String phoneNumber) async {
    // Already prefetched, no need to query again
    return contactValidationStatus[phoneNumber] ?? false;
  }

  Future<void> _addContactToFirestore(String name, String phone) async {
    String? userId = _auth.currentUser?.uid;
    if (userId == null) return;

    String docId = _firestore
        .collection('users')
        .doc(userId)
        .collection('myContacts')
        .doc()
        .id;

    bool isValidated = contactValidationStatus[name] ?? false;

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('myContacts')
        .doc(docId)
        .set({
      'name': name,
      'phone': phone,
      'validatedUser': isValidated,
    });

    setState(() {
      contactDocIds[name] = docId;
    });
  }

  Future<void> _removeContactFromFirestore(String docId, String name) async {
    String? userId = _auth.currentUser?.uid;
    if (userId == null) return;

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('myContacts')
        .doc(docId)
        .delete();

    setState(() {
      contactDocIds.remove(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Si des résultats de recherche existent, utiliser ceux-ci, sinon utiliser la liste complète
    List<Map<String, dynamic>> contactsList =
        searchResults.isNotEmpty ? searchResults : maListeDeContacts;

    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Contacts'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Optionally, you can focus the search field or show a search UI
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Contacts',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                _onSearchChanged(value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: contactsList.length,
              itemBuilder: (context, index) {
                var contact = contactsList[index];
                List<String> validPhones = (contact['phones'] as List<dynamic>)
                    .where((phone) =>
                        phone.startsWith('+337') ||
                        phone.startsWith('+336') ||
                        phone.startsWith('06') ||
                        phone.startsWith('07'))
                    .map((phone) => phone.toString())
                    .toList();

                if (validPhones.isEmpty) {
                  return SizedBox.shrink();
                }

                String phoneToSave = validPhones.first;
                String formattedPhone = formatPhoneNumber(phoneToSave);
                String displayName = contact['displayName'] as String;

                return ListTile(
                  title: Text(displayName),
                  subtitle: Text('Phone: $formattedPhone'),
                  trailing: ElevatedButton(
                    onPressed: () async {
                      String? docId = await _getContactDocId(displayName);
                      bool isInFirestore = docId != null;

                      if (isInFirestore) {
                        await _removeContactFromFirestore(docId, displayName);
                      } else {
                        await _addContactToFirestore(
                            displayName, formattedPhone);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: contactDocIds.containsKey(displayName)
                          ? Colors.red
                          : Colors.blue,
                    ),
                    child: Text(contactDocIds.containsKey(displayName)
                        ? 'Supprimer'
                        : 'Ajouter'),
                  ),
                  leading: Icon(
                    contactValidationStatus[displayName] == true
                        ? Icons.check_circle
                        : Icons.error,
                    color: contactValidationStatus[displayName] == true
                        ? Colors.green
                        : Colors.grey,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Icon(Icons.check),
      ),
    );
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (query.isNotEmpty) {
        _searchContacts(query);
      } else {
        setState(() {
          searchResults.clear();
        });
      }
    });
  }
}

Future<void> listeContacts(BuildContext context) async {
  List<Map<String, dynamic>> contactsList = [];

  PermissionStatus permissionStatus = await _getContactPermission();
  if (permissionStatus != PermissionStatus.granted) {
    // Optionally, show a dialog informing the user why permission is needed
    return;
  }

  try {
    List<Contact> contacts = await FastContacts.getAllContacts();
    for (var contact in contacts) {
      List<String> phoneNumbers = contact.phones.map((e) => e.number).toList();

      contactsList.add({
        'displayName': contact.displayName,
        'phones': phoneNumbers,
        'emails': contact.emails.map((e) => e.address).toList(),
      });
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ContactsPage(contacts: contactsList),
      ),
    );
  } catch (e) {
    print('Failed to get contacts: ${e.toString()}');
  }
}

Future<PermissionStatus> _getContactPermission() async {
  var status = await Permission.contacts.status;

  if (status.isDenied || status.isPermanentlyDenied) {
    PermissionStatus newStatus = await Permission.contacts.request();

    if (newStatus.isPermanentlyDenied) {
      await openAppSettings();
    }
    return newStatus;
  }

  return status;
}
