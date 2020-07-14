import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

import 'package:libertyfund/etc/utils.dart';
import 'package:libertyfund/etc/constants.dart' as Constants;

class ApplicationForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return wrapSystemUiOverlayStyle(child: ApplicationFormMain());
  }
}

class ApplicationFormMain extends StatefulWidget {
  @override
  _ApplicationFormMainState createState() => _ApplicationFormMainState();
}

class _ApplicationFormMainState extends State<ApplicationFormMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('แบบฟอร์ม')),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // space ก่อนช่องแรก
              SizedBox(
                height: getPlatformSize(8.0),
              ),

              // ช่องกรอกชื่อ
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: getPlatformSize(8.0),
                  horizontal: getPlatformSize(16.0),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'กรอกชื่อ',
                  ),
                  onChanged: (query) {},
                ),
              ),

              // ช่องกรอกนามสกุล
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: getPlatformSize(8.0),
                  horizontal: getPlatformSize(16.0),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'กรอกนามสกุล',
                  ),
                  onChanged: (query) {},
                ),
              ),

              //
              // ... ช่องอื่นๆ ใส่ตรงนี้
              //

            ],
          ),
        ));
  }
}
