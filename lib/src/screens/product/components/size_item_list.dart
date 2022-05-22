import 'package:flutter/material.dart';
import 'package:shop/src/screens/product/components/size_item.dart';

class SizeItemList extends StatefulWidget {
  const SizeItemList({
    Key? key,
  }) : super(key: key);

  @override
  State<SizeItemList> createState() => _SizeItemListState();
}

class _SizeItemListState extends State<SizeItemList> {
  int _isSelected = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizeItem(
          text: 'S',
          isSelected: _isSelected == 0,
          onTap: () {
            setState(() {
              _isSelected = 0;
            });
          },
        ),
        SizeItem(
          text: 'M',
          isSelected: _isSelected == 1,
          onTap: () {
            setState(() {
              _isSelected = 1;
            });
          },
        ),
        SizeItem(
          text: 'L',
          isSelected: _isSelected == 2,
          onTap: () {
            setState(() {
              _isSelected = 2;
            });
          },
        ),
        SizeItem(
          text: 'XL',
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
