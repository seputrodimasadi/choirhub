import "package:flutter/material.dart";
import "../models/image_model.dart";

class ImageList extends StatelessWidget {

  final List<ImageModel> images;

  ImageList(this.images);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: images.length,
      itemBuilder: (context, int index) {
        return buildImage(images[index]);
      },
    );
  }


  Widget buildImage(ImageModel image) {
    return Container(
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black12,
          width: 8.0,
        ),
      ),
      child: Column(
        children: <Widget>[
          Image.network(image.url),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(image.title),
          ),
        ],
      ),
    );
  }

}