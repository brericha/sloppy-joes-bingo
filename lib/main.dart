import 'dart:html' as html;

import 'package:fk_bingo/data/bingo_items.dart';
import 'package:fk_bingo/widget/bingo_grid.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        title: "Sloppy Joe's Bingo",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF000080),
          ),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: "Sloppy Joe's Bingo"),
      );
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _items = [];

  void _generateNewTiles() {
    final titles = BingoItems.getItems();
    titles.insert(12, 'Free Space');
    setState(() => _items = titles);
  }

  @override
  void initState() {
    super.initState();
    _generateNewTiles();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final double gridWidth;
    final double horizontalPadding;
    if (screenWidth <= 1000) {
      gridWidth = screenWidth;
      horizontalPadding = 28;
    } else {
      gridWidth = 1000;
      horizontalPadding = 78;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 48,
          horizontal: horizontalPadding,
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: gridWidth,
                  child: BingoGrid(
                    items: _items,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        html.window.open(
                          'https://liveduvalstreet.com/',
                          'new tab',
                        );
                      },
                      child: const Text("Sloppy Joe's Webcam"),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: _generateNewTiles,
        child: const Icon(Icons.shuffle),
      ),
    );
  }
}
