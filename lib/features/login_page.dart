
import 'package:flutter/material.dart';
import 'package:flutter_beautiful_care_web/data/category_repository.dart';
import 'package:flutter_beautiful_care_web/features/main_page.dart';
import 'package:flutter_beautiful_care_web/widget/show_dialog_loading.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constant.dart';

class LoginPage extends StatefulWidget {
  static const ROUTE_NAME = 'login';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  static const TAG = 'LoginPage';

  GlobalKey<FormState> globalKey = GlobalKey();

  GlobalKey<ScaffoldState> scaffold = GlobalKey();
  
  String username;

  String password;

  CategoryRepository categoryRepository;


  Future<bool> login() async {
    return categoryRepository.login(username, password);
  }

  void loadLogin() async {
    showDialogProgressLoading<bool>(context, login()).then((value){
      if(value) {
        SharedPreferences.getInstance().then((value){
          value.setString(USERNAME, username);
          value.setString(PASSWORD, password);
        });
        Navigator.of(context).pushNamed(MainPage.ROUTE_NAME);
      } else {
        scaffold.currentState.showSnackBar(SnackBar(
          content: Container(
            height: 40,
            alignment: Alignment.center,
            child: Text('Đăng nhập thất bại'),
          ),
          backgroundColor: Colors.redAccent,
        ));
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    categoryRepository = Provider.of<CategoryRepository>(context, listen: false);
    SharedPreferences.getInstance().then((value){
      if (value.getString(USERNAME).isNotEmpty
          && value.getString(PASSWORD).isNotEmpty) {
        Navigator.of(context).pushReplacementNamed(MainPage.ROUTE_NAME);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold,
      body: Form(
        key: globalKey,
        child: Container(
          color: Colors.blue[600],
          alignment: Alignment.center,
          child: Card(
            elevation: 1,
            child: Container(
              padding: EdgeInsets.all(20),
              constraints: BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        icon: Icon(Icons.account_circle),
                        hintText: 'Tên Đăng Nhập',
                        filled: true
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Không được để trống !';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      username = value;
                    },
                  ),
                  Divider(
                    height: 24,
                    color: Colors.transparent,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      hintText: 'Mật Khẩu',
                      filled: true,
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Không được để trống !';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      password = value;
                    },
                  ),
                  Divider(
                    height: 24,
                    color: Colors.transparent,
                  ),
                  RaisedButton(
                    color: Colors.blue[600],
                    shape: StadiumBorder(),
                    onPressed: (){
                      if (globalKey.currentState.validate()) {
                        globalKey.currentState.save();
                        loadLogin();
                      }
                    },
                    child: Text('Đăng nhập',style: TextStyle(color: Colors.white),),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
