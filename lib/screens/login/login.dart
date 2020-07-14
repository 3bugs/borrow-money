import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

import 'package:libertyfund/etc/utils.dart';
import 'package:libertyfund/etc/constants.dart' as Constants;
import 'package:libertyfund/screens/application_form/application_form.dart';

final FacebookLogin facebookLogin = FacebookLogin();

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return wrapSystemUiOverlayStyle(child: LoginMain());
  }
}

class LoginMain extends StatefulWidget {
  @override
  _LoginMainState createState() => _LoginMainState();
}

class _LoginMainState extends State<LoginMain> {
  var _profile;

  static const List<Color> BG_GRADIENT_COLORS = [
    Constants.App.HEADER_GRADIENT_COLOR_START,
    Constants.App.HEADER_GRADIENT_COLOR_END,
  ];

  Future<void> _handlePressLoginFacebook(BuildContext context) async {
    final result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        print('Facebook access token: $token');
        //alert(context, 'Facebook access token', token);
        final graphResponse = await http.get(
            'https://graph.facebook.com/v3.1/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=$token');
        /*
        {
           "name": "Iiro Krankka",
           "first_name": "Iiro",
           "last_name": "Krankka",
           "email": "iiro.krankka\u0040gmail.com",
           "id": "<user id here>"
        }
         */
        final profile = jsonDecode(graphResponse.body);
        final String msg = 'ชื่อ: ${profile['name']}\n'
            //+ 'First name: ${profile['first_name']}\n'
            //+ 'Last name: ${profile['last_name']}\n'
            +
            'อีเมล: ${profile['email']}\n' +
            'ภาพโปรไฟล์: ${profile['picture']['data']['url']}\n' +
            'Facebook ID: ${profile['id']}';
        //alert(context, 'Profile', msg);

        setState(() {
          this._profile = profile;
        });
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Facebook login is cancelled by user.');
        break;
      case FacebookLoginStatus.error:
        alert(context, 'ผิดพลาด', result.errorMessage);
        break;
    }
  }

  void _handleClickNext() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ApplicationForm(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: DecoratedBox(
        position: DecorationPosition.background,
        decoration: BoxDecoration(
          /*gradient: LinearGradient(
            colors: BG_GRADIENT_COLORS,
            begin: Alignment(-1.0, -1.5),
            end: Alignment(1.0, 1.0),
          ),*/
          //color: Color(0xFFB50C11),
          image: DecorationImage(
            image: AssetImage('assets/images/login/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Constants.App.HORIZONTAL_MARGIN,
              vertical: Constants.App.VERTICAL_MARGIN,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        /*border: Border.all(
                          color: Colors.black,
                          width: getPlatformSize(1.0),
                        ),*/
                        borderRadius: BorderRadius.all(
                          Radius.circular((Constants.LoginScreen.LOGO_SIZE) / 2),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x66333333),
                            blurRadius: getPlatformSize(30.0),
                            spreadRadius: getPlatformSize(8.0),
                            offset: Offset(
                              getPlatformSize(0.0), // move right
                              getPlatformSize(10.0), // move down
                            ),
                          ),
                        ],
                      ),
                      child: Image(
                        image: AssetImage('assets/images/login/ic_logo-w512.png'),
                        width: Constants.LoginScreen.LOGO_SIZE,
                        height: Constants.LoginScreen.LOGO_SIZE,
                      ),
                    ),
                  ),
                ),
                /*Text(
                  'กองยืมเงิน',
                  style: TextStyle(
                    fontSize: getPlatformSize(40.0),
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF666666),
                  ),
                ),*/
                Flexible(
                  flex: 2,
                  child: Container(
                    //color: Color(0xE8FFFFFF),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            top: getPlatformSize(16.0),
                          ),
                          child: Center(
                            child: Text(
                              'กองยืมเงิน\nBorrow Money',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                  fontSize: getPlatformSize(36.0),
                                  //fontWeight: FontWeight.bold,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: _buildProfileInfo(),
                          ),
                        ),
                        _profile != null
                            ? Container(
                                decoration: BoxDecoration(
                                  color: Constants.App.HEADER_GRADIENT_COLOR_END,
                                  border: Border.all(
                                    width: getPlatformSize(2.0),
                                    color: Color(0xFF48C1B2),
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                        getPlatformSize(Constants.App.BOX_BORDER_RADIUS)),
                                  ),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    hoverColor: Constants.App.HEADER_GRADIENT_COLOR_START,
                                    splashColor: Constants.App.HEADER_GRADIENT_COLOR_START,
                                    focusColor: Constants.App.HEADER_GRADIENT_COLOR_START,
                                    highlightColor: Constants.App.HEADER_GRADIENT_COLOR_START,
                                    onTap: _handleClickNext,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        getPlatformSize(Constants.App.BOX_BORDER_RADIUS),
                                      ),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(getPlatformSize(12.0)),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            width: getPlatformSize(20.0),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                'ถัดไป',
                                                style: GoogleFonts.prompt(
                                                  textStyle: TextStyle(
                                                    color: Color(0xFF48C1B2),
                                                    fontSize: getPlatformSize(20.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            Icons.navigate_next,
                                            color: Color(0xFF48C1B2),
                                            size: 20.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            /*FlatButton(
                                onPressed: () {},
                                padding: EdgeInsets.all(getPlatformSize(16.0)),
                                color: Color(0xFF475659),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      width: getPlatformSize(20.0),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          'ถัดไป',
                                          style: GoogleFonts.prompt(
                                            textStyle: TextStyle(
                                              color: Color(0xFF48C1B2),
                                              fontSize: getPlatformSize(22.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.navigate_next,
                                      color: Color(0xFF48C1B2),
                                      size: 20.0,
                                    ),
                                  ],
                                ),
                              )*/
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileInfo() {
    const PROFILE_PICTURE_SIZE = 100.0;

    return _profile == null
        ? FlatButton(
            onPressed: () {
              _handlePressLoginFacebook(context);
            },
            padding: EdgeInsets.all(getPlatformSize(16.0)),
            color: Constants.LoginScreen.FACEBOOK_BUTTON_BACKGROUND,
            //splashColor: Constants.LoginScreen.FACEBOOK_BUTTON_BACKGROUND.withOpacity(0.5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage('assets/images/login/ic_facebook.png'),
                  width: Constants.LoginScreen.FACEBOOK_ICON_WIDTH,
                  height: Constants.LoginScreen.FACEBOOK_ICON_HEIGHT,
                ),
                SizedBox(
                  width: getPlatformSize(16.0),
                ),
                Text(
                  'เข้าระบบด้วย Facebook',
                  style: GoogleFonts.prompt(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: getPlatformSize(20.0),
                    ),
                  ),
                )
              ],
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(PROFILE_PICTURE_SIZE / 2),
                ),
                child: Image.network(
                  _profile['picture']['data']['url'],
                  width: getPlatformSize(PROFILE_PICTURE_SIZE),
                  height: getPlatformSize(PROFILE_PICTURE_SIZE),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: getPlatformSize(8.0),
              ),
              Text(
                _profile['name'],
                style: GoogleFonts.prompt(
                  textStyle: TextStyle(
                    fontSize: getPlatformSize(20.0),
                    color: Color(0xFFCCCCCC),
                  ),
                ),
              ),
            ],
          );
  }
}
