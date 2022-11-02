import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String url = 'https://randomuser.me/api/?results=50';
  bool isLoading = false;
  late List userData;

  getData() async {
    var response = await http.get(
      Uri.parse(url),
    );

    List data = jsonDecode(response.body)['results'];
    setState(() {
      userData = data;
      isLoading = true;

      print(userData);
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RANDOMuSER'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Builder(builder: (context) {
          if (isLoading == true) {
            return ListView.builder(
              itemCount: userData.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  child: Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                    child: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(userData[index]['name']['first']),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Gender'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Email'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return CircularProgressIndicator();
        }),
      ),
    );
  }
}
