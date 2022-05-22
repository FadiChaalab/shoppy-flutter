import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/src/utils/constante.dart';

class UserInformationItem extends StatelessWidget {
  final String title;
  final String subtitle;
  const UserInformationItem({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: Text(
        title,
        style: Theme.of(context).textTheme.subtitle1!.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: kTextColor,
            ),
      ),
      trailing: Text(
        subtitle,
        style: Theme.of(context).textTheme.subtitle1!.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
