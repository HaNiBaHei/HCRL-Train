// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:meme_generator/edit_page.dart';
import 'package:meme_generator/meme_data.dart';

class SelectMeme extends StatefulWidget {
  const SelectMeme({Key? key}) : super(key: key);

  @override
  _SelectMemeState createState() => _SelectMemeState();
}

class _SelectMemeState extends State<SelectMeme> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        //elevation: 2,
        title: Text(
          'Select Meme',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
          child: ListView(
        children: [
          Wrap(
            spacing: 2,
            runSpacing: 2,
            children: [
              for (var i = 0; i < memeName.length; i++)
                RawMaterialButton(
                  onPressed: () {
                    //print(memeName[i]);
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return EditPage(imageName: memeName[i]);
                      },
                    ));
                  },
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 4) / 3,
                    height: (MediaQuery.of(context).size.width - 4) / 3,
                    child: Image.asset(
                      'assets/meme/${memeName[i]}.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                )
            ],
          )
        ],
      )),
    );
  }
}
