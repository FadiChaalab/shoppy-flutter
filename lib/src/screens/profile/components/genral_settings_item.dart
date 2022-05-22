import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GenralSettingsItem extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onPress;
  const GenralSettingsItem(
      {Key? key,
      required this.title,
      required this.icon,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      contentPadding: const EdgeInsets.all(0),
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: SvgPicture.asset(
          icon,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      title: Text(title),
      trailing: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: SvgPicture.asset(
          'assets/icons/arrow-right.svg',
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
