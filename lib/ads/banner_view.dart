import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../InApp Purchase/singletons_data.dart';
import 'call_ads.dart';

typedef BlurBannerViewWidgetCreatedCallback = void Function(BlurBannerViewWidgetController controller);

class BlurViewBannerWidget extends StatefulWidget {
  final BlurBannerViewWidgetCreatedCallback onBlurBannerViewWidgetCreated;

  const BlurViewBannerWidget({
    Key? key,
    required this.onBlurBannerViewWidgetCreated,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BlurViewBannerWidgetState();
}

class _BlurViewBannerWidgetState extends State<BlurViewBannerWidget> {
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return const AndroidView(
        viewType: 'plugins/blur_view_banner_widget',
      );
    }
    return const Text('iOS platform version is not implemented yet.');
  }
}

class BlurBannerViewWidgetController {
  BlurBannerViewWidgetController._(int id) : _channel = MethodChannel('plugins/blur_view_banner_widget$id');

  final MethodChannel _channel;
}

class PreBannerAd extends StatefulWidget {
  final double? height;

  const PreBannerAd({super.key, this.height});

  @override
  State<PreBannerAd> createState() => _PreBannerAdState();
}

class _PreBannerAdState extends State<PreBannerAd> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        //TODO 2nd: listen playerPointsToAdd
        valueListenable: appData.entitlementIsActive,
        builder: (BuildContext context, bool value, Widget? child) {
          if (value) {
            return SizedBox();
          } else {
            if (Platform.isAndroid) {
              return SizedBox(
                height: adsModel.adsShow == false ? 0 : widget.height ?? 70,
                child: BlurViewBannerWidget(
                  onBlurBannerViewWidgetCreated: _onBannerViewWidgetCreated,
                ),
              );
            } else {
              return SizedBox();
            }
          }
        });
  }

  void _onBannerViewWidgetCreated(BlurBannerViewWidgetController controller) {
    setState(() {});
  }
}
