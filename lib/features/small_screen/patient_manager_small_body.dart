//
//import 'package:flutter/material.dart';
//import 'package:flutter_beautiful_care_web/data/models/medical_examination.dart';
//import 'package:flutter_beautiful_care_web/data/patient_repository.dart';
//import 'package:provider/provider.dart';
//import 'dart:developer' as developer;
//
//import '../dialog_input_medical_examination.dart';
//import 'header_patient_small_widget.dart';
//import 'row_medical_small_widget.dart';
//
//class PatientMedicalSmallBody extends StatefulWidget {
//  @override
//  _PatientMedicalSmallBodyState createState() => _PatientMedicalSmallBodyState();
//}
//
//class _PatientMedicalSmallBodyState extends State<PatientMedicalSmallBody> {
//  static const TAG = 'PatientManagerBody';
//
//  VoidCallback onLoad;
//
//  List<MedicalExamination> data;
//
//  PatientRepository patientRepository;
//
//  @override
//  void initState() {
//    super.initState();
//    patientRepository = Provider.of(context, listen: false);
//    onLoad = () {
//      patientRepository.getList().then((value){
//        setState(() {
//          data = value;
//        });
//      });
//    };
//  }
//
//  @override
//  void didChangeDependencies() {
//    super.didChangeDependencies();
//    print('didChangeDependencies');
//    developer.log('didChangeDependencies', name: TAG);
//    Provider.of<PatientRepository>(context).getList().then((value){
//      setState(() {
//        data = value;
//      });
//
//    });
//  }
//  @override
//  Widget build(BuildContext context) {
//    return Stack(
//      children: <Widget>[
//        Column(
//          children: <Widget>[
//            HeaderPatientSmallWidget(),
//            Expanded(
//                child: ListView.separated(
//                  physics: BouncingScrollPhysics(),
//                  itemBuilder: (context, index) => RowMedicalSmallWidget(data[index], onLoad),
//                  itemCount: data?.length ?? 0,
//                  separatorBuilder: (context, index) => Container( color: Colors.transparent, child: const Divider( ), ),
//
//                )
//            )
//          ],
//        ),
//        Positioned(
//          bottom: 4,
//          right: 4,
//          child: FloatingActionButton(
//            onPressed: (){
//              _showInput().then((value) => {});
//            },
//            child: Icon(Icons.add),
//          ),
//        )
//      ],
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
//          child: DialogInputMedicalExamination(onLoad),
//        );
//      },
//    );
//  }
//
//}
//
