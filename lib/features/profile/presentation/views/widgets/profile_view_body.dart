import 'package:flutter/material.dart';
import 'package:rfaye3/core/utils/app_colors.dart';
import 'package:rfaye3/core/utils/app_images.dart';
import 'package:rfaye3/core/utils/app_text_styles.dart';
import 'package:rfaye3/core/utils/constant.dart';
import 'package:rfaye3/core/widgets/space.dart';
import 'package:rfaye3/features/main/presentation/views/widgets/most_selling/app_bar_with_notification.dart';
import 'package:rfaye3/features/profile/presentation/views/widgets/setting_item.dart';
import 'package:rfaye3/generated/l10n.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        AppBarWithNotification(
          title: S.of(context).profile,
          hasBack: false,
          hasNoti: false,
        ),
        SliverToBoxAdapter(
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: kHoripadding,
            ),
            title: Text(
              "يوسف دويدار",
              style: TextStyles.bold16.copyWith(
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
            subtitle: Text(
              "mail@gmail.com",
              style: TextStyles.regular16.copyWith(
                color: const Color(0xff949D9E),
              ),
            ),

            leading: Image.asset(Assets.imagesProfileImage, height: 120),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 10)),
        SliverList(
          delegate: SliverChildListDelegate.fixed([
            SettingItem(title: S.of(context).set1, icon: Assets.imagesSet1),
            SettingItem(title: S.of(context).set2, icon: Assets.imagesSet2),
            SettingItem(title: S.of(context).set3, icon: Assets.imagesSet3),
            SettingItem(title: S.of(context).set4, icon: Assets.imagesSet4),
            SettingItem(
              title: S.of(context).set5,
              icon: Assets.imagesSet5,
              hasSwitch: true,
            ),
            SettingItem(title: S.of(context).set6, icon: Assets.imagesSet6),
            SettingItem(
              title: S.of(context).set7,
              icon: Assets.imagesSet7,
              hasSwitch: true,
            ),
          ]),
        ),
        const SliverToBoxAdapter(child: SpaceV(70)),

        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(8),
            width: double.infinity,
            color: AppColors.lightPrimaryColor.withValues(alpha: 0.15),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(S.of(context).signOut, style: TextStyles.regular16),
                const SpaceH(20),
                Transform.rotate(
                  angle: 180 * 3.14 / 180,
                  child: const Icon(
                    Icons.logout_rounded,
                    color: AppColors.lightPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
