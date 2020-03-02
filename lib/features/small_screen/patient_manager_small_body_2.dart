//
//import 'package:flutter/material.dart';
//import 'package:flutter_beautiful_care_web/data/models/patient.dart';
//import 'package:flutter_beautiful_care_web/data/patient_repository.dart';
//import 'package:flutter_beautiful_care_web/features/small_screen/row_patient_small_widget.dart';
//import 'package:provider/provider.dart';
//
//import '../dialog_input_patient_examination.dart';
//import 'header_patient_small_widget.dart';
//
//class PatientManagerSmallBody2 extends StatefulWidget {
//  @override
//  _PatientManagerSmallBody2State createState() => _PatientManagerSmallBody2State();
//}
//
//class _PatientManagerSmallBody2State extends State<PatientManagerSmallBody2> {
//
//  VoidCallback onLoad;
//
//  PatientRepository patientRepository;
//
//  List<Patient> data;
//
//  @override
//  void initState() {
//    super.initState();
//    patientRepository = Provider.of(context, listen: false);
//    onLoad = () {
//      patientRepository.getListPatient().then((value){
//        setState(() {
//          data = value;
//        });
//      });
//    };
//  }
//  @override
//  void didChangeDependencies() {
//    super.didChangeDependencies();
//    patientRepository.getListPatient().then((value){
//      setState(() {
//        data = value;
//      });
//    });
//  }
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: Stack(
//        children: <Widget>[
//          Column(
//            children: <Widget>[
//              HeaderPatientSmallWidget(),
//              Expanded(
//                  child: ListView.separated(
//                    physics: BouncingScrollPhysics(),
//                    itemBuilder: (context, index) => RowPatientSmallWidget(data[index], onLoad),
//                    itemCount: data?.length ?? 0,
//                    separatorBuilder: (context, index) => Container( color: Colors.transparent, child: const Divider( ), ),
//
//                  )
//              )
//
//            ],
//          ),
//          Positioned(
//            bottom: 4,
//            right: 4,
//            child: FloatingActionButton(
//              onPressed: (){
//                _showInput().then((value) => {});
//              },
//              child: Icon(Icons.add),
//            ),
//          )
//        ],
//      ),
//    );
//  }
//
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