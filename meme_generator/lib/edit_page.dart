// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

class EditPage extends StatefulWidget {
  final String imageName;
  const EditPage({Key? key, required this.imageName}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  String topText = "";
  String bottomText = "";
  GlobalKey globalKey = new GlobalKey();

  void initState() {
    super.initState();
    topText = "Top Text";
    bottomText = "Bottom Text";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text('Add text'),
      ),
      body: ListView(
        children: [
          RepaintBoundary(
            key: globalKey,
            child: Stack(
              children: [
                Image.asset('assets/meme/${widget.imageName}.jpg'),
                Positioned(
                  top: 15,
                  left: 100,
                  child: buildStrokeText(topText),
                ),
                Positioned(
                  top: 350,
                  left: 55,
                  child: buildStrokeText(bottomText),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                SizedBox(height: 10),
                TextField(
                  onChanged: (text) {
                    setState(() {
                      topText = text;
                    });
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: "Top Text",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lime),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.lime))),
                ),
                SizedBox(height: 10),
                TextField(
                  onChanged: (text) {
                    setState(() {
                      bottomText = text;
                    });
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: "Bottom Text",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lime),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.lime))),
                ),
                Container(
                    child: TextButton(
                  child: Text(
                    "Export",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  onPressed: () {
                    exportMeme();
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.lime)),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }

  Stack buildStrokeText(String text) {
    return Stack(
      children: [
        Text(text,
            style: TextStyle(
              fontSize: 52,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 6
                ..color = Colors.black,
            )),
        Text(text,
            style: TextStyle(
                fontSize: 52,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ],
    );
  }

  void exportMeme() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();

      final directory = (await getApplicationDocumentsDirectory()).path;

      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png) as ByteData;
      Uint8List pngByte = byteData.buffer.asUint8List();
      File imageFile = File('$directory/meme.png');
      imageFile.writeAsBytesSync(pngByte);

      Share.shareFiles(['$directory/meme.png']);
    } catch (e) {
      print(e);
    }
  }
}
