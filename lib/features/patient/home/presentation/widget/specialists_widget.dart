import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/utils/styles/app_text_styles.dart';
import 'package:se7ety/core/utils/styles/colors.dart';
import 'package:se7ety/core/widget/custom_svg_picture.dart';
import 'package:se7ety/features/patient/home/data/card.dart';

class SpecialistsBanner extends StatelessWidget {
  const SpecialistsBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("التخصصات", style: AppTextStyles.title18.copyWith(fontSize: 16)),
        SizedBox(
          height: 230,
          width: double.infinity,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: cards.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // pushTo(
                  //   context,
                  //   Routes.specializationSearch,
                  //   extra: cards[index].specialization,
                  // );
                },
                child: ItemCardWidget(model: cards[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ItemCardWidget extends StatelessWidget {
  const ItemCardWidget({super.key, required this.model});
  final CardModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 150,
      margin: const EdgeInsets.only(left: 15, bottom: 15, top: 10),
      decoration: BoxDecoration(
        color: model.cardBackground,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            offset: const Offset(4, 4),
            blurRadius: 10,
            color: model.cardLightColor.withValues(alpha: .8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: -20,
              right: -20,
              child: CircleAvatar(
                backgroundColor: model.cardLightColor,
                radius: 60,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomSvgPicture(path: AppImages.doctorCardSvg, width: 140),
                const Gap(10),
                Text(
                  model.specialization,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.title18.copyWith(
                    color: AppColors.whiteColor,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
