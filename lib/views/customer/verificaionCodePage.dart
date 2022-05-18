import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';
import 'package:tivele/controllers/customer/resendEmailController.dart';
import 'package:tivele/controllers/customer/verifyUserStatusController.dart';
import 'package:tivele/controllers/registrationController.dart';
import 'package:tivele/global/global.dart';
import 'package:tivele/ui/textfield_widgets/textfield_2.dart';
import 'package:video_player/video_player.dart';
import 'package:tivele/globals.dart' as globals;
class VerificationCodePage extends StatefulWidget {
  @override
  _VerificationCodePageState createState() => _VerificationCodePageState();
}

class _VerificationCodePageState extends State<VerificationCodePage> {
  TextEditingController codeController = TextEditingController();
  final ResendEmailController resendEmailController = Get.put(ResendEmailController());
  final VerifyUserController verifyUserController = Get.put(VerifyUserController());
  bool remember = false;
  bool _loading = false;
  String error = "";
  bool isBusy = false;
  VideoPlayerController controller;
  String verificationCode = Get.arguments[0];
  String userEmail = Get.arguments[1];
  int loadingValue = 0;
  @override
  void initState() {
    super.initState();
    resendEmailController.verificationINfo.value.data = Get.arguments[0];
    controller = VideoPlayerController.asset('assets/videos/video.mp4')
      ..initialize().then((_) {
        controller.play();
        controller.setLooping(false);
        controller.setVolume(0);
        setState(() {});
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Obx(() {
            return ModalProgressHUD(
              inAsyncCall: loadingValue==0?verifyUserController.isLoading.value:resendEmailController.isLoading.value,
              //   opacity: 0.5,
              progressIndicator: CircularProgressIndicator(
                backgroundColor: Colors.black.withOpacity(0.9),
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              child: Stack(
                children: [
                  SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: SizedBox(
                        width: controller.value.size?.width ?? 0,
                        height: controller.value.size?.height ?? 0,
                        child: VideoPlayer(controller),
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'TIVELE',
                              style: Global.style(
                                  bold: true, size: 36, caps: true),
                            ),
                            Text(
                              'Enter Verification Code',
                              style: Global.style(),
                            ),
                            SizedBox(
                              height: 32,
                            ),
                            MyTextField(
                              hint: 'Verification Code',
                              controller: codeController,
                              /*onChanged: (value){
                              nameController.text = value;
                            }*/
                            ),
                            SizedBox(height: 32),
                            ConfirmationSlider(
                              onConfirmation: () {

                                _registerAccount();
                              },
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              textStyle: Global.style(
                                color: Colors.black,
                                size: 16,
                              ),
                              text: 'Swipe to Verify',
                              height: 50,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'OR',
                              style: Global.style(
                                size: 16,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text.rich(
                              TextSpan(
                                text: 'Didn\'t Get Email? ',
                                style: Global.style(
                                  color: Colors.white70,
                                ),
                                children: [
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async{
                                      setState(() {
                                        loadingValue =1;
                                      });
                                      print(userEmail);
                                        Map<String, Object> userData = {
                                          'email': userEmail,
                                        };
                                       await resendEmailController.fetchResendData(userData);
                                       // if(resendEmailController.verificationINfo.value.status==200){
                                       //   print(resendEmailController.verificationINfo.value.data);
                                       //   verificationCode=resendEmailController.verificationINfo.value.data;
                                       //   print(verificationCode);
                                       // }
                                      },
                                    text: 'Resend',
                                    style: Global.style(
                                      bold: true,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            _loading
                                ? Container(
                              color: Colors.black,
                              child: Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                  valueColor:
                                  new AlwaysStoppedAnimation<Color>(
                                      Colors.black),
                                ),
                              ),
                            )
                                : SizedBox(height: 36),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          })),
    );
  }

  Future<void> _registerAccount() async {
    if (!await validate()) return;
    try {
      setState(() {
        loadingValue=0;
      });
      print(resendEmailController.verificationINfo.value.data);
      FocusScope.of(context).requestFocus(new FocusNode());
      if(codeController.text.trim()==resendEmailController.verificationINfo.value.data){
        Map<String, Object> userData = {
          'email': userEmail,
        };
        verifyUserController.fetchUpdateUserData(userData);
      }else{
        globals.showErrorSnackBar("Invalid Code!");
      }
      //await registrationController.fetchRegistration(userData, 0);
    } catch (err) {
      setState(() {
        isBusy = false;
      });
      showErrorToast("Error occurred while  Sign Up");
      print(err);
    }
    //var names = _fullName.split(' ');
    //var isBroker = context.read<UsersProvider>().newUserIsBroker;
  }

  Future<bool> validate() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (codeController.text.isEmpty) {
        showErrorToast("Please enter a code");
        return false;
      }
      return true;
    } on SocketException catch (_) {
      showErrorToast("Please check your Internet Connection");
      return false;
    } catch (err) {
      final requestbody = json.decode(err.body);
      final data = requestbody['error'];
      showErrorToast(data["message"]);
    }
  }

  void showErrorToast(msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        //timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }

  void showSuccessToast(msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        //timeInSecForIos: 1,
        backgroundColor: Colors.greenAccent,
        textColor: Colors.white);
  }
}
