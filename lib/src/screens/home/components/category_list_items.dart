import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/src/components/category_item.dart';
import 'package:shop/src/controllers/category_controller.dart';
import 'package:shop/src/utils/constante.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryListItems extends StatelessWidget {
  const CategoryListItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: kDefaultPadding),
      child: Consumer<CategoryController>(builder: (context, controller, _) {
        return SizedBox(
          height: 34,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: [
              CategoryItem(
                isActive: controller.selectedCategory == 0,
                title: AppLocalizations.of(context)!.allCategories,
                press: () {
                  controller.changeCategory(0);
                  controller.changeCategoryName('All');
                },
              ),
              CategoryItem(
                isActive: controller.selectedCategory == 1,
                title: AppLocalizations.of(context)!.man,
                press: () {
                  controller.changeCategory(1);
                  controller.changeCategoryName('Man');
                },
              ),
              CategoryItem(
                isActive: controller.selectedCategory == 2,
                title: AppLocalizations.of(context)!.woman,
                press: () {
                  controller.changeCategory(2);
                  controller.changeCategoryName('Woman');
                },
              ),
              CategoryItem(
                isActive: controller.selectedCategory == 3,
                title: AppLocalizations.of(context)!.kid,
                press: () {
                  controller.changeCategory(3);
                  controller.changeCategoryName('Kid');
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
