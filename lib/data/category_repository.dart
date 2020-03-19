import 'package:flutter_beautiful_care_web/data/models/category.dart';
import 'package:flutter_beautiful_care_web/data/models/post.dart';
import 'firebase_data_source.dart';
import 'models/sub_category.dart';

class CategoryRepository {
  static const TAG = 'PatientRepository';

  List<Category> categoryData = [];

  List<SubCategory> categorySubData = [];

  List<Post> postData = [];

  Post postDataId;

  FireBaseDataSource fireBaseDataSource;

  CategoryRepository(this.fireBaseDataSource);

  Future<List<Category>> getList() async{
    categoryData = await fireBaseDataSource.getList();
    return categoryData;
  }

  Future<List<SubCategory>> getListSubCategory(String id) async{
    categorySubData = await fireBaseDataSource.getListSubCategory(id);
    return categorySubData;
  }

  Future<List<Post>> getPost(String id) async{
    postData = await fireBaseDataSource.getPost(id);
    return postData;
  }

  Future<Post> getPostId(String id) async{
    postDataId = await fireBaseDataSource.getPostId(id);
    return postDataId;
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
  Future<bool> insertSubCateGory(String code, Map<String, dynamic> data){
    return fireBaseDataSource.insertSubCateGory(code, data);
  }
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
  Future<bool> update(String docId, Map<String, dynamic> data) {
    return fireBaseDataSource.update(docId, data);
  }

  Future<bool> updatePost(String docId, Map<String, dynamic> data) {
    return fireBaseDataSource.updatePost(docId, data);
  }

  Future<bool> updateSubCateGory(String id, String docId, Map<String, dynamic> data) {
    return fireBaseDataSource.updateSubCateGory(id,docId, data);
  }
//
//  Future<bool> updatePatient(String docId, Map<String, dynamic> data) {
//    return fireBaseDataSource.updatePatient(docId, data);
//  }
}