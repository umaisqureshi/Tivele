import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';
import 'package:tivele/global/global.dart';
import 'package:tivele/global/videos.dart';
import 'package:tivele/ui/auth/register.dart';
import 'package:tivele/ui/home/home_user.dart';
import 'package:tivele/service/token_auth/token_auth_service.dart';
import 'package:tivele/ui/textfield_widgets/textfield_2.dart';
import 'package:video_player/video_player.dart';

class LoginUser extends StatefulWidget {
  @override
  _LoginUserState createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void showErrorToast(msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        //timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }

  bool remember = false;
  bool loading = false;
  bool isBusy = false;
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset('assets/videos/video.mp4')
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(false);
        _controller.setVolume(0);
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => Register(),
        ),
        (_) => false,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: ModalProgressHUD(
            color: Colors.black,
            opacity: 0,
            child:Stack(
              children: [
                SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: SizedBox(
                      width: _controller.value.size?.width ?? 0,
                      height: _controller.value.size?.height ?? 0,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                ),
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.black.withOpacity(
                    0.6,
                  ),
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(32),
                    width: double.infinity,
                    child: SingleChildScrollView(
                        child:  Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'TIVELE',
                                  style: Global.style(bold: true, size: 36, caps: true),
                                ),
                                Text(
                                  'Login to access your account',
                                  style: Global.style(),
                                ),
                                SizedBox(
                                  height: 32,
                                ),
                                MyTextField(
                                  hint: 'Email / Username',
                                  controller: emailController,
                                ),
                                SizedBox(height: 32),
                                MyTextField(
                                  hint: 'Password',
                                  controller: passwordController,
                                  obscureText: true,
                                  /*onChanged: (value){
                                                      passwordController.text = value;
                                                    },*/
                                ),
                                SizedBox(height: 32),
                                ConfirmationSlider(
                                  onConfirmation: () {
                                    _loginAccount();
                                  },
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  textStyle: Global.style(
                                    color: Colors.black,
                                    size: 16,
                                  ),
                                  text: 'Swipe to Login',
                                  height: 50,
                                ),
                                SizedBox(height: 30),
                                loading
                                    ? Container(
                                  color: Colors.black,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                          Colors.black),
                                ),
                                      ),
                                    )
                                    : SizedBox(height: 36),
                              ],
                            ),
                    )

                  ),
                ),
              ],
            ),
            inAsyncCall: isBusy,
            // demo of some additional parameters
         //   opacity: 0.5,
            progressIndicator: Container(
              color: Colors.black,
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
             valueColor:  new AlwaysStoppedAnimation<Color>(
                  Colors.black),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _loginAccount() async {
    try {
      final result = await InternetAddress.lookup('google.com');

      if(emailController.text.isEmpty){
        showErrorToast("Please enter a valid Email or Username");
        return;
      }
      if(passwordController.text.isEmpty){
        showErrorToast("Please enter Password");
        return;
      }
      setState(() {
        isBusy=true;
      });
      var account = {
        'password': passwordController.text,
        'userNameOrEmailAddress': emailController.text,
        'rememberClient': true
      };
      var loginRes = await TokenAuthService.authenticate(account);
      if (loginRes) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => HomeUser(),
          ),
          (_) => false,
        );
      } else {
        showErrorToast("Email or Password is invalid");
      }
      setState(() {
        isBusy=false;
      });
    } on SocketException catch(_)
    {
      showErrorToast("Please check your Internet Connection");
    }
    catch (err) {
      final requestbody = json.decode(err.body);
      final data = requestbody['error'];
      showErrorToast(data["details"]);
      setState(() {
        isBusy=false;
      });
      print(err);
    }

  }

}
