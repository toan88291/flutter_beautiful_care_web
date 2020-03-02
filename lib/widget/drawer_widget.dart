import 'package:flutter/material.dart';
import 'package:flutter_beautiful_care_web/features/constant.dart';
import 'package:flutter_beautiful_care_web/features/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatefulWidget {

  final VoidCallback onClick;

  final PageController pageController;

  final VoidCallback onChange;

  final bool changePage;

  DrawerWidget(this.onClick, this.pageController, this.onChange, this.changePage);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {


  String username;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value){
      setState(() {
        username = value.getString(USERNAME);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: widget.onClick,
                  icon: Icon(Icons.arrow_back, color: Colors.blue,),
                ),
              ),
              SizedBox(width: 12,),
              Text(
                username ?? '',
              )
            ],
          ),
          InkWell(
            onTap: (){
              if(widget.changePage != false) {
                widget.onChange();
                widget.onClick();
                widget.pageController.jumpToPage(0);
              }
            },
            child: Container(
              color: widget.changePage == false ? Colors.grey.withOpacity(0.3) : Colors.white,
              child: ListTile(
                title: Text('Quản lý bài viết',style: Theme.of(context).textTheme.subtitle.copyWith(
                    color: Colors.black87
                ),),
              ),
            ),
          ),
          InkWell(
            onTap: (){
              if (widget.changePage == false) {
                widget.onChange();
                widget.onClick();
                widget.pageController.jumpToPage(1);
              }
            },
            child: Container(
              color: widget.changePage ? Colors.grey.withOpacity(0.3) : Colors.white,
              child: ListTile(
                title: Text('Quản lý danh mục',style: Theme.of(context).textTheme.subtitle.copyWith(
                    color: Colors.black87
                ),),
              ),
            ),
          ),
          InkWell(
            onTap: (){
              SharedPreferences.getInstance().then((value){
                value.clear();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                  return LoginPage();
                }));
              });
            },
            child: Container(
              padding: EdgeInsets.only(left: 16, top: 12, bottom: 12),
              alignment: Alignment.centerLeft,
              child: Text(
                'Đăng Xuất',
                style: Theme.of(context).textTheme.subtitle.copyWith(
                    color: Colors.red
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
