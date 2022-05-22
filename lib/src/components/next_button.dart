import 'package:shop/src/utils/constante.dart';
import 'package:flutter/material.dart';

class NextPageButton extends StatelessWidget {
  final VoidCallback onPressed;

  const NextPageButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      padding: const EdgeInsets.all(kDefaultPadding),
      elevation: 0.0,
      shape: const CircleBorder(),
      fillColor: kPrimaryColor,
      onPressed: onPressed,
      child: const Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
    );
  }
}
