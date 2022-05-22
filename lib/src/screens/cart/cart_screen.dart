import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop/src/components/default_button.dart';
import 'package:shop/src/components/headline_title.dart';
import 'package:shop/src/components/no_data.dart';
import 'package:shop/src/controllers/cart_controller.dart';
import 'package:shop/src/db/orders.dart';
import 'package:shop/src/models/order.dart';
import 'package:shop/src/models/user.dart';
import 'package:shop/src/screens/cart/components/cart_product_item.dart';
import 'package:shop/src/screens/success/rating_screen.dart';
import 'package:shop/src/utils/constante.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _orders = Orders();

    Future<void> addOrder(UserModel user, CartController cart) async {
      var result = await Connectivity().checkConnectivity();
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        final id = const Uuid().v1();
        final username = user.firstName! + ' ' + user.lastName!;
        Order order = Order(
          id: id,
          userId: user.uid!,
          userName: username,
          userPhone: user.phone.toString(),
          userAddress: user.addrese!,
          userEmail: user.email!,
          quantity: cart.cartQuantity,
          total: cart.cartTotal,
          dateTime: DateTime.now().toString(),
        );
        await _orders.addOrder(order).then(
          (value) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const RatingScreen(),
              ),
            );
            cart.clearCart();
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              AppLocalizations.of(context)!.offline,
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(height: 20.h),
          HeadlineTitle(
            title: AppLocalizations.of(context)!.order,
          ),
          const SizedBox(height: kDefaultPadding),
          Consumer2<UserModel?, CartController>(
              builder: (context, user, carts, _) {
            if (carts.carts.isEmpty == true) {
              return const NoDataWidget();
            }
            return Column(
              children: [
                ...carts.carts.map(
                  (cart) => CartProductItem(
                    cart: cart,
                  ),
                ),
                const SizedBox(height: kDefaultPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const HeadlineTitle(title: 'Total'),
                    Text(
                      '\$' + carts.cartTotal.toString(),
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultPadding * 2),
                DefaultButton(
                  text: AppLocalizations.of(context)!.buy,
                  press: () {
                    addOrder(user!, carts);
                  },
                ),
              ],
            );
          }),
          const SizedBox(height: kDefaultPadding),
        ],
      ),
    );
  }
}
