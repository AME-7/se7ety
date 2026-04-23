import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:se7ety/core/constants/user_type_enum.dart';
import 'package:se7ety/core/functions/image_uploader.dart';
import 'package:se7ety/core/services/firebase/failure/failure.dart';
import 'package:se7ety/core/services/firebase/firestore_provider.dart';
import 'package:se7ety/core/services/local/shared_pref.dart';
import 'package:se7ety/features/auth/data/model/auth_params.dart';
import 'package:se7ety/features/auth/data/model/doctor_model.dart';
import 'package:se7ety/features/auth/data/model/patient_model.dart';

class AuthRepo {
  static Future<Either<Failure, UserTypeEnum>> login(AuthParams params) async {
    try {
      final UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: params.email,
            password: params.password,
          );
      User? user = credential.user;
      await SharedPref.cacheUserId(user?.uid ?? '');

      if (UserTypeEnum.fromString(user?.photoURL ?? '') ==
          UserTypeEnum.doctor) {
        return right(UserTypeEnum.doctor);
      } else {
        return right(UserTypeEnum.patient);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return left(Failure(massage: 'كلمة المرور ضعيفة'));
      } else if (e.code == 'email-already-in-use') {
        return left(Failure(massage: 'الحساب موجود بالفعل'));
      } else {
        return left(Failure(massage: 'حدث خطأ'));
      }
    } catch (e) {
      return left(Failure(massage: 'حدث خطأ'));
    }
  }

  static Future<Either<Failure, Unit>> registerDoctor(AuthParams params) async {
    try {
      final UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: params.email,
            password: params.password,
          );

      // uid, email , name
      User? user = credential.user;
      await user?.updateDisplayName(params.name);
      await user?.updatePhotoURL(UserTypeEnum.doctor.value);
      await SharedPref.cacheUserId(user?.uid ?? '');
      // Add User to Firestore

      var doctorData = DoctorModel(
        name: params.name,
        email: params.email,
        uid: user?.uid,
      );

      await FirebaseProvider.addDoctor(doctorData);

      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return left(Failure(massage: 'كلمة المرور ضعيفة'));
      } else if (e.code == 'email-already-in-use') {
        return left(Failure(massage: 'الحساب موجود بالفعل'));
      } else {
        return left(Failure(massage: 'حدث خطأ'));
      }
    } catch (e) {
      return left(Failure(massage: 'حدث خطأ'));
    }
  }

  static Future<Either<Failure, Unit>> registerPatient(
    AuthParams params,
  ) async {
    try {
      // 1) Create User (Auth)
      final UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: params.email,
            password: params.password,
          );
      // 2) Update User Name (Auth)
      User? user = credential.user;
      await user?.updateDisplayName(params.name);
      await user?.updatePhotoURL(UserTypeEnum.patient.value);
      await SharedPref.cacheUserId(user?.uid ?? '');

      // 4) Add User to Firestore
      var patientData = PatientModel(
        name: params.name,
        email: params.email,
        uid: credential.user?.uid,
      );

      // use user id as document id => to make it easy to get user data
      await FirebaseProvider.addPatient(patientData);

      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return left(Failure(massage: 'كلمة المرور ضعيفة'));
      } else if (e.code == 'email-already-in-use') {
        return left(Failure(massage: 'الحساب موجود بالفعل'));
      } else {
        return left(Failure(massage: 'حدث خطأ'));
      }
    } catch (e) {
      return left(Failure(massage: 'حدث خطأ'));
    }
  }

  static Future<Either<Failure, Unit>> updateDoctorProfile(
    DoctorModel doctor,
  ) async {
    try {
      doctor.imageUrl = await uploadImageToCloudinary(doctor.image!) ?? '';
      await FirebaseProvider.updateDoctor(doctor);
      return right(unit);
    } catch (e) {
      return left(Failure(massage: 'حدث خطأ'));
    }
  }
}
