import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:se7ety/features/auth/data/model/doctor_model.dart';
import 'package:se7ety/features/auth/data/model/patient_model.dart';

class FirebaseProvider {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final patientCollection = _firestore.collection("patient");
  static final doctorCollection = _firestore.collection("doctor");

  static User? get currentUser => _auth.currentUser;

  static Future<void> addPatient(PatientModel patient) async {
    await patientCollection.doc(patient.uid).set(patient.toJson());
  }

  static Future<void> addDoctor(DoctorModel doctor) async {
    await doctorCollection.doc(doctor.uid).set(doctor.toJson());
  }

  static Future<void> updateDoctor(DoctorModel doctor) async {
    await doctorCollection.doc(doctor.uid).update(doctor.toUpdateData());
  }

  static Future<QuerySnapshot> getDoctors() async {
    return await doctorCollection.get();
  }

  static Future<QuerySnapshot> sortingDoctors() {
    return doctorCollection
        .where("specialization", isNull: false)
        .orderBy("rating", descending: true)
        .get();
  }

  static Future<QuerySnapshot> getDoctorsBySpecialization(
    String specialization,
  ) async {
    return await doctorCollection
        .where("specialization", isEqualTo: specialization)
        .get();
  }

  static Future<QuerySnapshot?> searchForDoctorsByName(String name) async {
    try {
      var result = await doctorCollection
          .where("specialization", isNull: false)
          .orderBy("name")
          .startAt([name.toLowerCase()])
          .endAt(["${name.toLowerCase()}\uf8ff"])
          .get();
      return result;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }
}
