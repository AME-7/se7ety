import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/services/firebase/firestore_provider.dart';
import 'package:se7ety/core/utils/styles/app_text_styles.dart';
import 'package:se7ety/core/utils/styles/colors.dart';
import 'package:se7ety/features/patient/home/presentation/widget/specialists_widget.dart';
import 'package:se7ety/features/patient/home/presentation/widget/top_rated_widget.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({super.key, required this.onSearch});
  final Function() onSearch;

  @override
  State<PatientHomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<PatientHomeScreen> {
  final TextEditingController _doctorName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseProvider.currentUser;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: IconButton(
              splashRadius: 20,
              icon: const Icon(
                Icons.notifications_active,
                color: AppColors.darkColor,
              ),
              onPressed: () {},
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'صــــــحّـتــي',
          style: AppTextStyles.title18.copyWith(color: AppColors.darkColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'مرحبا، ', style: AppTextStyles.body16),
                    TextSpan(
                      text: currentUser?.displayName,
                      style: AppTextStyles.title18.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(20),
              Text(
                "احجز الآن وكن جزءًا من رحلتك الصحية.",
                style: AppTextStyles.title18.copyWith(
                  color: AppColors.darkColor,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 20),

              _searchBar(context),
              const SizedBox(height: 20),
              const SpecialistsBanner(),
              const SizedBox(height: 10),
              Text(
                "الأعلي تقييماً",
                textAlign: TextAlign.center,
                style: AppTextStyles.title18.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const TopRatedList(),
            ],
          ),
        ),
      ),
    );
  }

  Container _searchBar(BuildContext context) {
    return Container(
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
      child: TextFormField(
        readOnly: true,
        onTap: widget.onSearch,
        textInputAction: TextInputAction.search,
        controller: _doctorName,
        cursorColor: AppColors.primaryColor,
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
        decoration: InputDecoration(
          hintStyle: AppTextStyles.body16,
          filled: true,
          hintText: 'ابحث عن دكتور',
          suffixIcon: Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: .9),
              borderRadius: BorderRadius.circular(17),
            ),
            child: IconButton(
              iconSize: 20,
              splashRadius: 20,
              color: Colors.white,
              icon: const Icon(Icons.search),
              onPressed: widget.onSearch,
            ),
          ),
        ),
        style: AppTextStyles.body16,
        onFieldSubmitted: (String value) {
          if (_doctorName.text.isNotEmpty) {
            // pushTo(
            //   context,
            //   Routes.homeSearch,
            //   extra: _doctorName.text,
            // );
          }
        },
      ),
    );
  }
}
