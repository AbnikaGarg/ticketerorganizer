class GuestListNewModel {
  GuestListNewModel({
      this.status, 
      this.message, 
      this.data,});

  GuestListNewModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(GuestListNewModelData.fromJson(v));
      });
    }
  }
  int? status;
  String? message;
  List<GuestListNewModelData>? data;

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

class GuestListNewModelData {
  GuestListNewModelData({
      this.bookingNo, 
      this.name, 
      this.mobile, 
      this.emailId, 
      this.ticketName, 
      this.vrNo, 
      this.qty, 
      this.newBookingNo, 
      this.checkInId, 
      this.checkInDate, 
      this.eventDayStartDate, 
      this.eventStartTime, 
      this.eventDayStartDateUTC, 
      this.haveAddOnTag,
      this.errorCode, 
      this.errorDesc,});

  GuestListNewModelData.fromJson(dynamic json) {
    bookingNo = json['bookingNo'];
    name = json['name'];
    haveAddOnTag=json['haveAddOnTag'];
    mobile = json['mobile'];
    emailId = json['emailId'];
    ticketName = json['ticketName'];
    vrNo = json['vrNo'];
    qty = json['qty'];
    newBookingNo = json['newBookingNo'];
    checkInId = json['checkInId'];
    checkInDate = json['checkInDate'];
    eventDayStartDate = json['eventDayStartDate'];
    eventStartTime = json['eventStartTime'];
    eventDayStartDateUTC = json['eventDayStartDateUTC'];
    errorCode = json['errorCode'];
    errorDesc = json['errorDesc'];
  }
  String? bookingNo;
  String? name;
  String? mobile;
  String? emailId;
  String? ticketName;
  String? vrNo;
  int? qty;
  String? newBookingNo;
  int? checkInId;
  String? checkInDate;
  String? eventDayStartDate;
  String? eventStartTime;
  String? eventDayStartDateUTC;
  int? errorCode;
  bool? haveAddOnTag;
  String? errorDesc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bookingNo'] = bookingNo;
    map['name'] = name;
    map['mobile'] = mobile;
    map['emailId'] = emailId;
    map['haveAddOnTag']=haveAddOnTag;
    map['ticketName'] = ticketName;
    map['vrNo'] = vrNo;
    map['qty'] = qty;
    map['newBookingNo'] = newBookingNo;
    map['checkInId'] = checkInId;
    map['checkInDate'] = checkInDate;
    map['eventDayStartDate'] = eventDayStartDate;
    map['eventStartTime'] = eventStartTime;
    map['eventDayStartDateUTC'] = eventDayStartDateUTC;
    map['errorCode'] = errorCode;
    map['errorDesc'] = errorDesc;
    return map;
  }

}