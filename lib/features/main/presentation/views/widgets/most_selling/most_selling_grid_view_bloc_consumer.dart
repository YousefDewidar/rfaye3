import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rfaye3/core/widgets/in_app_notification.dart';
import 'package:rfaye3/features/main/data/models/product_model.dart';
import 'package:rfaye3/features/main/presentation/view_model/most_seilling_cubit/most_seilling_cubit.dart';
import 'package:rfaye3/features/main/presentation/view_model/most_seilling_cubit/most_seilling_state.dart';
import 'package:rfaye3/features/main/presentation/views/widgets/most_selling/products_grid_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MostSellingGridViewBlocConsumer extends StatelessWidget {
  const MostSellingGridViewBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MostSeillingCubit, MostSeillingState>(
      listener: (context, state) {
        if (state is MostSeillingFailure) {
          showNotification(context, state.message, NotiType.error);
        }
      },
      builder: (context, state) {
        if (state is MostSeillingLoading) {
          return Skeletonizer.sliver(
            child: ProductsGridView(
              products: [
                ...List.generate(
                  6,
                  (index) => const ProductModel(
                    id: "0",
                    productCode: "",
                    name: "",
                    description: "",
                    coverPictureUrl: "",
                    price: 1,
                    stock: 1,
                    weight: 1,
                    color: "",
                    discountPercentage: 1,
                    sellerId: "",
                  ),
                ),
              ],
            ),
          );
        } else if (state is MostSeillingSuccess) {
          return ProductsGridView(products: state.products);
        } else {
          return const SliverToBoxAdapter(child: SizedBox());
        }
      },
    );
  }
}
