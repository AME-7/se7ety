import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/core/constants/user_type_enum.dart';
import 'package:se7ety/core/services/firebase/failure/failure.dart';
import 'package:se7ety/core/services/local/shared_pref.dart';
import 'package:se7ety/features/auth/data/model/auth_params.dart';
import 'package:se7ety/features/auth/data/model/doctor_model.dart';
import 'package:se7ety/features/auth/data/repo/auth_repo.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final bioController = TextEditingController();
  final phone1Controller = TextEditingController();
  final phone2Controller = TextEditingController();
  final openHourController = TextEditingController();
  final closeHourController = TextEditingController();
  final addressController = TextEditingController();

  String? specialization;
  File? imageFile;

  final formKey = GlobalKey<FormState>();
  Future<void> login() async {
    emit(AuthLoadingState());
    var data = await AuthRepo.login(
      AuthParams(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
    data.fold(
      (failure) {
        emit(AuthErrorState(error: failure.massage));
      },
      (r) {
        emit(AuthSuccessState(userType: r));
      },
    );
  }

  AuthCubit() : super(AuthInitialState());
  void register(UserTypeEnum userType) async {
    emit(AuthLoadingState());
    var params = AuthParams(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
    );
    Either<Failure, Unit> data;
    if (userType == UserTypeEnum.doctor) {
      data = await AuthRepo.registerDoctor(params);
    } else {
      data = await AuthRepo.registerPatient(params);
    }
    data.fold(
      (failure) {
        emit(AuthErrorState(error: failure.massage));
      },
      (r) {
        emit(AuthSuccessState());
      },
    );
  }

  Future<void> updateDoctor() async {
    emit(AuthLoadingState());
    var doctor = DoctorModel(
      bio: bioController.text,
      phone1: phone1Controller.text,
      phone2: phone2Controller.text,
      openHour: openHourController.text,
      closeHour: closeHourController.text,
      address: addressController.text,
      specialization: specialization,
      uid: SharedPref.getUserId(),
      image: imageFile,
    );
    var data = await AuthRepo.updateDoctorProfile(doctor);
    data.fold(
      (failure) {
        emit(AuthErrorState(error: failure.massage));
      },
      (r) {
        emit(AuthSuccessState());
      },
    );
  }
}
