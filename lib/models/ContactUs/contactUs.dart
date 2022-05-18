import 'package:flutter/cupertino.dart';

class Autogenerated {
  Result result;
  Null targetUrl;
  bool success;
  Null error;
  bool unAuthorizedRequest;
  bool bAbp;

  Autogenerated(
      {this.result,
        this.targetUrl,
        this.success,
        this.error,
        this.unAuthorizedRequest,
        this.bAbp});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
    targetUrl = json['targetUrl'];
    success = json['success'];
    error = json['error'];
    unAuthorizedRequest = json['unAuthorizedRequest'];
    bAbp = json['__abp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    data['targetUrl'] = this.targetUrl;
    data['success'] = this.success;
    data['error'] = this.error;
    data['unAuthorizedRequest'] = this.unAuthorizedRequest;
    data['__abp'] = this.bAbp;
    return data;
  }
}

class Result {
  int totalCount;
  List<contactUs> items;

  Result({this.totalCount, this.items});

  Result.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['items'] != null) {
      items = new List<contactUs>();
      json['items'].forEach((v) {
        items.add(new contactUs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class contactUs with ChangeNotifier {
  String name;
  String address;
  String issue;
  String phone;
  String id;

  contactUs({this.name, this.address, this.issue, this.phone, this.id});

  contactUs.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    issue = json['issue'];
    phone = json['phone'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['issue'] = this.issue;
    data['phone'] = this.phone;
    data['id'] = this.id;
    return data;
  }
}