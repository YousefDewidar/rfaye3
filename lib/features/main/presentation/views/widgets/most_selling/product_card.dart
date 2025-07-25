import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rfaye3/core/routes/routes.dart';

import 'package:rfaye3/core/utils/app_colors.dart';
import 'package:rfaye3/core/utils/app_text_styles.dart';
import 'package:rfaye3/core/widgets/in_app_notification.dart';
import 'package:rfaye3/core/widgets/space.dart';
import 'package:rfaye3/features/cart/presentation/view_model/cart_cubit/cart_state.dart';
import 'package:rfaye3/features/main/data/models/product_model.dart';
import 'package:rfaye3/features/cart/presentation/view_model/cart_cubit/cart_cubit.dart';
import 'package:rfaye3/generated/l10n.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.productDetailsView,
          arguments: {
            'product': product,
            "cartCubit": context.read<CartCubit>(),
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Stack(
          children: [
            if (product.stock == 0)
              Container(
                width: double.infinity,
                color: Colors.red,
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Text(
                  S.of(context).outOfStock,
                  textAlign: TextAlign.center,
                  style: TextStyles.medium15.copyWith(color: Colors.white),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.center,
                      child: CachedNetworkImage(
                        imageUrl: product.coverPictureUrl,
                        width: MediaQuery.of(context).size.width * 0.5,
                        fit: BoxFit.contain,
                        placeholder:
                            (context, url) => const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ),
                            ),
                        errorWidget:
                            (context, url, error) => const Center(
                              child: Icon(
                                Icons.image_not_supported_outlined,
                                size: 50,
                              ),
                            ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(product.name, style: TextStyles.semiBold13),
                  const SpaceV(4),
                  Text(
                    "${product.price} ${S.of(context).egp}",
                    style: TextStyles.bold13.copyWith(
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ],
              ),
            ),

            // const FavIcon(),
            product.stock == 0
                ? const SizedBox()
                : Positioned.directional(
                  textDirection:
                      isArabic ? TextDirection.ltr : TextDirection.rtl,
                  bottom: 16,
                  start: 10,
                  child: BlocListener<CartCubit, CartState>(
                    listener: (context, state) {
                      if (state is CartFail) {
                        showNotification(context, state.error, NotiType.error);
                      } else if (state is AddedToCart) {
                        showNotification(
                          context,
                          'تم اضافة ${product.name} إلي السلة',
                          NotiType.success,
                        );
                      }
                    },
                    child: InkWell(
                      onTap: () {
                        context.read<CartCubit>().addToCart(product.id);
                      },
                      child: const CircleAvatar(
                        backgroundColor: AppColors.primaryColor,
                        child: Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
