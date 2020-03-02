
import 'package:flutter/material.dart';
import 'package:flutter_beautiful_care_web/features/category/category_page.dart';
import 'package:flutter_beautiful_care_web/features/patient_manager_body.dart';
import 'package:flutter_beautiful_care_web/features/patient_manager_body_2.dart';
import 'package:flutter_beautiful_care_web/utils/responsive.dart';
import 'package:flutter_beautiful_care_web/widget/drawer_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constant.dart';
import 'small_screen/small_page.dart';


class PatientManagePage extends StatefulWidget {
  static const ROUTE_NAME = '/patientmanagepage';
  @override
  _PatientManagePageState createState() => _PatientManagePageState();
}

class _PatientManagePageState extends State<PatientManagePage> {
  static const TAG = 'PatientManagePage';
  GlobalKey<ScaffoldState> scaffold = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ResponsiveScreen(
      largeScreen: LargePage(),
      smallScreen: Container(),
    );
  }

}

class LargePage extends StatefulWidget {

  static const ROUTE_NAME = '/patientmanagepage';

  @override
  _LargeState createState() => _LargeState();
}

class _LargeState extends State<LargePage> {
  static const TAG = 'PatientManagePage';

  GlobalKey<ScaffoldState> scaffold = GlobalKey();

  VoidCallback onClick;

  VoidCallback onChange;

  VoidCallback onLoad;

  PageController _pageController;

  bool changePage = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    onClick = () {
      scaffold.currentState?.openEndDrawer();
    };
    onChange = () {
      setState(() {
        changePage = !changePage;
      });
    };

    onLoad = (){
      setState(() {

      });
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SharedPreferences.getInstance().then((value){
      if (value.getString(USERNAME).isEmpty
          && value.getString(PASSWORD).isEmpty) {
        Navigator.of(context).pushNamed('/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: (){
            scaffold.currentState?.openDrawer();
          },
        ),
        title: Text(
          'Beautiful Care'
        ),
      ),
      drawer: DrawerWidget(onClick, _pageController, onChange, changePage),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 60
            ),
            clipBehavior: Clip.hardEdge,
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))
                ),
                shadows: kElevationToShadow[2]
            ),
            child: PatientManagerBody(),
          ),
          Container(
            margin: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 60
            ),
            clipBehavior: Clip.hardEdge,
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))
                ),
                shadows: kElevationToShadow[2]
            ),
            child: Container(
              child: CategoryPage(),
            ),
          )
        ],
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: (){
//          _showInput().then((value) => {});
//        },
//        child: Icon(Icons.add),
//      ),
    );

  }

}
