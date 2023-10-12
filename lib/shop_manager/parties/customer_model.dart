class Customer {
  int? id;
  String? uuid;
  String? name;
  String? contact;
  String? email;
  String? address;

  Customer({this.id, this.uuid, this.name, this.contact, this.email, this.address});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    name = json['name'];
    contact = json['contact'];
    email = json['email'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['uuid'] = uuid;
    data['name'] = name;
    data['contact'] = contact;
    data['email'] = email;
    data['address'] = address;
    return data;
  }
}
