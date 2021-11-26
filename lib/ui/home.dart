import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:laravel_api/auth/api_client.dart';
import 'package:laravel_api/auth/store.dart';
import 'package:laravel_api/models/post.dart';
import 'package:laravel_api/ui/add_post.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    String api = Provider.of<Store>(context).getApi();

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => AddPost()));
        },
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<List<Post>>(
          stream: ApiClient(Dio()).getAllPosts("Bearer ${api}"),
          builder: (context, AsyncSnapshot<List<Post>> snapshots) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshots.data!.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Card(
                    elevation: 5.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          height: 80,
                          alignment: Alignment.center,
                          child: Text(
                            "${snapshots.data![index].text}",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Icon(Icons.edit),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
