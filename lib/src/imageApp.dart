import "dart:convert";
import "package:flutter/material.dart";
import "package:http/http.dart" show get;

import "./models/image_model.dart";
import "./widgets/image_list.dart";

class ImageApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return ImageAppState();
  }
}


class ImageAppState extends State<ImageApp> {
  int counter = 0;

  List<ImageModel> images = [];

  void fetchImage() async {
    counter++;
    final response = await get('https://jsonplaceholder.typicode.com/photos/$counter');
    final imageModel = ImageModel.fromJson(json.decode(response.body));

    setState(() {
      images.add(imageModel);
    });

    print(images.length);
  }




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: fetchImage,
        ),
        appBar: AppBar(
          title: Text("Let's get some images"),
        ),
        body: ImageList(images),
      )
    );
  }

}