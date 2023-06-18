import 'code_model.dart';

class UserModel{

  String username;
  String fcmToken;
  String imei;
  bool isAdmin;
  CodeModel codeModel;
  String id;

  UserModel({required this.id,required this.codeModel,required this.isAdmin,required this.username,required this.fcmToken,required this.imei});

  factory UserModel.fromJson(Map<String, dynamic> json,String documentId,bool isAdmin,CodeModel codeModel) {
    return UserModel(
        username: json['username'],
        fcmToken: json['fcmToken'],
        codeModel: codeModel,
        imei: json['imei'],
        isAdmin: isAdmin,
        id: documentId
    );
  }

}