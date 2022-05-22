import 'package:flutter/material.dart';
import 'package:shop/src/screens/product/components/color_item.dart';
import 'package:shop/src/utils/constante.dart';

class ColosItemList extends StatefulWidget {
  const ColosItemList({
    Key? key,
  }) : super(key: key);

  @override
  State<ColosItemList> createState() => _ColosItemListState();
}

class _ColosItemListState extends State<ColosItemList> {
  int _isSelected = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ColorItem(
          color: kPrimaryColor,
          isSelected: _isSelected == 0,
          onTap: () {
            setState(() {
              _isSelected = 0;
            });
          },
        ),
        ColorItem(
          color: kSecondaryColor,
          isSelected: _isSelected == 1,
          onTap: () {
            setState(() {
              _isSelected = 1;
            });
          },
        ),
        ColorItem(
          color: kStarIconColor,
          isSelected: _isSelected == 2,
          onTap: () {
            setState(() {
              _isSelected = 2;
            });
          },
        ),
        ColorItem(
          color: kDangerColor,
          isSelected: _isSelected == 3,
          onTap: () {
            setState(() {
              _isSelected = 3;
            });
          },
        ),
      ],
    );
  }
}
