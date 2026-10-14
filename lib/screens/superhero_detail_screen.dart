import 'package:flutter/material.dart';
import 'package:superheroapp/data/model/superhero_results.dart';

class SuperheroDetailScreen extends StatelessWidget {
  final SuperheroDetailResponse superhero;
  const SuperheroDetailScreen({super.key, required this.superhero});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalles de ${superhero.name}")),
      body: Column(
        children: [
          Text(
            superhero.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Afiliaciones:",
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.left,
              ),
              Text(
                superhero.affiliation ?? "No affiliation",
                style: TextStyle(fontSize: 22, color: Colors.blueAccent),
              ),
            ],
          ),
          Expanded(
            child: SizedBox(
              width: 500,
              child: ListView(
                children: superhero.powerstats.entries.map((stat) {
                  return ListTile(
                    horizontalTitleGap: 80,
                    title: Text(
                      "${stat.key[0].toUpperCase()}${stat.key.substring(1)}",
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: Text(
                      stat.value.toString(),
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          //Image.network(superhero.url, height: 300, width: double.infinity, fit: BoxFit.cover, alignment: Alignment(0,-.6),)
        ],
      ),
    );
  }
}
