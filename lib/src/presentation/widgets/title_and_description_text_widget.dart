import 'package:flutter/material.dart';
import 'package:onusworks_albums_app/core/app_style.dart';

class HeaderWithTitleAndDescription extends StatelessWidget {
  final String title;
  final String? description;
  final String? logoImagePath;
  final double? height;
  final double? width;
  final double? padding;
  const HeaderWithTitleAndDescription({
    super.key,
    required this.title,
    this.description,
    this.logoImagePath,
    this.height = 50,
    this.width = 50,
    this.padding = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        title,
        style: AppStyle.headerTextStyle,
        maxLines: 2,
        textAlign: TextAlign.center,
      ),
      SizedBox(height: padding),
      if (description != null)
        Text(
          description!,
          style: AppStyle.bodyTextStyle,
          maxLines: 4,
          textAlign: TextAlign.center,
        ),
      if (logoImagePath != null)
        Image(
          image: AssetImage(logoImagePath!),
          height: height,
          width: width,
        ),
    ]);
  }
}
