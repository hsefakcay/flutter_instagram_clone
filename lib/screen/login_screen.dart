import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app_clone/data/firebase_service/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback show;
  const LoginScreen(this.show, {super.key});

  @override
  State<LoginScreen> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  final email = TextEditingController();
  FocusNode email_F = FocusNode();
  final password = TextEditingController();
  FocusNode password_F = FocusNode();

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
                height: 100,
              ),
              Center(child: Image.asset('images/logo.jpg')),
              const SizedBox(height: 120),
              Textfield(email, Icons.email, "Email", email_F),
              SizedBox(height: 15.h),
              Textfield(password, Icons.lock, "Password", password_F),
              const SizedBox(height: 10),
              Forgot(),
              SizedBox(height: 10.h),
              Login(),
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
              child: const Text("Sign up",
                  style: TextStyle(fontSize: 15, color: Colors.blue, fontWeight: FontWeight.bold)))
        ],
      ),
    );
  }

  Widget Login() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: () async {
          await Authentication().Login(email: email.text, password: password.text);
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
            "Log in",
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
