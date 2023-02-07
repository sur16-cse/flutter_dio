import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dio/model/list_user_response.dart';
import 'package:flutter_dio/model/user.dart';
import '../http_service.dart';

class ListUserScreen extends StatefulWidget {
  const ListUserScreen({Key? key}) : super(key: key);

  @override
  State<ListUserScreen> createState() => _ListUserScreenState();
}

class _ListUserScreenState extends State<ListUserScreen> {
  late ListUserResponse listUserResponse;
  late List<User> users;
  late HttpService http;
  bool isLoading = false;

  Future getListUser() async {
    Response response;
    try {
      isLoading = true;
      response = await http.getRequest("/api/users?page=2");
      isLoading = false;
      if (response.statusCode == 200) {
        setState(() {
          listUserResponse = ListUserResponse.fromJson(response.data);
          users = listUserResponse.users;
        });
      } else {
        print("There is some problem, status code is not 200");
      }
    } on Exception catch (e) {
      isLoading = false;
      print(e);
    }
  }

  @override
  void initState() {
    http = HttpService();
    getListUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Get Single User"),
        ),
        body: isLoading? const Center(
          child: CircularProgressIndicator(),
        ):users!=null?ListView.builder(itemBuilder: (ctx,index){
          final user=users[index];
          return ListTile(
            title: Text(user.firstName),
            leading: Image.network(user.avatar),
            subtitle: Text(user.email),
          );
        },itemCount: users.length,): const Center(
          child: Text('No User Object'),
        ),
    );
  }
}