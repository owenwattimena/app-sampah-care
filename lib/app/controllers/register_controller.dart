import 'controller.dart';
import 'package:flutter/widgets.dart';
import '../networking/user_api_service.dart';
import '../models/api_return_value.dart';
import '../models/user.dart';
class RegisterController extends Controller {

  UserApiService _userApiService = UserApiService();
  
  construct(BuildContext context) {
    super.construct(context);
  }

  Future<ApiReturnValue?> doRegister(User user) async 
  {
    return _userApiService.register(user);
  }

} 
