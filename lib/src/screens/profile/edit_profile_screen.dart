import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop/src/components/image_profile.dart';
import 'package:shop/src/db/storage.dart';
import 'package:shop/src/screens/profile/components/edit_profile_form.dart';
import 'package:shop/src/utils/constante.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late File image;
  final picker = ImagePicker();
  final _storage = StorageRepo();

  uploadImage(File img) async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      await _storage.uploadProfilePicture(img);
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

  @override
  Widget build(BuildContext context) {
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
          AppLocalizations.of(context)!.profile,
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
          SizedBox(
            height: 20.h,
          ),
          Center(
            child: ImageProfile(
              width: 84,
              iconContainer: 32,
              icon: 'assets/icons/Camera.svg',
              onTap: () async {
                var pickedFile =
                    await picker.pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  image = File(pickedFile.path);
                  uploadImage(image);
                }
              },
            ),
          ),
          const SizedBox(
            height: kDefaultPadding * 2,
          ),
          const EditProfileForm(),
        ],
      ),
    );
  }
}
