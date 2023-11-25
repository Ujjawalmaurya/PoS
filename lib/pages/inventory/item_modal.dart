// class InventoryItems {
//   double? id;
//   String? name;
//   String? type;
//   String? category;
//   String? subCategory;
//   String? hsn;
//   String? manufacturer;
//   String? unit;
//   String? batchNum;
//   double? discQty;
//   double? discountPerProduct;
//   String? loc;
//   double? mrp;
//   double? rate;
//   double? totalAmount;
//   double? td;
//   double? cd;
//   double? quantityParent;
//   double? quantityChild;
//   double? quantityMax;
//   double? vendorId;
//   String? expiry;

//   InventoryItems(
//       {this.id,
//       this.name,
//       this.type,
//       this.category,
//       this.subCategory,
//       this.hsn,
//       this.manufacturer,
//       this.unit,
//       this.batchNum,
//       this.discQty,
//       this.discountPerProduct,
//       this.loc,
//       this.mrp,
//       this.rate,
//       this.totalAmount,
//       this.td,
//       this.cd,
//       this.quantityParent,
//       this.quantityChild,
//       this.quantityMax,
//       this.vendorId,
//       this.expiry});

//   InventoryItems.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     type = json['type'];
//     category = json['category'];
//     subCategory = json['subCategory'];
//     hsn = json['hsn'];
//     manufacturer = json['manufacturer'];
//     unit = json['unit'];
//     batchNum = json['batchNum'];
//     discQty = json['discQty'];
//     discountPerProduct = json['discountPerProduct'];
//     loc = json['loc'];
//     mrp = json['mrp'];
//     rate = json['rate'];
//     totalAmount = json['totalAmount'];
//     td = json['td'];
//     cd = json['cd'];
//     quantityParent = json['quantityParent'];
//     quantityChild = json['quantityChild'];
//     quantityMax = json['quantityMax'];
//     vendorId = json['vendorId'];
//     expiry = json['expiry'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     data['type'] = type;
//     data['category'] = category;
//     data['subCategory'] = subCategory;
//     data['hsn'] = hsn;
//     data['manufacturer'] = manufacturer;
//     data['unit'] = unit;
//     data['batchNum'] = batchNum;
//     data['discQty'] = discQty;
//     data['discountPerProduct'] = discountPerProduct;
//     data['loc'] = loc;
//     data['mrp'] = mrp;
//     data['rate'] = rate;
//     data['totalAmount'] = totalAmount;
//     data['td'] = td;
//     data['cd'] = cd;
//     data['quantityParent'] = quantityParent;
//     data['quantityChild'] = quantityChild;
//     data['quantityMax'] = quantityMax;
//     data['vendorId'] = vendorId;
//     data['expiry'] = expiry;
//     return data;
//   }
// }
