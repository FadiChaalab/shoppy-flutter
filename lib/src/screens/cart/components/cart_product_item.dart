import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop/src/controllers/cart_controller.dart';
import 'package:shop/src/models/cart.dart';
import 'package:shop/src/screens/cart/components/cart_button.dart';
import 'package:shop/src/utils/constante.dart';

class CartProductItem extends StatefulWidget {
  final Cart cart;
  const CartProductItem({
    Key? key,
    required this.cart,
  }) : super(key: key);

  @override
  State<CartProductItem> createState() => _CartProductItemState();
}

class _CartProductItemState extends State<CartProductItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _cartController = Provider.of<CartController>(context, listen: false);
    return GestureDetector(
      onLongPress: () {
        _cartController.removeFromCart(widget.cart);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: kDefaultPadding),
        height: 104.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Theme.of(context).cardColor,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Stack(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: widget.cart.productImage,
                      fit: BoxFit.cover,
                      height: 92.h,
                      width: 104.w,
                    ),
                  ),
                  const SizedBox(width: kDefaultPadding),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.cart.productName,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.secondary,
                              overflow: TextOverflow.ellipsis,
                            ),
                      ),
                      Text(
                        '\$${widget.cart.total.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Consumer<CartController>(builder: (context, cart, _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CartButton(
                        icon: 'assets/icons/add.svg',
                        onPressed: () {
                          cart.addQuantity(widget.cart);
                        },
                      ),
                      const SizedBox(width: kDefaultPadding / 2),
                      Text(
                        '${widget.cart.quantity}',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                      const SizedBox(width: kDefaultPadding / 2),
                      CartButton(
                        icon: 'assets/icons/minus.svg',
                        onPressed: () {
                          cart.subQuantity(widget.cart);
                        },
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
