import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import '../../app/models/api_return_value.dart';
import '../../app/models/user.dart';
import '../../app/repositories/auth_repository.dart';
import '../../bootstrap/helpers.dart';
import '/app/controllers/login_controller.dart';
import 'dashboard_page.dart';
import 'register_page.dart';

class LoginPage extends NyStatefulWidget {
  final LoginController controller = LoginController();

  static const path = '/login';

  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends NyState<LoginPage> {
  Key _key = Key('form');
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  init() async {
    super.init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 30),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Sudah\nPunya Akun?')
                    .headingMedium(context)
                    .fontWeightBold(),
                Image.asset(
                  'public/assets/images/sampah_care_1.png',
                  width: 140,
                )
              ],
            ),
            SizedBox(height: 50),
            Form(
                key: _key,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      decoration:
                          const InputDecoration(label: Text('Username')),
                      validator: (value) {
                        if (value == null) return 'Username tidak boleh kosong';
                        return null;
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration:
                          const InputDecoration(label: Text('Password')),
                      validator: (value) {
                        if (value == null) return 'Password tidak boleh kosong';
                        return null;
                      },
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: isLoading(name: "login") ? null : doLogin,
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(Size(130, 40)),
                        backgroundColor: MaterialStateProperty.all(
                            ThemeColor.get(context).primaryContent),
                      ),
                      child: Text('MASUK'),
                    ),
                    TextButton(
                        onPressed: isLoading(name: "login") ? null : () {
                          routeTo(RegisterPage.path);
                        },
                        child: Text('Pengguna baru? Daftar disini').setStyle(
                            TextStyle(
                                color: ThemeColor.get(context).primaryContent)))
                  ],
                ))
          ]),
        ),
      )),
    );
  }

  void doLogin() async {
    setLoading(true, name: 'login');

    User user = User(
      username: _usernameController.text,
      password: _passwordController.text,
    );
    ApiReturnValue? result = await widget.controller.doLogin(user);
    if (result == null) {
      showToastOops(
          description: "Terjadi kesalahan saat melakukan login.");
      setLoading(false, name: 'login');
      return;
    }

    if (result.status) {
      showToastSuccess(description: result.message!);
      User user = (result.data as User);
      print(user.toString());
      await Auth.login(user);   
      AuthRepository().saveToken = user.token!;
      routeTo(DashboardPage.path, navigationType: NavigationType.pushReplace);
    } else {
      showToastSorry(description: result.message!);
    }

    setLoading(false, name: 'login');

  }
}
