import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/services/firebase/firestore_provider.dart';
import 'package:se7ety/core/utils/styles/colors.dart';
import 'package:se7ety/core/widget/card/doctor_card.dart';
import 'package:se7ety/features/auth/data/model/doctor_model.dart';
import 'package:se7ety/features/patient/sreach/specilization_search/page/specialization_search_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ابحث عن دكتور')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              height: 55,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: .3),
                    blurRadius: 15,
                    offset: const Offset(5, 5),
                  ),
                ],
              ),
              child: TextField(
                onChanged: (searchKey) {
                  setState(() {
                    search = searchKey;
                  });
                },
                decoration: InputDecoration(
                  hintText: "البحث",
                  suffixIcon: const SizedBox(
                    width: 50,
                    child: Icon(Icons.search, color: AppColors.primaryColor),
                  ),
                ),
              ),
            ),
            const Gap(15),
            SearchList(search: search),
          ],
        ),
      ),
    );
  }
}

class SearchList extends StatelessWidget {
  const SearchList({super.key, required this.search});

  final String search;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: FirebaseProvider.searchForDoctorsByName(search),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot?> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              return snapshot.data!.docs.isEmpty
                  ? EmptyWidget()
                  : Scrollbar(
                      child: ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          DoctorModel doctor = DoctorModel.fromJson(
                            snapshot.data!.docs[index].data()
                                as Map<String, dynamic>,
                          );
                          return DoctorCard(doctor: doctor);
                        },
                      ),
                    );
            },
      ),
    );
  }
}
