class Vendor {
  int? id;
  String? uuid;
  String? supplierName;
  String? supplierNumber;
  String? businessName;
  String? businessOwner;
  String? businessEmail;
  String? businessAddress;
  String? gstNumber;
  String? drugLicense;
  String? contact;

  Vendor({
    this.id,
    this.uuid,
    this.supplierName,
    this.supplierNumber,
    this.businessName,
    this.businessOwner,
    this.businessEmail,
    this.businessAddress,
    this.gstNumber,
    this.drugLicense,
    this.contact,
  });

  Vendor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    supplierName = json['supplierName'];
    supplierNumber = json['supplierNumber'];
    businessName = json['businessName'];
    businessOwner = json['businessOwner'];
    businessEmail = json['businessEmail'];
    businessAddress = json['businessAddress'];
    gstNumber = json['gstNumber'];
    drugLicense = json['drugLicense'];
    contact = json['contact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['supplierName'] = this.supplierName;
    data['supplierNumber'] = this.supplierNumber;
    data['businessName'] = this.businessName;
    data['businessOwner'] = this.businessOwner;
    data['businessEmail'] = this.businessEmail;
    data['businessAddress'] = this.businessAddress;
    data['gstNumber'] = this.gstNumber;
    data['drugLicense'] = this.drugLicense;
    data['contact'] = this.contact;
    return data;
  }
}
