class VendorListModel {
  VendorListModel({
      this.status, 
      this.message, 
      this.data,});

  VendorListModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  int? status;
  String? message;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Data {
  Data({
      this.vendorId, 
      this.vendorCode, 
      this.name, 
      this.companyName, 
      this.bannerImage, 
      this.logoImage, 
      this.shortDescr, 
      this.longDescr, 
      this.email, 
      this.contactNo, 
      this.address, 
      this.address1, 
      this.countryId, 
      this.country, 
      this.stateId, 
      this.state, 
      this.city, 
      this.pincode, 
      this.createdUserId, 
      this.logoImagePath, 
      this.errorCode, 
      this.isSelected,
      this.errorDesc,});

  Data.fromJson(dynamic json) {
    vendorId = json['vendorId'];
    vendorCode = json['vendorCode'];
    name = json['name'];
    companyName = json['companyName'];
    bannerImage = json['bannerImage'];
    logoImage = json['logoImage'];
    shortDescr = json['shortDescr'];
    isSelected = false;
    longDescr = json['longDescr'];
    email = json['email'];
    contactNo = json['contactNo'];
    address = json['address'];
    address1 = json['address1'];
    countryId = json['countryId'];
    country = json['country'];
    stateId = json['stateId'];
    state = json['state'];
    city = json['city'];
    pincode = json['pincode'];
    createdUserId = json['createdUserId'];
    logoImagePath = json['logoImagePath'];
    errorCode = json['errorCode'];
    errorDesc = json['errorDesc'];
  }
  int? vendorId;
  String? vendorCode;
  String? name;
  String? companyName;
  String? bannerImage;
  String? logoImage;
  String? shortDescr;
  String? longDescr;
  String? email;
  String? contactNo;
  String? address;
  String? address1;
  int? countryId;
  String? country;
  int? stateId;
  String? state;
  String? city;
  String? pincode;
  int? createdUserId;
  dynamic logoImagePath;
  int? errorCode;
  bool? isSelected;
  String? errorDesc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['vendorId'] = vendorId;
    map['vendorCode'] = vendorCode;
    map['name'] = name;
    map['companyName'] = companyName;
    map['bannerImage'] = bannerImage;
    map['logoImage'] = logoImage;
    map['shortDescr'] = shortDescr;
    map['longDescr'] = longDescr;
    map['email'] = email;
    map['contactNo'] = contactNo;
    map['address'] = address;
    map['address1'] = address1;
    map['countryId'] = countryId;
    map['country'] = country;
    map['stateId'] = stateId;
    map['state'] = state;
    map['city'] = city;
    map['pincode'] = pincode;
    map['createdUserId'] = createdUserId;
    map['logoImagePath'] = logoImagePath;
    map['errorCode'] = errorCode;
    map['errorDesc'] = errorDesc;
    map['isSelected'] = isSelected;
    return map;
  }

}