
import 'package:flutter/material.dart';
import 'package:flutter_beautiful_care_web/data/patient_repository.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as developer;

class PatientManagerBody extends StatefulWidget {
  @override
  _PatientManagerBodyState createState() => _PatientManagerBodyState();
}

class _PatientManagerBodyState extends State<PatientManagerBody> {
  static const TAG = 'PatientManagerBody';

  List data;

  VoidCallback onLoad;

  PatientRepository patientRepository;

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    patientRepository = Provider.of<PatientRepository>(context, listen: false);
    _scrollController = ScrollController();
    onLoad = () {
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
    print('didChangeDependencies');
    developer.log('didChangeDependencies', name: TAG);
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
//        Column(
//          children: <Widget>[
//            HeaderPatientWidget(),
//            Expanded(
//                child: ListView.separated(
//                  controller: _scrollController,
//                  shrinkWrap: true,
//                  scrollDirection: Axis.vertical,
//                  physics: BouncingScrollPhysics(),
//                  itemBuilder: (context, index) => RowPatientWidget(data[index], onLoad),
//                  itemCount: data?.length ?? 0,
//                  separatorBuilder: (context, index) => Container( color: Colors.transparent, child: const Divider( ), ),
//
//                )
//            )
//          ],
//        ),
        Positioned(
          bottom: 0,
          right: -12,
          child: FloatingActionButton(
            onPressed: (){
              _showInput().then((value) => {});
            },
            child: Icon(Icons.add),
          ),
        )
      ],
    ) : Container();
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


