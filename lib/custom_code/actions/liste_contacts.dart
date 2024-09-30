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

import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Authentication

// Déclaration de la variable globale
List<Map<String, String>> maListeDeContacts = [];
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class ContactsPage extends StatefulWidget {
  final String contactsJson;
  final String userUid; // L'UID de l'utilisateur actuel

  ContactsPage({required this.contactsJson, required this.userUid});

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  String searchQuery = ""; // Variable pour gérer la recherche

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
        // Trier les contacts par ordre alphabétique
        maListeDeContacts
            .sort((a, b) => a['displayName']!.compareTo(b['displayName']!));
      } catch (e) {
        print('Erreur lors du chargement des contacts : $e');
      }
    }
  }

  // Vérifier si un numéro de téléphone existe dans la sous-collection 'myContacts' de l'utilisateur
  Future<bool> _isPhoneNumberValidated(String phoneNumber) async {
    var querySnapshot = await _firestore
        .collection('users')
        .doc(widget.userUid) // Utilisateur actuel
        .collection('myContacts') // Sous-collection de cet utilisateur
        .where('phone', isEqualTo: phoneNumber)
        .where('validatedUser', isEqualTo: true)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  // Ajouter un contact à la sous-collection 'myContacts' de l'utilisateur
  Future<void> _addContactToFirestore(String name, String phone) async {
    String docId = _firestore
        .collection('users')
        .doc(widget.userUid) // UID de l'utilisateur actuel
        .collection('myContacts')
        .doc()
        .id; // Générer un ID aléatoire

    bool isValidated = await _isPhoneNumberValidated(phone);

    await _firestore
        .collection('users')
        .doc(widget.userUid) // Sous-collection de l'utilisateur
        .collection('myContacts')
        .doc(docId)
        .set({
      'name': name,
      'phone': phone,
      'validatedUser': isValidated,
    });
  }

  // Supprimer un contact de la sous-collection 'myContacts' de l'utilisateur
  Future<void> _removeContactFromFirestore(String docId) async {
    await _firestore
        .collection('users')
        .doc(widget.userUid)
        .collection('myContacts')
        .doc(docId)
        .delete();
  }

  // Récupérer l'ID du document correspondant au nom du contact
  Future<String?> _getContactDocId(String name) async {
    var querySnapshot = await _firestore
        .collection('users')
        .doc(widget.userUid)
        .collection('myContacts')
        .where('name', isEqualTo: name)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.id;
    }
    return null;
  }

  // Format du numéro de téléphone
  String formatPhoneNumber(String phone) {
    phone = phone.replaceAll(' ', '');

    if (phone.startsWith('06')) {
      return '+336' + phone.substring(2);
    } else if (phone.startsWith('07')) {
      return '+337' + phone.substring(2);
    }

    return phone;
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> contactsList = jsonDecode(widget.contactsJson);

    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Contacts'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Rechercher un contact...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
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

          if (validPhones.isEmpty ||
              (searchQuery.isNotEmpty &&
                  !contact['displayName']
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()))) {
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
                    setState(() {
                      if (isInFirestore) {
                        _removeContactFromFirestore(docId!);
                      } else {
                        _addContactToFirestore(
                            contact['displayName'], formattedPhone);
                      }
                      loadContacts();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isInFirestore ? Colors.red : Colors.blue,
                  ),
                  child: Text(isInFirestore ? 'Supprimer' : 'Ajouter'),
                ),
                leading: FutureBuilder<bool>(
                  future: _isPhoneNumberValidated(formattedPhone),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Icon(Icons.check),
      ),
    );
  }
}

// Fonction pour lister les contacts et naviguer vers la page de contacts
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
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              ContactsPage(contactsJson: contactsJson, userUid: user.uid),
        ),
      );
    }
  } catch (e) {
    print('Failed to get contacts: ${e.toString()}');
  }
}

// Fonction pour vérifier et demander les permissions de contacts
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
