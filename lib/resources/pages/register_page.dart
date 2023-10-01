import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import '../../app/models/user.dart';
import '../../bootstrap/helpers.dart';
import '/app/controllers/register_controller.dart';
import '../../app/models/api_return_value.dart';

class RegisterPage extends NyStatefulWidget {
  final RegisterController controller = RegisterController();

  static const path = '/register';

  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends NyState<RegisterPage> {
  Key _key = Key('form');
  TextEditingController _nikController = TextEditingController();
  TextEditingController _namaController = TextEditingController();
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
                Text('Belum\nPunya Akun?')
                    .headingMedium(context)
                    .fontWeightBold(),
                Image.asset(
                  'public/assets/images/sampah_care_2.png',
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
                      controller: _nikController,
                      decoration: const InputDecoration(label: Text('NIK')),
                      validator: (value) {
                        if (value == null) return 'NIK tidak boleh kosong';
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _namaController,
                      decoration: const InputDecoration(label: Text('Nama')),
                      validator: (value) {
                        if (value == null) return 'Nama tidak boleh kosong';
                        return null;
                      },
                    ),
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
                      controller: _passwordController,
                      obscureText: true,
                      decoration:
                          const InputDecoration(label: Text('Password')),
                      validator: (value) {
                        if (value == null) return 'Password tidak boleh kosong';
                        return null;
                      },
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: isLoading(name:'register') ? null : doRegister,
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(Size(130, 40)),
                        backgroundColor: MaterialStateProperty.all(
                            ThemeColor.get(context).primaryContent),
                      ),
                      child: Text('DAFTAR'),
                    ),
                    TextButton(
                        onPressed: isLoading(name:'register') ? null : () {
                          Navigator.pop(context);
                        },
                        child: Text('Sudah punya akun? Masuk disini').setStyle(
                            TextStyle(
                                color: ThemeColor.get(context).primaryContent)))
                  ],
                ))
          ]),
        ),
      )),
    );
  }

  void doRegister() async {
    setLoading(true, name: 'register');
    User user = User(
      nik: _nikController.text,
      nama: _namaController.text,
      username: _usernameController.text,
      password: _passwordController.text,
    );
    ApiReturnValue? result = await widget.controller.doRegister(user);
    if (result == null) {
      showToastOops(
          description: "Terjadi kesalahan saat melakukan registrasi.");
      setLoading(false, name: 'register');

      return;
    }

    if (result.status) {
      showToastSuccess(description: result.message!);
    } else {
      showToastSorry(description: result.message!);
    }
    setLoading(false, name: 'register');
  }
}
