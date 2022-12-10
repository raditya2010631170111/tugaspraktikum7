import 'package:flutter/material.dart';
import 'package:uts/1_onlineshop_model.dart';
import 'package:uts/2_database_helper.dart';

class FormOnlineShop extends StatefulWidget {
  final OnlineShopModel? onlineshop;

  FormOnlineShop({this.onlineshop});

  @override
  _FormOnlineShopState createState() => _FormOnlineShopState();
}

class _FormOnlineShopState extends State<FormOnlineShop> {
  DatabaseHelper db = DatabaseHelper();

  TextEditingController? name;
  TextEditingController? description;
  TextEditingController? rating;
  TextEditingController? password;

  @override
  void initState() {
    name = TextEditingController(
        text: widget.onlineshop == null ? '' : widget.onlineshop!.name);
    description = TextEditingController(
        text: widget.onlineshop == null ? '' : widget.onlineshop!.description);
    rating = TextEditingController(
        text: widget.onlineshop == null ? '' : widget.onlineshop!.rating);
    password = TextEditingController(
        text: widget.onlineshop == null ? '' : widget.onlineshop!.password);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        primary: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)));
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Online Shop'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding: EdgeInsets.all(18.0),
        children: [
          TextField(
              controller: name,
              decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)))),
          TextField(
              controller: description,
              decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)))),
          TextField(
              controller: rating,
              decoration: InputDecoration(
                  labelText: 'Rating',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)))),
          TextField(
              controller: password,
              decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)))),
          ElevatedButton(
            child: (widget.onlineshop == null)
                ? Text('Add', style: TextStyle(color: Colors.yellow))
                : Text('Update', style: TextStyle(color: Colors.yellow)),
            style: style,
            onPressed: () {
              upsertOnlineShop();
            },
          )
        ],
      ),
    );
  }

  Future<void> upsertOnlineShop() async {
    if (widget.onlineshop != null) {
      await db.updateOnlineShop(OnlineShopModel.fromMap({
        //insert
        'id': widget.onlineshop!.id,
        'name': name!.text,
        'description': description!.text,
        'rating': rating!.text,
        'password': password!.text,
      }));
      Navigator.pop(context, 'update');
    } else {
      await db.saveOnlineShop(OnlineShopModel(
        //update
        name: name!.text,
        description: description!.text,
        rating: rating!.text,
        password: password!.text,
      ));
      Navigator.pop(context, 'save');
    }
  }
}
