import 'package:flutter_app/config/storage_keys.dart';
import 'package:nylo_framework/nylo_framework.dart';
class AuthRepository{
  set saveLoginStatus(bool status) {
    NyStorage.store(StorageKey.isLogin, status);
  }
  Future<bool> get getLoginStatus async {
    return await NyStorage.read<bool>(StorageKey.isLogin);
  }

  set saveToken(String token) {
    // store.write('token', token);
    NyStorage.store(StorageKey.token, token);

  }

  Future<String> get token async {
    // return store.read('token');
    return await NyStorage.read<String>(StorageKey.token);
  }

  // set saveUserData(Map<String, dynamic> user) {
  //   store.write('user', user);
  // }

  // Map<String, dynamic> get userData {
  //   return store.read('user');
  // }

  // // Method to clear user data and token (logout).
  // void clearData() {
  //   store.remove('token');
  //   store.remove('user');
  // }
}