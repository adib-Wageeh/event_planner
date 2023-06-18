import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CodeModel extends Equatable{

  String code;
  String street;
  String town;
  String company;
  String email;
  DateTime dateAdded;
  String id;
  bool activation;
  CodeModel({required this.activation,required this.id,required this.code,required this.dateAdded,required this.email,required this.company,required this.street,required this.town});

  factory CodeModel.fromJson(Map<String, dynamic> json,String documentId) {
    final Timestamp timestamp = json['date_added'];
    final DateTime dateTime = timestamp.toDate();
    return CodeModel(
      street: json['addressStreet'],
      activation: json['activation'],
      town: json['addressTown'],
      code: json['code'],
      company: json['companyName'],
      email: json['email'],
      dateAdded: dateTime,
      id: documentId
    );
  }

  // Convert a CodeModel instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'addressStreet': street,
      'addressTown':town,
      'companyName':company,
      'email':email,
      'dateAdded': dateAdded.toIso8601String(),
      'activation':activation
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [code,dateAdded,street,town,company,email,id,activation];


}