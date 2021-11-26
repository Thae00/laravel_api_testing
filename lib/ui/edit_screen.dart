import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:laravel_api/auth/api_client.dart';
import 'package:laravel_api/auth/store.dart';
import 'package:laravel_api/models/message.dart';
import 'package:laravel_api/models/post.dart';
import 'package:laravel_api/ui/home.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatefulWidget {
  //take id for edit screen
  int id;
  EditScreen(this.id);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final key = GlobalKey<FormState>();
  String message = "";

  late TextEditingController editTitleController;
  late TextEditingController editDescontroller;

  @override
  void initState() {
    super.initState();
    getPost();
  }

  getPost() async {
    String api = Provider.of<Store>(context, listen: false).getApi();

    Post post = await ApiClient(Dio()).getPostById("Bearer ${api}", widget.id);

    setState(() {
      editTitleController = TextEditingController(text: post.title);
      editDescontroller = TextEditingController(text: post.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Post"),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.redAccent),
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Text(
                      "Edit Post",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Text(
                      "${message}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Form(
                                key: key,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            width: 1,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      child: TextFormField(
                                        controller: editTitleController,
                                        validator: (val) {
                                          if (val == null || val.isEmpty) {
                                            return "Title Must Not Be Empty";
                                          }
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Enter your Post Title',
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            width: 1,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      child: TextFormField(
                                        controller: editDescontroller,
                                        validator: (val) {
                                          if (val == null || val.isEmpty) {
                                            return "Description Must Not Be Empty";
                                          }
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Enter Description',
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10)),
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: TextButton(
                                  onPressed: () async {
                                    if (key.currentState!.validate()) {
                                      String api = Provider.of<Store>(context,
                                              listen: false)
                                          .getApi();

                                      Post post = Post(
                                          0,
                                          editTitleController.text,
                                          editDescontroller.text);
                                      Message msg = await ApiClient(Dio())
                                          .createPost("Bearer ${api}", post);
                                      if (msg.status == true) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Home()));
                                      }
                                    }
                                  },
                                  child: Text(
                                    "Edit Post",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
