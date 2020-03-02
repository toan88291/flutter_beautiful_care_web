import 'package:flutter_beautiful_care_web/data/models/category.dart';
import 'firebase_data_source.dart';

class PatientRepository {
  static const TAG = 'PatientRepository';

  List<Category> categoryData = [];

  FireBaseDataSource fireBaseDataSource;

  PatientRepository(this.fireBaseDataSource);

  Future<List<Category>> getList() async{
    categoryData = await fireBaseDataSource.getList();
    return categoryData;
  }

//  Future<List<Patient>> getListPatient(){
//    return fireBaseDataSource.getListPatient();
//  }
//
//  Future<MedicalExamination> getMedical(String docId){
//    return fireBaseDataSource.getMedical(docId);
//  }
//
//  Future<Patient> getPatient(String docId){
//    return fireBaseDataSource.getPatient(docId);
//  }
//
//  Future<MedicalExamination> insert(MedicalExamination data){
//    return fireBaseDataSource.insert(data);
//  }
//
//  Future<bool> insertPatient(String code, Patient data){
//    return fireBaseDataSource.insertPatient(code, data);
//  }
//
//  Future<bool> checkCode (String code){
//    return fireBaseDataSource.checkCode(code);
//  }
//
  Future<bool> login(String user, String pass) {
    return fireBaseDataSource.login(user, pass);
  }
//
//  Future<bool> deleteMedical(String docId) {
//    return fireBaseDataSource.deleteMedical(docId);
//  }
//
//  Future<bool> deletePatient(String docId) {
//    return fireBaseDataSource.deletePatient(docId);
//  }
//
//  Future<bool> checkPatient(String patient) {
//    return fireBaseDataSource.checkPatient(patient);
//  }
//
//  Future<bool> update(String docId, Map<String, dynamic> data) {
//    return fireBaseDataSource.update(docId, data);
//  }
//
//  Future<bool> updatePatient(String docId, Map<String, dynamic> data) {
//    return fireBaseDataSource.updatePatient(docId, data);
//  }
}