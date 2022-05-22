import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/src/models/user.dart';
import 'package:shop/src/utils/constante.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageProfile extends StatelessWidget {
  final double width;
  final String icon;
  final double? iconContainer;
  final double? bottom;
  final double? right;
  final VoidCallback onTap;
  const ImageProfile(
      {Key? key,
      required this.width,
      required this.icon,
      required this.onTap,
      this.bottom = 4,
      this.right = -8,
      this.iconContainer = 24})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImageProvider getImage(String? image, String? uid) {
      if (image != null && image.isNotEmpty) {
        return CachedNetworkImageProvider(image, cacheKey: uid);
      } else {
        return const AssetImage("assets/images/profile.jpg");
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        height: width,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Consumer<UserModel?>(builder: (context, user, _) {
              String? image = user?.avatarUrl;
              String? uid = user?.uid;
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: kSkipShadeThGradientColor.withOpacity(0.16),
                    width: 3,
                  ),
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  backgroundImage: getImage(image, uid),
                  radius: 58,
                ),
              );
            }),
            Positioned(
              bottom: 4,
              right: -8,
              child: Container(
                width: iconContainer,
                height: iconContainer,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  shape: BoxShape.circle,
                  color: kPrimaryColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SvgPicture.asset(
                    icon,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
