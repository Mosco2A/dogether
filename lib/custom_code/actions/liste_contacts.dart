// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:shared_preferences/shared_preferences.dart'; // Ajout de SharedPreferences
import 'dart:convert';
import 'package:fast_contacts/fast_contacts.dart'; // Importer les contacts
import 'package:permission_handler/permission_handler.dart'; // Gestion des permissions

// Déclaration de la variable globale
List<Map<String, String>> maListeDeContacts = [];

class ContactsPage extends StatefulWidget {
  final String contactsJson;

  ContactsPage({required this.contactsJson});

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  void initState() {
    super.initState();
    loadContacts(); // Charger les contacts au démarrage
  }

  void loadContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? contactsJson = prefs.getString('maListeDeContacts');

    // Vider la liste avant de charger
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

  void saveContacts() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('maListeDeContacts', jsonEncode(maListeDeContacts));
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> contactsList = jsonDecode(widget.contactsJson);

    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Contacts'),
      ),
      body: ListView.builder(
        itemCount: contactsList.length,
        itemBuilder: (context, index) {
          var contact = contactsList[index];
          // Vérifiez si le contact est déjà dans la liste
          bool isInList = maListeDeContacts
              .any((c) => c['displayName'] == contact['displayName']);

          return ListTile(
            title: Text(contact['displayName']),
            subtitle: Text('Phones: ${contact['phones'].join(', ')}'),
            trailing: ElevatedButton(
              onPressed: () {
                setState(() {
                  if (isInList) {
                    // Si le contact est déjà dans la liste, le supprimer
                    maListeDeContacts.removeWhere(
                        (c) => c['displayName'] == contact['displayName']);
                  } else {
                    // Ajouter le contact s'il n'existe pas déjà
                    maListeDeContacts.add({
                      'displayName': contact['displayName'],
                      'phones': contact['phones'].join(', '),
                    });
                  }
                  saveContacts(); // Sauvegarder les contacts après modification
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isInList ? Colors.red : Colors.blue, // Changement ici
              ),
              child: Text(isInList ? 'Enlever' : 'Ajouter'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop(); // Retour à la page précédente
        },
        child: Icon(Icons.check),
      ),
    );
  }
}

Future<void> listeContacts(BuildContext context) async {
  List<Map<String, dynamic>> contactsList = [];

  // Vérifier et demander les permissions
  PermissionStatus permissionStatus = await _getContactPermission();

  if (permissionStatus != PermissionStatus.granted) {
    // Si les permissions ne sont toujours pas accordées, quitter
    return;
  }

  try {
    // Récupérer les contacts après que les permissions aient été accordées
    List<Contact> contacts = await FastContacts.getAllContacts();
    for (var contact in contacts) {
      contactsList.add({
        'displayName': contact.displayName,
        'phones': contact.phones.map((e) => e.number).toList(),
        'emails': contact.emails.map((e) => e.address).toList(),
      });
    }

    String contactsJson = jsonEncode(contactsList);

    // Naviguer vers la page cible en passant le JSON
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ContactsPage(contactsJson: contactsJson),
      ),
    );
  } catch (e) {
    print('Failed to get contacts: ${e.toString()}');
  }
}

// Fonction pour vérifier et demander les permissions
Future<PermissionStatus> _getContactPermission() async {
  // Vérifier si la permission a déjà été accordée
  var status = await Permission.contacts.status;

  if (status.isDenied || status.isPermanentlyDenied) {
    // Demander à l'utilisateur s'il a refusé ou refusé de façon permanente
    PermissionStatus newStatus = await Permission.contacts.request();

    if (newStatus.isPermanentlyDenied) {
      // Si refus permanent, ouvrir les paramètres pour l'autoriser manuellement
      await openAppSettings();
    }

    return newStatus;
  }

  return status;
}
