//
//import 'package:flutter/material.dart';
//import 'package:flutter_beautiful_care_web/features/small_screen/patient_manager_small_body.dart';
//import 'package:flutter_beautiful_care_web/widget/drawer_widget.dart';
//
//import 'patient_manager_small_body_2.dart';
//
//
//class SmallPage extends StatefulWidget {
//
//  static const ROUTE_NAME_SMALL = '/patientmanagepagesmall';
//
//  @override
//  _SmallState createState() => _SmallState();
//}
//
//class _SmallState extends State<SmallPage> {
//  GlobalKey<ScaffoldState> scaffold = GlobalKey();
//  static const TAG = 'PatientManagePage';
//
//  VoidCallback onClick;
//
//  VoidCallback onChange;
//
//  PageController _pageController;
//
//  bool changePage = false;
//
//  @override
//  void initState() {
//    super.initState();
//
//    _pageController = PageController(initialPage: 0);
//    onClick = () {
//      scaffold.currentState?.openEndDrawer();
//    };
//    onChange = () {
//      setState(() {
//        changePage = !changePage;
//      });
//    };
//
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      key: scaffold,
//      appBar: AppBar(
//        elevation: 0,
//        leading: IconButton(
//          icon: Icon(Icons.menu),
//          onPressed: (){
//            scaffold.currentState?.openDrawer();
//          },
//        ),
//        title: SizedBox(
//          child: Image.network(
//            'http://nhakhoasmilecare.vn/wp-content/uploads/2020/02/84662673_231193967896990_8950159524954636288_n-e1581079153594.png',
//            fit: BoxFit.contain,
//          ),
//          height: 40,
//        ),
//      ),
//      drawer: DrawerWidget(onClick, _pageController, onChange, changePage),
//      body: PageView(
//        controller: _pageController,
//        physics: NeverScrollableScrollPhysics(),
//        children: <Widget>[
//          Container(
//            margin: EdgeInsets.symmetric(
//                vertical: 32,
//                horizontal: 40
//            ),
//            clipBehavior: Clip.hardEdge,
//            decoration: ShapeDecoration(
//                color: Colors.white,
//                shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.all(Radius.circular(8))
//                ),
//                shadows: kElevationToShadow[2]
//            ),
//            child: PatientMedicalSmallBody(),
//          ),
//          Container(
//            margin: EdgeInsets.symmetric(
//                vertical: 12,
//                horizontal: 60
//            ),
//            clipBehavior: Clip.hardEdge,
//            decoration: ShapeDecoration(
//                color: Colors.white,
//                shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.all(Radius.circular(8))
//                ),
//                shadows: kElevationToShadow[2]
//            ),
//            child: Container(
//              child: PatientManagerSmallBody2(),
//            ),
//          )
//        ],
//      ),
//    );
//  }
//}