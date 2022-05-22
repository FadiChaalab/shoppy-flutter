import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shop/src/components/custom_divider.dart';
import 'package:shop/src/components/custom_list_tile.dart';
import 'package:shop/src/components/headline_2_title.dart';
import 'package:shop/src/db/auth.dart';
import 'package:shop/src/models/cart.dart';
import 'package:shop/src/models/product.dart';
import 'package:shop/src/models/user.dart';
import 'package:shop/src/screens/cart/components/cart_button.dart';
import 'package:shop/src/screens/product/components/colors_item_list.dart';
import 'package:shop/src/screens/product/components/size_item_list.dart';
import 'package:shop/src/screens/product/components/thumbnailsimages.dart';
import 'package:shop/src/utils/constante.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

class DetailsScreen extends StatefulWidget {
  final Product product;
  const DetailsScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final _auth = AuthService();
  int quantity = 1;
  double totalPrice = 0;

  addToCart(UserModel user) async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      String cartId = const Uuid().v1();
      Cart cart = Cart(
        id: cartId,
        userId: user.uid!,
        productId: widget.product.id,
        productName: widget.product.title,
        productImage: widget.product.images[0],
        quantity: quantity,
        price: widget.product.price,
        total: totalPrice,
        dateTime: DateTime.now().toString(),
      );
      await _auth.addUserCart(user.carts!, cart).then(
        (value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: kSuccessColor,
              content: Text(
                'Product added to cart',
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: Colors.white),
              ),
            ),
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: kDangerColor,
          content: Text(
            AppLocalizations.of(context)!.offline,
            style: Theme.of(context)
                .textTheme
                .caption!
                .copyWith(color: Colors.white),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final remisePrice = widget.product.price -
        (widget.product.price * widget.product.remise) / 100;
    void incrementQuantity() {
      if (widget.product.quantity > quantity) {
        setState(() {
          quantity++;
          totalPrice = remisePrice * quantity;
        });
      }
    }

    void decrementQuantity() {
      if (quantity > 1) {
        setState(() {
          quantity--;
          totalPrice = remisePrice * quantity;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.only(
              top: kDefaultPadding,
              bottom: kDefaultPadding,
            ),
            child: SvgPicture.asset(
              "assets/icons/Arrow-Left-3.svg",
              color: Theme.of(context).colorScheme.secondary,
              height: 18,
              width: 18,
            ),
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.productDetailsTitle,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        children: [
          SizedBox(height: 20.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(kDefaultPadding),
            child: CachedNetworkImage(
              imageUrl: widget.product.images.first,
              height: 184.h,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: kDefaultPadding),
          ThumbnailsImages(
            images: widget.product.images,
          ),
          const SizedBox(height: kDefaultPadding * 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    '\$$remisePrice',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                        ),
                  ),
                  const SizedBox(width: kDefaultPadding / 2),
                  Text(
                    '\$${widget.product.price}',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                          color: kTextColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CartButton(
                    icon: 'assets/icons/add.svg',
                    onPressed: () {
                      incrementQuantity();
                    },
                  ),
                  const SizedBox(width: kDefaultPadding / 2),
                  Text(
                    '$quantity',
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
                      decrementQuantity();
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: kDefaultPadding / 2),
          const CustomDivider(),
          const SizedBox(height: kDefaultPadding / 2),
          Headline2Title(title: AppLocalizations.of(context)!.colorTitle),
          const SizedBox(height: kDefaultPadding),
          const ColosItemList(),
          const SizedBox(height: kDefaultPadding),
          Headline2Title(title: AppLocalizations.of(context)!.sizeTitle),
          const SizedBox(height: kDefaultPadding),
          const SizeItemList(),
          const SizedBox(height: kDefaultPadding),
          const CustomDivider(),
          CustomListTile(
            title: AppLocalizations.of(context)!.guideTitle,
            icon: 'assets/icons/arrow-3.svg',
            onTap: () {},
          ),
          const CustomDivider(),
          const SizedBox(height: kDefaultPadding),
          Headline2Title(title: AppLocalizations.of(context)!.pickupTitle),
          const SizedBox(height: kDefaultPadding),
          Text(
            AppLocalizations.of(context)!.pickupSubtitle,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                  color: kTextColor,
                ),
          ),
          const SizedBox(height: kDefaultPadding),
          const CustomDivider(),
          CustomListTile(
            title: AppLocalizations.of(context)!.checkTitle,
            icon: 'assets/icons/shop.svg',
            onTap: () {},
          ),
          const CustomDivider(),
          const SizedBox(height: kDefaultPadding * 2),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  height: 56,
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding,
                    vertical: kDefaultPadding / 2,
                  ),
                  decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        totalPrice == 0
                            ? '\$' + remisePrice.toString()
                            : '\$' + totalPrice.toString(),
                        style: Theme.of(context).textTheme.button!.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Total',
                        style: Theme.of(context).textTheme.button!.copyWith(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              Consumer<UserModel?>(builder: (context, user, _) {
                return Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 56,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: kDarkPrimaryColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                      ),
                      onPressed: () {
                        addToCart(user!);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.buyButton,
                        style: Theme.of(context).textTheme.button!.copyWith(
                              color: Colors.white,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              })
            ],
          ),
          const SizedBox(height: kDefaultPadding * 2),
        ],
      ),
    );
  }
}
