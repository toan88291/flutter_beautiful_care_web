//
//import 'package:flutter/material.dart';
//import 'package:flutter_beautiful_care_web/data/models/medical_examination.dart';
//import 'package:flutter_beautiful_care_web/data/patient_repository.dart';
//import 'package:flutter_beautiful_care_web/widget/show_dialog_loading.dart';
//import 'package:intl/intl.dart';
//import 'package:provider/provider.dart';
//
//import 'dialog_update_medical_examination.dart';
//
//class RowPatientWidget extends StatefulWidget {
//
//  final MedicalExamination model;
//
//  final VoidCallback onLoad;
//
//  RowPatientWidget(this.model, this.onLoad);
//
//  @override
//  _RowPatientWidgetState createState() => _RowPatientWidgetState();
//}
//
//class _RowPatientWidgetState extends State<RowPatientWidget> {
//  PatientRepository patientRepository;
//
//  @override
//  void initState() {
//    super.initState();
//    patientRepository = Provider.of(context, listen: false);
//  }
//
//  Future<bool> deleteLoad(String docId) async {
//    await patientRepository.deleteMedical(docId);
//  }
//
//  void deleteRow(String docId) {
//    showDialogProgressLoading<bool>(context, deleteLoad(docId)).then((value){
//      widget.onLoad();
//      Navigator.of(context).pop();
//    });
//  }
//
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      padding: EdgeInsets.all(16),
//      child: Row(
//        children: <Widget>[
//          _itemRow(widget.model.idPatient),
//          _itemRow('${DateFormat.yMd().format(widget.model.time)}'),
//          _itemRow(widget.model.diagnostic),
//          _itemRow(widget.model.treatment),
//          _itemRow(widget.model.doctor),
//          _itemRow(widget.model.note_user.isEmpty ? "Trống" : widget.model.note_user),
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
//                    _showDelete().then((value) {
//
//                    });
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
//      alignment: Alignment.centerLeft,
//      padding: EdgeInsets.all(8),
//      child: Text(model,),
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
//          child: DialogUpdateMedicalExamination(widget.model.docId, widget.onLoad),
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
//                      'Không',
//                      Colors.redAccent,
//                      (){
//                        Navigator.of(context).pop();
//                      }
//                    ),
//                    _buttonClick(
//                      'Có',
//                      Colors.blue,
//                      (){
//                        deleteRow(widget.model.docId);
//                      }
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