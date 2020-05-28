import 'package:flutter/material.dart';
import 'package:flutter_beautiful_care_web/data/category_repository.dart';
import 'package:flutter_beautiful_care_web/data/models/user.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import 'header_user_widget.dart';
import 'row_user_widget.dart';

class UserPage extends StatefulWidget {
  final ValueChanged<Tuple2<String,String>> onchangePage;

  UserPage(this.onchangePage);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<User> data;

  VoidCallback onLoad;

  CategoryRepository categoryRepository;

  @override
  void initState() {
    super.initState();
    categoryRepository = Provider.of(context,listen: false);
    onLoad = (){
      data = null;
      categoryRepository.getUser().then((value){
        setState(() {
          data = value;
        });
      });
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    categoryRepository.getUser().then((value){
      setState(() {
        data = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return data != null ? Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Column(
          children: <Widget>[
            SizedBox(height: 12),
            HeaderUserWidget(),
            Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => RowUserWidget(data[index], index, onLoad, widget.onchangePage),
                  itemCount: data?.length ?? 0,
                  separatorBuilder: (context, index) => Container( color: Colors.transparent, child: const Divider( ), ),

                )
            )
          ],
        ),
      ],
    ) : Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }
}