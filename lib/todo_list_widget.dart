import "package:flutter/material.dart";


class TodoListDisplay extends StatefulWidget {
  @override
  State createState() => new TodosList();
}


class TodosList extends State<TodoListDisplay> {

  List<String> litems = [];

  final TextEditingController eCtrl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('Dynamic Demo'),),

      body: Column(
        children: <Widget>[
          TextField(
            controller: eCtrl,
            onSubmitted: (text) {
              litems.add(text);
              eCtrl.clear();
              setState(() {});
            },
          ),
          Expanded(
            child: ListView.builder (
              itemCount: litems.length,
              itemBuilder: (BuildContext context, int index) {
                return Text(litems[index]);
              },
            ),
          ),
        ],
      ),

    );
  }

}