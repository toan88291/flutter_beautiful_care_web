import 'package:flutter/material.dart';
import 'package:flutter_beautiful_care_web/features/category/category_page.dart';
import 'package:flutter_beautiful_care_web/features/body_widget.dart';
import 'package:flutter_beautiful_care_web/utils/responsive.dart';
import 'package:flutter_beautiful_care_web/widget/drawer_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';
import 'category/sub_category_widget.dart';
import 'constant.dart';
import 'post/detail_post_widget.dart';
import 'user/user_page.dart';


class MainPage extends StatefulWidget {
  static const ROUTE_NAME = '/MainPage';
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  GlobalKey<ScaffoldState> scaffold = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ResponsiveScreen(
      largeScreen: LargePage(),
    );
  }

}

class LargePage extends StatefulWidget {

  static const ROUTE_NAME = '/MainPage';

  @override
  _LargeState createState() => _LargeState();
}

class _LargeState extends State<LargePage> {

  GlobalKey<ScaffoldState> scaffold = GlobalKey();

  ValueChanged<int> onClick;

  ValueChanged<int> onLoad;

  ValueChanged<Tuple2<String,String>> onchangePage;

  PageController _pageController;

  String id;

  int indexMenu = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    onClick = (index) {
      setState(() {
        indexMenu = index;
      });
      scaffold.currentState?.openEndDrawer();
    };

    onchangePage = (data) {
      setState(() {
        indexMenu = -1;
        _pageController.jumpToPage(int.parse(data.item1));
        id = data.item2;
      });
    };

    onLoad = (index){
      setState(() {
        indexMenu = -1;
        _pageController.jumpToPage(index);
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
      drawer: DrawerWidget(onClick, _pageController, indexMenu),
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
            child: BodyWidget(onchangePage),
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
              child: CategoryPage(onchangePage),
            ),
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
              child: SubCategoryWidget(id),
            ),
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
              child: DetailPostWidget(id,onLoad),
            ),
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
              child: UserPage(onchangePage),
            ),
          ),
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
