import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:uts/2_database_helper.dart';
import 'package:uts/1_onlineshop_model.dart';

class OnlineShopDetail extends StatelessWidget {
  final OnlineShopModel? onlineshop;

  OnlineShopDetail(this.onlineshop);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Name : ${onlineshop!.name}'),
            Text('Description : ${onlineshop!.description}'),
            Text('Rating : ${onlineshop!.rating}'),
            Text('Password : ${onlineshop!.password}'),
          ],
        ),
      ),
    );
  }
}
