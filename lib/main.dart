import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:developer';

File? imageFile;
String _convertTo = "txt";
String? message = null;
ImagePicker picker = new ImagePicker();
final myController = TextEditingController();

//
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Retrieve Text Input',
      home: MyCustomForm(),
    );
  }
}

//
Future getData(url) async {
  Response response = await get(url);
  return response.body;
}

void main() {
  runApp(/*const*/ MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
                      _openGallery(context);
                    },
                  ),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  _openGallery(BuildContext context) async {
    var pic = await picker.pickImage(source: ImageSource.gallery);
    imageFile = File(pic!.path);
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var pic = await picker.pickImage(source: ImageSource.camera);
    imageFile = File(pic!.path);
    Navigator.of(context).pop();
    var xxx = imageFile!.path.split("/").last;
    var xxxx = imageFile!.length();
    log('img: $xxx');
    log('img: $xxxx');
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

  void _sendData(String filename, String url) async {

    // String url = "https://700f-194-169-191-205.eu.ngrok.io";
    // var request = http.MultipartRequest(
    //     "POST", Uri.parse("https://700f-194-169-191-205.eu.ngrok.io/upload"));
    // var headers = {"Content-type": "multipart/form/data"};
    // request.files.add(http.MultipartFile(
    //     'image', imageFile!.readAsBytes().asStream(), imageFile!.lengthSync(),
    //     filename: imageFile!.path.split("/").last));
    // //problem aici poate

    // request.headers.addAll(headers);
    // var response = await request.send();
    // http.Response res = await http.Response.fromStream(response);
    // var resJson/*= jsonDecode(res.body);
    // var pdfText=*/
    //     = await res.body;
    // message = resJson[0];
    // log('msg: $message');
    // setState(() {});
    
// var request = http.MultipartRequest(
//       'POST',
//       Uri.parse("https://4c5a-194-169-191-205.eu.ngrok.io/upload"),
//     );
//     Map<String, String> headers = {"Content-type": "multipart/form-data"};
//     request.files.add(
//       http.MultipartFile(
//         'image',
//         imageFile!.readAsBytes().asStream(),
//         imageFile!.lengthSync(),
//         filename: imageFile!.path.split('/').last,
//       ),
//     );
//     request.headers.addAll(headers);
//     print("request: " + request.toString());
//     var res = await request.send();
//     http.Response response = await http.Response.fromStream(res);
//     setState(() {
//       var resJson = response.body;
//     });


  var request = http.MultipartRequest('POST', Uri.parse(myController.text+"/upload"));
  request.files.add(
    http.MultipartFile(
      'image',
      File(filename).readAsBytes().asStream(),
      File(filename).lengthSync(),
      filename: filename.split("/").last
    )
  );
  var res = await request.send();

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
            TextField(
              controller: myController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'uritardid',
              ),
            ),
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
                _sendData(imageFile!.path,myController.text+"/upload");
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
