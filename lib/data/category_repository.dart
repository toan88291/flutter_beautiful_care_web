import 'package:flutter_beautiful_care_web/data/models/category.dart';
import 'package:flutter_beautiful_care_web/data/models/post.dart';
import 'package:flutter_beautiful_care_web/data/models/user.dart';
import 'firebase_data_source.dart';
import 'models/sub_category.dart';

class CategoryRepository {
  static const TAG = 'PatientRepository';

  List<Category> categoryData = [];

  List<SubCategory> categorySubData = [];

  List<Post> postData = [];

  List<User> userData = [];

  Post postDataId;

  FireBaseDataSource fireBaseDataSource;

  CategoryRepository(this.fireBaseDataSource);

  Future<List<Category>> getListCategory() async{
    categoryData = await fireBaseDataSource.getListCategory();
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

  Future<List<User>> getUser() async{
    userData = await fireBaseDataSource.getUser();
    return userData;
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

  Future<bool> insertPost(Post data){
    return fireBaseDataSource.insertPost(data);
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
  Future<bool> deleteSubCategory(String docId,String docIdSub) {
    return fireBaseDataSource.deleteSubCategory(docId,docIdSub);
  }
//
//  Future<bool> deletePatient(String docId) {
//    return fireBaseDataSource.deletePatient(docId);
//  }
//
//  Future<bool> checkPatient(String patient) {
//    return fireBaseDataSource.checkPatient(patient);
//  }
//
  Future<bool> update(String docId, Category data) {
    return fireBaseDataSource.update(docId, data);
  }

  Future<bool> updatePost(String docId, Post data) {
    return fireBaseDataSource.updatePost(docId, data);
  }

  Future<bool> updateSubCateGory(String id, String docId, Map<String, dynamic> data) {
    return fireBaseDataSource.updateSubCateGory(id,docId, data);
  }
//
//  Future<bool> updatePatient(String docId, Map<String, dynamic> data) {
//    return fireBaseDataSource.updatePatient(docId, data);
//  }

  Future<bool> deletePost(String id) async {
    return fireBaseDataSource.deletePost(id);
  }

  Future<bool> deleteUser(String id) async {
    return fireBaseDataSource.deleteUser(id);
  }

}