import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_beautiful_care_web/data/models/category.dart';

class FireBaseDataSource {
  static const TAG = 'FirebaseDataSource';
  Firestore _firestore;
  FireBaseDataSource(this._firestore);

  Future<List<Category>> getList() async {
    QuerySnapshot querySnapshot = await _firestore.collection('/category').orderBy("name", descending: true).getDocuments();
    List<Category> results = querySnapshot.documents.map((data) => Category.fromJson(data.data)..docId = data.documentID).toList();
    return results;
  }

//  Future<List<Patient>> getListPatient() async {
//    QuerySnapshot querySnapshot = await _firestore.collection('/patient').getDocuments();
//    debugPrint('getList querySnapshot: ${querySnapshot.documents?.length}');
//    List<Patient> results = querySnapshot.documents.map((data) => Patient.fromJson(data.data)..docId = data.documentID).toList();
//
//    return results;
//  }
//
//  Future<MedicalExamination> getMedical(String docId) async {
//    MedicalExamination medicalExamination;
//    Map<String, dynamic> map;
//    DocumentReference documentReference = _firestore.collection('/medical_examination')
//        .document(docId);
//    DocumentSnapshot documentSnapshot = await documentReference.get();
//    map = documentSnapshot.data;
//    medicalExamination = MedicalExamination.fromJson(map)..docId = documentSnapshot.documentID;
//    return medicalExamination;
//  }
//
//  Future<Patient> getPatient(String docId) async {
//    Patient patient;
//    Map<String, dynamic> map;
//    DocumentReference documentReference = _firestore.collection('/patient')
//        .document(docId);
//    DocumentSnapshot documentSnapshot = await documentReference.get();
//    map = documentSnapshot.data;
//    patient = Patient.fromJson(map)..docId = documentSnapshot.documentID;
//    return patient;
//  }
//
//  Future<MedicalExamination> insert(MedicalExamination data) async {
//    DocumentReference documentReference = await _firestore.collection('/medical_examination').add(data.toJson());
//    return data;
//  }
//
//  Future<bool> insertPatient(String code, Patient data) async {
//    await _firestore.collection('/patient').document(code).setData(data.toJson());
//    return _firestore.collection('/patient').document(code).setData(data.toJson()) != null;
//  }
//
//  Future<bool> checkCode(String code) async{
//    DocumentReference docReference = _firestore.collection('/medical_examination').document(code);
//    DocumentSnapshot docSnapshot = await docReference.get();
//    return docSnapshot.exists;
//  }
//
  Future<bool> login(String user, String pass) async {
    QuerySnapshot querySnapshot = await _firestore.collection('/user')
        .where("username", isEqualTo: user.toLowerCase())
        .where("password", isEqualTo: pass)
        .where("role", isEqualTo: true)
        .getDocuments();
    return querySnapshot.documents.length > 0 ;
  }
//
//  Future<bool> checkPatient(String patient) async {
//    DocumentReference documentReference = Firestore.instance
//        .collection('patient').document(patient);
//    DocumentSnapshot documentSnapshot = await documentReference.get();
//    return documentSnapshot.exists;
//  }
//
//  Future<bool> deleteMedical(String docId) async {
//    return Firestore.instance.collection('medical_examination')
//        .document(docId).delete() != null;
//  }
//
//  Future<bool> deletePatient(String docId) async {
//    await Firestore.instance.collection('patient')
//        .document(docId).delete();
//    return Firestore.instance.collection('patient')
//        .document(docId).delete() != null;
//  }
//
//  Future<bool> update(String docId, Map<String, dynamic> data) async {
//    DocumentReference documentReference = Firestore.instance
//        .collection('medical_examination').document(docId);
//    await documentReference.updateData(data);
//    return documentReference.updateData(data) != null;
//  }
//
//  Future<bool> updatePatient(String docId, Map<String, dynamic> data) async {
//    DocumentReference documentReference = Firestore.instance
//        .collection('patient').document(docId);
//    await documentReference.updateData(data);
//    return documentReference.updateData(data) != null;
//  }
}