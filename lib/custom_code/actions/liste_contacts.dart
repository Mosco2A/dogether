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

import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:fast_contacts/fast_contacts.dart'; // Import contacts
import 'package:permission_handler/permission_handler.dart'; // Permission handling
import 'dart:convert'; // For jsonDecode and jsonEncode
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:http/http.dart' as http; // Import http for Elasticsearch

// Déclaration de la variable globale
List<Map<String, String>> maListeDeContacts = [];
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

class ContactsPage extends StatefulWidget {
  final String contactsJson;
  ContactsPage({required this.contactsJson});

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<dynamic> searchResults = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadContacts(); // Charger les contacts au démarrage
  }

  void loadContacts() async {
    final String? contactsJson = widget.contactsJson;
    maListeDeContacts.clear();

    if (contactsJson != null) {
      try {
        List<dynamic> loadedContacts = jsonDecode(contactsJson);
        maListeDeContacts = List<Map<String, String>>.from(loadedContacts);
      } catch (e) {
        print('Erreur lors du chargement des contacts : $e');
      }
    }
  }

  Future<bool> _isPhoneNumberValidated(String phoneNumber) async {
    var querySnapshot = await _firestore
        .collection('users')
        .where('phoneNumber', isEqualTo: phoneNumber)
        .get();

    return querySnapshot.docs.isNotEmpty;
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

    bool isValidated = await _isPhoneNumberValidated(phone);

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
  }

  Future<void> _removeContactFromFirestore(String docId) async {
    String? userId = _auth.currentUser?.uid;
    if (userId == null) return;

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('myContacts')
        .doc(docId)
        .delete();
  }

  Future<String?> _getContactDocId(String name) async {
    String? userId = _auth.currentUser?.uid;
    if (userId == null) return null;

    var querySnapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('myContacts')
        .where('name', isEqualTo: name)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.id;
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

  Future<void> _searchContacts(String query) async {
    final url =
        'http://localhost:9200/your_index/_search'; // Change with Elasticsearch URL
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "query": {
          "match": {
            "your_field": query, // Adjust the field to search in
          },
        },
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        searchResults = data['hits']['hits'];
      });
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> contactsList = searchResults.isNotEmpty
        ? searchResults
        : jsonDecode(widget.contactsJson);
    contactsList.sort((a, b) => a['displayName'].compareTo(b['displayName']));

    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Contacts'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
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
                if (value.isNotEmpty) {
                  _searchContacts(value);
                } else {
                  setState(() {
                    searchResults.clear();
                  });
                }
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

                return FutureBuilder<String?>(
                  future: _getContactDocId(contact['displayName']),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    String? docId = snapshot.data;
                    bool isInFirestore = docId != null;

                    return ListTile(
                      title: Text(contact['displayName']),
                      subtitle: Text('Phone: $formattedPhone'),
                      trailing: ElevatedButton(
                        onPressed: () async {
                          if (isInFirestore) {
                            await _removeContactFromFirestore(docId!);
                          } else {
                            await _addContactToFirestore(
                                contact['displayName'], formattedPhone);
                          }

                          setState(() {
                            loadContacts();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isInFirestore ? Colors.red : Colors.blue,
                        ),
                        child: Text(isInFirestore ? 'Supprimer' : 'Ajouter'),
                      ),
                      leading: FutureBuilder<bool>(
                        future: _isPhoneNumberValidated(formattedPhone),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }
                          bool isValidatedUser = snapshot.data ?? false;
                          return Icon(
                            isValidatedUser ? Icons.check_circle : Icons.error,
                            color: isValidatedUser ? Colors.green : Colors.grey,
                          );
                        },
                      ),
                    );
                  },
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
}

Future<void> listeContacts(BuildContext context) async {
  List<Map<String, dynamic>> contactsList = [];

  PermissionStatus permissionStatus = await _getContactPermission();
  if (permissionStatus != PermissionStatus.granted) {
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

    String contactsJson = jsonEncode(contactsList);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ContactsPage(contactsJson: contactsJson),
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
