import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_system/Register.dart';
import 'package:login_system/home.dart';
import 'package:login_system/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String greetingMessage() {
    var timeNow = DateTime.now().hour;

    if (timeNow <= 12) {
      return 'Good Morning';
    } else if ((timeNow > 12) && (timeNow <= 16)) {
      return 'Good Afternoon';
    } else if ((timeNow > 16) && (timeNow < 20)) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  TextEditingController email = TextEditingController();
  TextEditingController Password = TextEditingController();

  bool emailerror = false;
  bool passerror = false;
  bool hidepass = true;

  String emailmsg = "";
  String passmsg = "";

  Database? db;
  List<Map> l = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();



    Model().createDatabse().then((value) {
      db = value;

      String qry = "SELECT * FROM Register";
      db!.rawQuery(qry).then((value) {
        l = value;
        print(l);
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NewGradientAppBar(
        title: Text(
          greetingMessage(),
          style: TextStyle(
              letterSpacing: 1,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        gradient: LinearGradient(colors: [
          Color(0xff000a8f),
          Color(0xff5b00c0),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      body: SafeArea(child: ListView(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            alignment: Alignment.center,
            child: Image.network(
                'https://t3.ftcdn.net/jpg/03/39/70/90/360_F_339709048_ZITR4wrVsOXCKdjHncdtabSNWpIhiaR7.jpg'),
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (value) {
                print(value);
                if (emailerror) {
                  if (value.isNotEmpty) {
                    setState(() {
                      emailerror = false;
                    });
                  }
                }
              },
              controller: email,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Color(0xff000a8f), width: 3)),
                  border: OutlineInputBorder(),
                  hintText: "Enter Email Address",
                  labelText: "Email",
                  labelStyle: TextStyle(color: Color(0xff000a8f)),
                  errorText: emailerror ? emailmsg : null,
                  prefixIcon: Icon(
                    Icons.email_rounded,
                    color: Color(0xff000a8f),
                  )),
            ),
          ),

          Padding(
            padding:
            const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 3),
            child: TextField(
              onChanged: (value) {
                print(value);
                if (passerror) {
                  if (value.isNotEmpty) {
                    setState(() {
                      passerror = false;
                    });
                  }
                }
              },
              controller: Password,
              obscureText: hidepass,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Color(0xff000a8f), width: 3)),
                  border: OutlineInputBorder(),
                  hintText: "Enter Your Password",
                  labelText: "Password",
                  labelStyle: TextStyle(color: Color(0xff000a8f)),
                  suffixIcon: IconButton(
                      onPressed: () {
                        hidepass = !hidepass;
                        setState(() {});
                      },
                      icon: hidepass
                          ? Icon(
                        Icons.visibility,
                        color: Color(0xff000a8f),
                      )
                          : Icon(
                        Icons.visibility_off,
                        color: Color(0xff676767),
                      )),
                  errorText: passerror ? passmsg : null,
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Color(0xff000a8f),
                  )),
            ),
          ),

          InkWell(
            onTap: () {
              String Email = email.text;
              String pass = Password.text;

              bool emailValid = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(Email);
              bool passValid = RegExp(
                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                  .hasMatch(pass);

              if (Email.isEmpty) {
                setState(() {
                  emailerror = true;
                  emailmsg = "Enter Email Address";
                });
              } else if (!emailValid) {
                setState(() {
                  emailerror = true;
                  emailmsg = "Please Enter Valid Email Address";
                });
              }else if (pass.isEmpty) {
                setState(() {
                  passerror = true;
                  passmsg = "Enter your password";
                });
              } else if (!passValid) {
                setState(() {
                  passerror = true;
                  passmsg = "Please Enter Valid Formatted password";
                });
              }
              else
                {
                    for(int i=0; i<l.length; i++)
                      {
                        Map map = l[i];
                        String email = map['email'];
                        String mobile = map['contact'];
                        String password = map['password'];

                        if(Email == email && pass == password)
                          {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return Home();
                              },));
                          }
                        else
                          {
                            emailmsg = "Your entered Email did not Matched";
                            passmsg = "Your entered Password did not Matched";
                          }
                      }


                }
            },
            child: Container(
              height: 50,
              width: 50,
              margin: EdgeInsets.only(left: 120, right: 120, top: 10),
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                  color: Color(0xff000a8f),
                  shadows: [
                    BoxShadow(
                        blurRadius: 7,
                        spreadRadius: 1,
                        offset: Offset(0, 3),
                        color: Colors.black.withOpacity(0.4))
                  ],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),

        ],
      )),
    );
  }
}
