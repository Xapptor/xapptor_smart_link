import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class XapptorSmartLink extends StatefulWidget {
  final bool is_android;
  final bool is_ios;
  final String title;
  final String description;
  final String android_url;
  final String ios_url;
  final String version;
  final Color main_color;
  final String logo_path;
  final bool download_android_apk;

  const XapptorSmartLink({
    required this.is_android,
    required this.is_ios,
    required this.title,
    required this.description,
    required this.android_url,
    required this.ios_url,
    required this.version,
    required this.main_color,
    required this.logo_path,
    required this.download_android_apk,
  });

  @override
  State<XapptorSmartLink> createState() => _XapptorSmartLinkState();
}

class _XapptorSmartLinkState extends State<XapptorSmartLink> {
  main_button_action() {
    String url = widget.is_android ? widget.android_url : widget.ios_url;

    if (widget.is_ios || !widget.download_android_apk) {
      html.window.location.replace(url);
    } else {
      downloadAndroid(widget.android_url);
    }
  }

  secondary_button_action() {
    String url = widget.is_android ? widget.ios_url : widget.android_url;

    if (widget.is_ios && widget.download_android_apk) {
      downloadAndroid(widget.android_url);
    } else {
      html.window.location.replace(url);
    }
  }

  downloadAndroid(String url) {
    html.AnchorElement anchor_element = html.AnchorElement(href: url);
    anchor_element.download = url;
    anchor_element.click();
  }

  @override
  Widget build(BuildContext context) {
    String play_store = 'Google Play';
    String app_store = 'App Store';
    String platform = widget.is_android ? play_store : app_store;
    String contrary_platform = platform == play_store ? app_store : play_store;

    String main_button_title = platform;
    String secondary_button_title = contrary_platform;

    double button_height = 40;
    double button_width = 140;
    //Color button_color = widget.mainColor;
    Color button_color = Colors.black;

    Icon main_button_icon = Icon(
      widget.is_android ? FontAwesomeIcons.googlePlay : FontAwesomeIcons.apple,
      color: Colors.white,
      size: widget.is_android ? 20 : 25,
    );

    Icon secondary_button_icon = Icon(
      widget.is_android ? FontAwesomeIcons.apple : FontAwesomeIcons.googlePlay,
      color: Colors.white,
      size: widget.is_android ? 25 : 20,
    );

    double sized_box_height = 20;

    bool portrait = MediaQuery.of(context).orientation == Orientation.portrait;
    double screen_height = MediaQuery.of(context).size.height;
    double screen_width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: widget.main_color,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          html.window.location.reload();
        },
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        color: widget.main_color,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: screen_height,
            width: screen_width,
            child: FractionallySizedBox(
              widthFactor: portrait ? 0.8 : 0.3,
              child: Column(
                children: [
                  Expanded(
                    flex: 20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            widget.logo_path,
                            height: portrait ? 100 : 200,
                            width: portrait ? 100 : 200,
                          ),
                        ),
                        SizedBox(height: sized_box_height * 2),
                        Text(
                          widget.title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(height: sized_box_height / 2),
                        Text(
                          widget.description,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: sized_box_height * 1.5),
                        SizedBox(
                          height: button_height,
                          width: button_width,
                          child: ElevatedButton(
                            onPressed: () => main_button_action(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: button_color,
                              shape: const StadiumBorder(),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                main_button_icon,
                                Text(main_button_title),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: sized_box_height),
                        Text(
                          'Or',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        SizedBox(height: sized_box_height),
                        SizedBox(
                          height: button_height,
                          width: button_width,
                          child: ElevatedButton(
                            onPressed: () => secondary_button_action(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: button_color,
                              shape: const StadiumBorder(),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                secondary_button_icon,
                                Text(secondary_button_title),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Smart Link Version: ${widget.version}',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
