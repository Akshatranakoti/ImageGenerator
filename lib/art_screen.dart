import 'dart:io';

import 'package:art_images_generator/colors.dart';
import 'package:art_images_generator/hexcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ArtScreen extends StatefulWidget {
  const ArtScreen({super.key});

  @override
  State<ArtScreen> createState() => _ArtScreenState();
}

class _ArtScreenState extends State<ArtScreen> {
  List imgList = [];
  getImages() async {
    final directory = Directory("storage/emulated/0/AI_Image");
    imgList = directory.listSync();
    print(imgList);
  }

  popImage(filepath) {
    showDialog(
        context: context,
        builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Container(
                clipBehavior: Clip.antiAlias,
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                    color: whiteColor, borderRadius: BorderRadius.circular(12)),
                child: Image.file(
                  filepath,
                  fit: BoxFit.cover,
                ),
              ),
            ));
  }

  @override
  void initState() {
    super.initState();
    getImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (AppBar(
        title: const Text(
          "Art Gallery",
          style: TextStyle(fontWeight: FontWeight.bold, color: whiteColor),
        ),
      )),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("CB2B93"),
          hexStringToColor("9546C4"),
          hexStringToColor("5E61F4")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: GridView.builder(
              physics: BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: imgList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    popImage(imgList[index]);
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    clipBehavior: Clip.antiAlias,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    child: Image.file(imgList[index]),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
