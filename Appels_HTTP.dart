// Importation du package Flutter pour créer des interfaces utilisateur
import 'package:flutter/material.dart';

// Importation du package http pour effectuer des requêtes HTTP
import 'package:http/http.dart' as http;

// Importation du package dart:convert pour convertir des données JSON
import 'dart:convert'; 

// Fonction principale de l'application, point d'entrée
void main() {
  // runApp lance l'application Flutter en exécutant le widget MyApp
  runApp(MyApp());
}

// MyApp est un StatefulWidget, ce qui signifie que l'état peut changer au cours de l'exécution
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

// _MyAppState gère l'état de MyApp
class _MyAppState extends State<MyApp> {
  
  // Déclaration d'une variable 'data' qui va contenir les données récupérées, initialisée avec un message
  String data = "Fetching data...";

  // initState est une méthode appelée lors de la création initiale de l'état
  @override
  void initState() {
    super.initState();
    
    // Appel de la méthode fetchData pour récupérer des données dès le démarrage de l'application
    fetchData();
  }

  // Méthode fetchData pour récupérer des données à partir d'une API
  void fetchData() async {
    // Utilisation de http.get pour envoyer une requête GET à une URL spécifique
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));

    // Vérifie si la requête a réussi (statut 200)
    if (response.statusCode == 200) {
      // Si la requête réussit, on décode la réponse JSON et on met à jour la variable 'data' avec le titre récupéré
      setState(() {
        data = json.decode(response.body)['title'];
      });
    } else {
      // Si la requête échoue, on met à jour 'data' avec un message d'erreur
      setState(() {
        data = "Failed to load data";
      });
    }
  }

  // La méthode build crée l'interface utilisateur
  @override
  Widget build(BuildContext context) {
    // Retourne l'interface de l'application en utilisant MaterialApp
    return MaterialApp(
      // Scaffold structure l'interface avec une barre d'application (AppBar) et un corps (body)
      home: Scaffold(
        // AppBar avec un titre
        appBar: AppBar(title: Text('HTTP Request Example')),
        // Le corps de la page, centré, contenant le texte (data)
        body: Center(
          // Le texte affiche soit les données récupérées, soit un message d'attente/erreur
          child: Text(data),
        ),
      ),
    );
  }
}
