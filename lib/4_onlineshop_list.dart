import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:uts/1_onlineshop_model.dart';
import 'package:uts/2_database_helper.dart';
import 'package:uts/5_onlineshop_detail.dart';
import '3_form_onlineshop.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: const OnlineShopList(),
    );
  }
}

class OnlineShopList extends StatefulWidget {
  const OnlineShopList({Key? key}) : super(key: key);

  @override
  _OnlineShopListState createState() => _OnlineShopListState();
}

class _OnlineShopListState extends State<OnlineShopList> {
  List<OnlineShopModel> listOnlineShop = [];
  DatabaseHelper db = DatabaseHelper();

  @override
  void initState() {
    _getAllOnlineShop();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text('Daftar Router'), backgroundColor: Colors.yellow),
      body: ListView.builder(
          itemCount: listOnlineShop.length,
          itemBuilder: (context, index) {
            OnlineShopModel onlineshop = listOnlineShop[index];

            return ListTile(
              onTap: () {
                //edit
                _openFormEdit(onlineshop);
              },
              contentPadding: EdgeInsets.all(16),
              title: Text(
                '${onlineshop.name}',
                style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: Colors.blue),
              ),
              subtitle: Text('${onlineshop.description}'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  AlertDialog delete = AlertDialog(
                    title: Text('Verification'),
                    content: Container(
                      height: 120,
                      child: Column(
                        children: [
                          Text(
                              'Are you sure you want to permanently delete this data? ${onlineshop.password}'),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: Text('Yes'),
                        onPressed: () {
                          //delete
                          _deleteOnlineShop(onlineshop, index);
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: Text('No'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                  showDialog(context: context, builder: (context) => delete);
                },
              ),
              leading: IconButton(
                onPressed: () {
                  //detail
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OnlineShopDetail(onlineshop)));
                },
                icon: Icon(Icons.visibility),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        onPressed: () {
          //add
          _openFormCreate();
        },
      ),
    );
  }

  Future<void> _getAllOnlineShop() async {
    var list = await db.getAllOnlineShop();
    setState(() {
      listOnlineShop.clear();
      list!.forEach((onlineshop) {
        listOnlineShop.add(OnlineShopModel.fromMap(onlineshop));
      });
    });
  }

  Future<void> _deleteOnlineShop(
      OnlineShopModel onlineshop, int position) async {
    await db.deleteOnlineShop(onlineshop.id!);

    setState(() {
      listOnlineShop.removeAt(position);
    });
  }

  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormOnlineShop()));
    if (result == 'save') {
      await _getAllOnlineShop();
    }
  }

  Future<void> _openFormEdit(OnlineShopModel onlineshop) async {
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FormOnlineShop(onlineshop: onlineshop)));
    if (result == 'update') {
      await _getAllOnlineShop();
    }
  }
}
