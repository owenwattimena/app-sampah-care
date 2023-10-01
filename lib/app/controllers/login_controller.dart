import 'package:flutter_app/app/models/api_return_value.dart';
import 'package:flutter_app/app/models/user.dart';

import '../networking/user_api_service.dart';
import 'controller.dart';
import 'package:flutter/widgets.dart';

class LoginController extends Controller {
  UserApiService _userApiservice = UserApiService();
  
  construct(BuildContext context) {
    super.construct(context);
  }

  Future<ApiReturnValue?> doLogin(User user) async
  {
    return _userApiservice.login(user);
  }

} 
