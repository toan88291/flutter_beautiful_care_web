import 'package:flutter/material.dart';
import 'package:flutter_beautiful_care_web/data/models/category.dart';
import 'package:flutter_beautiful_care_web/data/patient_repository.dart';
import 'package:provider/provider.dart';

import 'header_category_widget.dart';
import 'row_category_widget.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  List<Category> data;

  VoidCallback onLoad;

  PatientRepository patientRepository;

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    patientRepository = Provider.of(context,listen: false);
    _scrollController = ScrollController();
    onLoad = (){
      data = null;
      patientRepository.getList().then((value){
        setState(() {
          data = value;
        });
      });
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    patientRepository.getList().then((value){
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
            HeaderCategoryWidget(),
            Expanded(
                child: ListView.separated(
                  controller: _scrollController,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => RowCategoryWidget(data[index], index, onLoad),
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

  Future<void> _showInput() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Container(),
        );
      },
    );
  }
}