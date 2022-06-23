import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TodoFormView extends StatelessWidget {
  const TodoFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo"),
        centerTitle: true,
      ),
      body: SizedBox(
        child: Form(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: "Title"),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(hintText: "Description"),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(hintText: "Cate"),
              ),
              
              SizedBox(height: 10),
              TextFormField(),
            ],
          ),
        )),
      ),
    );
  }
}
