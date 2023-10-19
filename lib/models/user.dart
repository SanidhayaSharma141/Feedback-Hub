class UserData {
  /// Readonly
  int? id;
  String? email;
  bool isAdmin = false;
  String type = "student";
  String? name;
  int modifiedAt = 0;

  /// Editable
  String? phoneNumber, address;
  String? imgUrl;

  UserData.other({
    this.id,
    this.email,
    this.name,
    this.phoneNumber,
    this.address,
    this.imgUrl,
  });

  UserData({
    this.id,
    this.email,
    this.name,
    this.phoneNumber,
    this.address,
    this.imgUrl,
  });

  Map<String, dynamic> encode() {
    return {
      if (phoneNumber != null) "phoneNumber": phoneNumber,
      if (id != null) "id": id,
      if (address != null) "address": address,
      if (imgUrl != null) "imgUrl": imgUrl,
      "isAdmin": isAdmin,
      "modifiedAt": modifiedAt,
      "type": type,
      if (name != null) "name": name,
    };
  }

  void load(Map<String, dynamic> data) {
    phoneNumber = data['phoneNumber'] ?? phoneNumber;
    address = data['address'] ?? address;
    imgUrl = data['imgUrl'] ?? imgUrl;
    isAdmin = data['isAdmin'] ?? isAdmin;
    type = data['type'] ?? type;
    id = data['id'] ?? id;
    name = data['name'] ?? name;
    modifiedAt = data['modifiedAt'] ?? modifiedAt;
  }
}
