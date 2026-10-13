import 'package:flutter/material.dart';
import 'package:superheroapp/data/model/superhero_response.dart';
import 'package:superheroapp/data/model/superhero_results.dart';
import 'package:superheroapp/data/repository.dart';
import 'package:superheroapp/screens/superhero_detail_screen.dart';

class SuperheroSearchScreen extends StatefulWidget {
  const SuperheroSearchScreen({super.key});

  @override
  State<SuperheroSearchScreen> createState() => _SuperheroSearchScreenState();
}

//API
//

class _SuperheroSearchScreenState extends State<SuperheroSearchScreen> {
  Future<SuperheroResponse?>? _superheroInfo;
  final Repository _repository = Repository();
  bool _isEmpty = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Superhero search")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Busca un superhéroe",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (name) {
                setState(() {
                  _isEmpty = name.isEmpty;
                  _superheroInfo = _repository.fetchSuperheroInfo(name);
                });
              },
            ),
          ),
          bodyList(_isEmpty),
        ],
      ),
    );
  }

  FutureBuilder<SuperheroResponse?> bodyList(bool isEmpty) {
    return FutureBuilder(
      future: _superheroInfo,
      builder: (context, snapshot) {
        if (_isEmpty)
          return Text("Introduce un nombre", textAlign: TextAlign.center);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (snapshot.hasData) {
          var superheroList = snapshot.data?.result;
          return Expanded(
            child: ListView.builder(
              itemCount: superheroList?.length ?? 0,
              itemBuilder: (context, index) {
                if (superheroList != null) {
                  return itemSuperhero(superheroList[index]);
                } else {
                  return Text("Error");
                }
              },
            ),
          );
        } else {
          return Text("No hay resultados");
        }
      },
    );
  }

  Padding itemSuperhero(SuperheroDetailResponse item) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
    child: GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SuperheroDetailScreen(superhero: item),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 8, left: 8),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(16),
                child: Image.network(
                  item.url,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                  alignment: AlignmentGeometry.topCenter,
                ),
              ),
            ),
            Text(
              item.name,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
