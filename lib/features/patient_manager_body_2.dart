//
//import 'package:flutter/material.dart';
//import 'package:flutter_beautiful_care_web/data/models/patient.dart';
//import 'package:flutter_beautiful_care_web/data/patient_repository.dart';
//import 'package:provider/provider.dart';
//
//import 'dialog_input_patient_examination.dart';
//import 'header_patient_widget_2.dart';
//import 'row_patient_widget_2.dart';
//
//class PatientManagerBody2 extends StatefulWidget {
//
//  @override
//  _PatientManagerBody2State createState() => _PatientManagerBody2State();
//}
//
//class _PatientManagerBody2State extends State<PatientManagerBody2> {
//
//  List<Patient> data;
//
//  VoidCallback onLoad;
//
//  PatientRepository patientRepository;
//
//  ScrollController _scrollController;
//
//
//  @override
//  void initState() {
//    super.initState();
//    patientRepository =Provider.of(context,listen: false);
//    _scrollController = ScrollController();
//    onLoad = (){
//      debugPrint('PatientManagerBody2');
//      data = null;
//      patientRepository.getListPatient().then((value){
//        setState(() {
//          data = value;
//          debugPrint('PatientManagerBody2');
//        });
//      });
//    };
//  }
//
//  @override
//  void didChangeDependencies() {
//    super.didChangeDependencies();
//    patientRepository.getListPatient().then((value){
//      setState(() {
//        data = value;
//      });
//
//    });
//  }
//  @override
//  Widget build(BuildContext context) {
//    return data != null ? Stack(
//      overflow: Overflow.visible,
//      children: <Widget>[
//        Column(
//          children: <Widget>[
//            HeaderPatientWidget2(),
//            Expanded(
//                child: ListView.separated(
//                  controller: _scrollController,
//                  shrinkWrap: true,
//                  scrollDirection: Axis.vertical,
//                  physics: BouncingScrollPhysics(),
//                  itemBuilder: (context, index) => RowPatientWidget2(data[index], onLoad),
//                  itemCount: data?.length ?? 0,
//                  separatorBuilder: (context, index) => Container( color: Colors.transparent, child: const Divider( ), ),
//
//                )
//            )
//          ],
//        ),
//        Positioned(
//          bottom: 0,
//          right: -12,
//          child: FloatingActionButton(
//            onPressed: (){
//              _showInput().then((value) => {});
//            },
//            child: Icon(Icons.add),
//          ),
//        )
//      ],
//    ) : Container();
//  }
//  Future<void> _showInput() async {
//    return showDialog<void>(
//      context: context,
//      barrierDismissible: false, // user must tap button!
//      builder: (BuildContext context) {
//        return Dialog(
//          shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.all(Radius.circular(16)),
//          ),
//          child: DialogInputPatientExamination(onLoad),
//        );
//      },
//    );
//  }
//}