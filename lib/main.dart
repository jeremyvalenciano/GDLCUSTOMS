import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomePage(),
    );
  }
}

/*
import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<String>> searchImagesG(String query) async {
  const apiKey =
      'AIzaSyBgWozMBBzay_3aFfVeWDXqSvl-ijsrMLE'; // Reemplaza por tu propia API Key
  final searchUrl =
      'https://www.googleapis.com/customsearch/v1?key=$apiKey&cx=c712f948d33c04341&searchType=image&q=$query';

  final response = await http.get(Uri.parse(searchUrl));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);

    if (data['items'] != null) {
      final items = List.from(data['items']);
      final imageUrls = items.map((item) => item['link']).toList();
      return imageUrls.cast<String>();
    }
  }

  return [];
}

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String query = '';
  List<String> imageUrls = [];
  Future<List<String>> searchImages(String query) async {
    const apiKey =
        'AIzaSyBgWozMBBzay_3aFfVeWDXqSvl-ijsrMLE'; // Reemplaza por tu propia API Key
    final searchUrl =
        'https://www.googleapis.com/customsearch/v1?key=$apiKey&cx=c712f948d33c04341&searchType=image&q=$query';

    final response = await http.get(Uri.parse(searchUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['items'] != null) {
        final items = List.from(data['items']);
        final imageUrls = items.map((item) => item['link']).toList();
        return imageUrls.cast<String>();
      }
    }

    return [];
  }

  searchImagesI() async {
    final results = await searchImages(query);
    setState(() {
      imageUrls = results;
      debugPrint(imageUrls.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Search'),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                query = value;
              });
            },
            onSubmitted: (value) {
              searchImagesI();
            },
            decoration: const InputDecoration(
              hintText: 'Enter search query',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          Container(
            child: ElevatedButton(
              onPressed: () {
                searchImagesI();
              },
              child: const Text('Search'),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                final imageUrl = imageUrls[index];
                return Image.network(imageUrl);
              },
            ),
          ),
        ],
      ),
    );
  }
}*/
