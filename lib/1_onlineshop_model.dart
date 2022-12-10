class OnlineShopModel {
  late int? id;
  late String? name;
  late String? description;
  // late String? pictureId;
  late String? rating;
  late String? password;

  OnlineShopModel(
      {this.id,
      required this.name,
      required this.description,
      required this.rating,
      required this.password}); //this.pictureId,

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }
    map['name'] = name; //<'id' = String = "key", id = dynamic = "value">
    map['description'] = description;
    // map['pictureId'] = pictureId,
    map['rating'] = rating;
    map['password'] = password;
    return map;
  }

  OnlineShopModel.fromMap(Map<String, dynamic> map) {
    //constructor
    this.id = map['id'];
    this.name = map['name'];
    this.description = map['description'];
    // this.pictureId = map['pictureId'];
    this.rating = map['rating'];
    this.password = map['password'];
  }
}
