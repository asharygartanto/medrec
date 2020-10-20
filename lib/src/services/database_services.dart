import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices{
  static CollectionReference userProfileCollection = Firestore.instance.collection("userProfile");
  static CollectionReference userRecordsCollection = Firestore.instance.collection("userRecords");

  static Future<void> createOrUpdateUserProfile(String id,{String fullname, String address,String phone,}) async{
    await userProfileCollection.doc(id).set({
      "fullname":fullname,
      
      "address":address,
      "phone":phone
    });
  }

  static Future<DocumentSnapshot> getUserProfile(String id) async {
    return await userProfileCollection.doc(id).get();
  }

  static Future<QuerySnapshot> getLastVisitDoctor(String userid) async {
    return await userRecordsCollection.where("userid",isEqualTo: userid).orderBy("time1",descending: true).limit(1).get();
  }

  static Future<QuerySnapshot> getSickRecord(String recordid) async {
    return await userRecordsCollection.where("recordid",isEqualTo: recordid).get();
  }

  static Future<QuerySnapshot> getUserDataRecord(String userid) async {
    return await userRecordsCollection.where("userid",isEqualTo: userid).orderBy("time1",descending: true).limit(25).get();
  }

  static Future<void> createOrUpdateUserDataRecord(String userid,{String inoroutpatient, String anamnesis, String physicalExamination,String diagnosis,
  String medicalTreatment, String medicine,String docter,
  String hospital, DateTime time1}) async{
    await userRecordsCollection.doc().set({
      "userid":userid,
      "recordid":userProfileCollection.doc(userid).id+DateTime.now().year.toString()+DateTime.now().month.toString()+DateTime.now().day.toString()+DateTime.now().hour.toString(),
      "inoroutpatient":inoroutpatient,
      "anamnesis":anamnesis,
      "physicalExamination":physicalExamination,
      "diagnosis":diagnosis,
      "medicalTreatment":medicalTreatment,
      "medicine":medicine,
      "docter":docter,
      "hospital":hospital,
      "time1":time1,
      
    });
  }
}