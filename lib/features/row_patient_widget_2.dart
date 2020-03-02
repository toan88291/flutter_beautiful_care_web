//
//import 'package:flutter/material.dart';
//import 'package:flutter_beautiful_care_web/data/models/patient.dart';
//import 'package:flutter_beautiful_care_web/data/patient_repository.dart';
//import 'package:flutter_beautiful_care_web/widget/show_dialog_loading.dart';
//import 'package:intl/intl.dart';
//import 'package:provider/provider.dart';
//
//import 'dialog_update_patient_examination.dart';
//
//class RowPatientWidget2 extends StatefulWidget {
//
//  final Patient data;
//
//  final VoidCallback onLoad;
//
//  RowPatientWidget2(this.data, this.onLoad);
//
//  @override
//  _RowPatientWidget2State createState() => _RowPatientWidget2State();
//}
//
//class _RowPatientWidget2State extends State<RowPatientWidget2> {
//  PatientRepository patientRepository;
//
//  Future<bool> deleteLoad(String docId) async {
//    await patientRepository.deletePatient(docId);
//  }
//
//  void deleteRow(String docId) {
//    showDialogProgressLoading<bool>(context, deleteLoad(docId)).then((value){
//      Navigator.of(context).pop();
//      widget.onLoad();
//    });
//  }
//
//  @override
//  void initState() {
//    super.initState();
//    patientRepository = Provider.of(context, listen: false);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      padding: EdgeInsets.all(16),
//      child: Row(
//        children: <Widget>[
//          _itemRow(widget.data.name),
//          _itemRow(widget.data.docId),
//          _itemRow(widget.data.address),
//          _itemRow(widget.data.email),
//          _itemRow(widget.data.gender == 0 ? "Nam" : "Nữ"),
//          _itemRow(widget.data.phone),
//          _itemRow(widget.data.refer),
//          Expanded(child: Container(
//            padding: EdgeInsets.all(8),
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: <Widget>[
//                InkWell(
//                  onTap: (){
//                    _showUpdate();
//                  },
//                  child: Text(
//                    'Sửa',
//                    style: TextStyle(color: Colors.yellow),
//                  ),
//                ),
//                InkWell(
//                  onTap: (){
//                    _showDelete();
//                  },
//                  child: Container(
//                    padding: EdgeInsets.all(12),
//                    child: Text(
//                      'Xoá',
//                      style: TextStyle(color: Colors.red),
//                    ),
//                  ),
//                )
//              ],
//            ),
//          ),),
//        ],
//      ),
//    );
//  }
//
//  Widget _itemRow(String model) {
//    return Expanded(child: Container(
//      alignment: Alignment.center,
//      padding: EdgeInsets.all(8),
//      child: Text(model, textAlign: TextAlign.center,),
//    ),);
//  }
//
//  Future<void> _showUpdate() async {
//    return showDialog<void>(
//      context: context,
//      barrierDismissible: false, // user must tap button!
//      builder: (BuildContext context) {
//        return Dialog(
//          shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.all(Radius.circular(16)),
//          ),
//          child: DialogUpdatePatientExamination(widget.data.docId, widget.onLoad),
//        );
//      },
//    );
//  }
//
//  Future<bool> _showDelete() async {
//    return showDialog<bool>(
//      context: context,
//      barrierDismissible: false, // user must tap button!
//      builder: (BuildContext context) {
//        return Dialog(
//          shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.all(Radius.circular(16)),
//          ),
//          child: Container(
//            height: 200,
//            width: 200,
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.center,
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: <Widget>[
//                Text('Bạn có chắc muốn xoá',style: TextStyle(color: Colors.red),),
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                  children: <Widget>[
//                    _buttonClick(
//                        'Không',
//                        Colors.redAccent, (){
//                          Navigator.of(context).pop();
//                        }
//                    ),
//                    _buttonClick(
//                        'Có',
//                        Colors.blue, (){
//                          deleteRow(widget.data.docId);
//                        }
//                    )
//                  ],
//                )
//              ],
//            ),
//          ),
//        );
//      },
//    );
//  }
//
//  Widget _buttonClick(String title,Color color, onclick) {
//    return InkWell(
//      onTap: onclick,
//      child: ClipRRect(
//        borderRadius: BorderRadius.all(Radius.circular(12)),
//        child: Container(
//          alignment: Alignment.center,
//          width: 80,
//          height: 40,
//          decoration: BoxDecoration(
//            color: color,
//          ),
//          child: Text(title,style: TextStyle(color: Colors.white),),
//        ),
//      ),
//    );
//  }
//}