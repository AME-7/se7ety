import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:se7ety/features/auth/data/model/doctor_model.dart';
import 'package:se7ety/features/auth/data/model/patient_model.dart';

class FirestoreProvider {
  static final patientCollection = FirebaseFirestore.instance.collection(
    "patient",
  );
  static final doctorCollection = FirebaseFirestore.instance.collection(
    "doctor",
  );

  static Future<void> addPatient(PatientModel patient) async {
    await patientCollection.doc(patient.uid).set(patient.toJson());
  }

  static Future<void> addDoctor(DoctorModel doctor) async {
    await doctorCollection.doc(doctor.uid).set(doctor.toJson());
  }

  static Future<void> updateDoctor(DoctorModel doctor) async {
    await doctorCollection.doc(doctor.uid).update(doctor.toUpdateData());
  }
}
