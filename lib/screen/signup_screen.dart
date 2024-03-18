import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app_clone/data/firebase_service/firebase_auth.dart';
import 'package:instagram_app_clone/util/dialog.dart';
import 'package:instagram_app_clone/util/exeption.dart';
import 'package:instagram_app_clone/util/imagepicker.dart';

class SignupScreen extends StatefulWidget {
  final VoidCallback show;
  const SignupScreen(this.show, {super.key});

  @override
  State<SignupScreen> createState() => _LoginPageState();
}

class _LoginPageState extends State<SignupScreen> {
  final email = TextEditingController();
  FocusNode email_F = FocusNode();
  final password = TextEditingController();
  FocusNode password_F = FocusNode();
  final bio = TextEditingController();
  FocusNode bio_F = FocusNode();
  final username = TextEditingController();
  FocusNode username_F = FocusNode();
  final passwordConfirme = TextEditingController();
  FocusNode passwordConfirme_F = FocusNode();
  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                width: 96,
                height: 30,
              ),
              Center(child: Image.asset('images/logo.jpg')),
              SizedBox(
                height: 60.h,
              ),
              Center(
                child: InkWell(
                    onTap: () async {
                      File _imagefilee = await ImagePickerr().uploadImage("gallery");
                      setState(() {
                        _imageFile = _imagefilee;
                      });
                    },
                    child: CircleAvatar(
                      radius: 36.r,
                      backgroundColor: Colors.grey,
                      child: _imageFile == null
                          ? CircleAvatar(
                              radius: 34,
                              backgroundColor: Colors.grey.shade200,
                              backgroundImage: const AssetImage("images/person.jpg"),
                            )
                          : CircleAvatar(
                              radius: 34,
                              backgroundColor: Colors.grey.shade200,
                              backgroundImage: Image.file(
                                _imageFile!,
                                fit: BoxFit.cover,
                              ).image,
                            ),
                    )),
              ),
              const SizedBox(height: 50),
              Textfield(email, Icons.email, "Email", email_F),
              SizedBox(height: 15.h),
              Textfield(username, Icons.person, "Username", username_F),
              const SizedBox(height: 10),
              Textfield(bio, Icons.abc, "bio", bio_F),
              const SizedBox(height: 10),
              Textfield(password, Icons.lock, "Password", password_F),
              const SizedBox(height: 10),
              Textfield(passwordConfirme, Icons.lock, "passwordConfirme", passwordConfirme_F),
              const SizedBox(height: 10),
              Signup(),
              SizedBox(height: 10.h),
              Have(),
            ],
          ),
        ),
      ),
    );
  }

  Widget Have() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            "Don't have account?",
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
          GestureDetector(
              onTap: widget.show,
              child:
                  const Text("Login", style: TextStyle(fontSize: 15, color: Colors.blue, fontWeight: FontWeight.bold)))
        ],
      ),
    );
  }

  Widget Signup() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        //can touch
        onTap: () async {
          try {
            await Authentication().Signup(
                email: email.text,
                password: password.text,
                passwordConfirme: passwordConfirme.text,
                username: username.text,
                bio: bio.text,
                profile: _imageFile ?? File(""));
          } on exceptions catch (e) {
            dialogBuilder(context, e.massage);
          }
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 44.h,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            "Sign up",
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget Forgot() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        'Forgot your password',
        style: TextStyle(fontSize: 13.sp, color: Colors.blue, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget Textfield(TextEditingController controller, IconData icon, String type, FocusNode focusNode) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        style: TextStyle(fontSize: 18.sp, color: Colors.black),
        focusNode: focusNode,
        controller: controller,
        decoration: InputDecoration(
            hintText: type,
            prefixIcon: Icon(
              icon,
              color: focusNode.hasFocus ? Colors.black : Colors.grey,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(color: Colors.grey, width: 2.w),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(color: Colors.black, width: 2.w),
            )),
      ),
    );
  }
}
