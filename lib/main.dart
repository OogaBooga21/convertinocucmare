import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';

ImagePicker picker = ImagePicker();
String _convertTo = "txt";

void main() {
  runApp(/*const*/ MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  XFile? imageFile;

  _openGallery() async {
    imageFile = await picker.pickImage(source: ImageSource.gallery);
    this.setState(() {});
  }

  _openCamera() async {
    imageFile = await picker.pickImage(source: ImageSource.camera);
    this.setState(() {});
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      _openGallery();
                    },
                  ),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera();
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Convertino'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _convertPdf() {
    setState(() {
      _convertTo == "pdf";
    });
  }

  void _convertTxt() {
    setState(() {
      _convertTo == "txt";
    });
  }

  void _convertDoc() {
    setState(() {
      _convertTo == "doc";
    });
  }

  void _convertWtf() {
    setState(() {
      _convertTo == "wtf";
    });
  }

  void _sendData() {
    setState(() {
      _convertTo == "wtf";
    });
  }

  @override
  Widget build(BuildContext context) {
    _MyAppState app = new _MyAppState();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.blue,
                onSurface: Colors.red,
              ),
              onPressed: () {
                _convertTxt();
              },
              child: Text('.Txt'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.blue,
                onSurface: Colors.red,
              ),
              onPressed: () {
                _convertDoc();
              },
              child: Text('.Doc'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.blue,
                onSurface: Colors.red,
              ),
              onPressed: () {
                _convertPdf();
              },
              child: Text('.Pdf'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.blue,
                onSurface: Colors.red,
              ),
              onPressed: () {
                _convertWtf();
              },
              child: Text('.Wtf'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.green,
                onSurface: Colors.purpleAccent,
              ),
              onPressed: () {
                _sendData();
              },
              child: Text('Convert'),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          app._showChoiceDialog(context);
        },
        tooltip: 'Add Photo',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
