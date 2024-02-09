import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lesson_two_shared_preference/model/account_model.dart';

class SecureService{
  static storeApiKey(String api_key){
    const storage = FlutterSecureStorage();
    storage.write(key: 'api_key', value: api_key);
  }
  static Future<String?> loadApiKey() async{
    const storage = FlutterSecureStorage();
   return storage.read(key: "api_key");
  }
  static storeAccount(Account account){
    const storage = FlutterSecureStorage();
    String accountString = jsonEncode(account);
    storage.write(key: "account", value: accountString);
  }
  static Future<Account?> loadAccount() async{
    const storage = FlutterSecureStorage();
    String? getString = await storage.read(key: "account");
    if(getString==null || getString.isEmpty) return null;
    Map<String,dynamic> map = jsonDecode(getString);
    return Account.fromJson(map);
  }

}