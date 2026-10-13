import 'package:flutter/material.dart';
import 'package:superheroapp/data/model/superhero_results.dart';

class SuperheroDetailScreen extends StatelessWidget {
  final SuperheroDetailResponse superhero;
  const SuperheroDetailScreen({super.key, required this.superhero});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalles de ${superhero.name}")),
      body: Column(
        children: [
          Text(superhero.name, textAlign: TextAlign.center,style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),),
          Image.network(superhero.url, height: 300, width: double.infinity, fit: BoxFit.cover, alignment: Alignment(0,-.6),)
        ],
      ),
    );
  }
}
