import 'package:flutter/material.dart';
import 'package:login_system/Login.dart';
import 'package:login_system/model.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:sqflite/sqflite.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController Password = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController conPassword = TextEditingController();
  TextEditingController Date = TextEditingController();

  bool nameerror = false;
  bool namevalid = false;
  bool emailerror = false;
  bool passerror = false;
  bool contacterror = false;
  bool conpasserror = false;
  bool DateError = false;
  bool hidepass = true;
  bool hidepass2 = true;

  int textLength = 0;
  int maxLength = 10;

  String contactmsg = "";
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
      db!.rawQuery(qry).then((value1) {
        l = value1;
        print(l);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
      body: ListView(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            alignment: Alignment.center,
            child: Image.network(
                'https://media.istockphoto.com/vectors/register-account-submit-access-Register-password-username-internet-vector-id1281150061?k=20&m=1281150061&s=612x612&w=0&h=wpCvmggedXRECWK-FVL98MMllubyevIrXuUu50fdCqE='),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (value) {
                print(value);
                if (nameerror) {
                  if (value.isNotEmpty) {
                    setState(() {
                      nameerror = false;
                    });
                  }
                }
              },
              controller: name,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff000a8f), width: 3)),
                  border: OutlineInputBorder(),
                  hintText: "Enter Name",
                  labelText: "Name",
                  labelStyle: TextStyle(color: Color(0xff000a8f)),
                  errorText: nameerror ? "Please Enter Valid Name" : null,
                  prefixIcon: Icon(
                    Icons.person,
                    color: Color(0xff000a8f),
                  )),
            ),
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
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  textLength = value.length;
                });
                if (contacterror) {
                  if (value.isNotEmpty) {
                    setState(() {
                      contacterror = false;
                    });
                  }
                }
              },
              controller: contact,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff000a8f))),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff000a8f), width: 3)),
                  counter: Offstage(),
                  suffixText:
                      '${textLength.toString()}/${maxLength.toString()}',
                  hintText: "Enter Your Contact",
                  labelText: "Contact",
                  labelStyle: TextStyle(color: Color(0xff000a8f)),
                  errorText: contacterror ? contactmsg : null,
                  prefixIcon: Icon(
                    Icons.phone,
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (value) {
                print(value);
                if (conpasserror) {
                  if (value.isNotEmpty) {
                    setState(() {
                      conpasserror = false;
                    });
                  }
                }
              },
              controller: conPassword,
              obscureText: hidepass2,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff000a8f), width: 3)),
                  border: OutlineInputBorder(),
                  hintText: "Enter Valid Password",
                  labelText: "Confirm Password",
                  labelStyle: TextStyle(color: Color(0xff000a8f)),
                  suffixIcon: IconButton(
                      onPressed: () {
                        hidepass2 = !hidepass2;
                        setState(() {});
                      },
                      icon: hidepass2
                          ? Icon(
                              Icons.visibility,
                              color: Color(0xff000a8f),
                            )
                          : Icon(
                              Icons.visibility_off,
                              color: Color(0xff676767),
                            )),
                  errorText:
                      conpasserror ? "Please Enter Your Valid Password" : null,
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Color(0xff000a8f),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (value) {
                print(value);
                if (DateError) {
                  if (value.isNotEmpty) {
                    setState(() {
                      DateError = false;
                    });
                  }
                }
              },
              controller: Date,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff000a8f), width: 3)),
                  border: OutlineInputBorder(),
                  hintText: "Enter Date of Birth",
                  labelText: "Birthdate",
                  labelStyle: TextStyle(color: Color(0xff000a8f)),
                  errorText: DateError ? "Enter Valid Date Format" : null,
                  prefixIcon: Icon(
                    Icons.calendar_month,
                    color: Color(0xff000a8f),
                  )),
            ),
          ),
          InkWell(
            onTap: () {
              String Name = name.text;
              String Phone = contact.text;
              String Email = email.text;
              String pass = Password.text;
              String Conpass = conPassword.text;
              String date = Date.text;
              bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(Email);
              bool passValid = RegExp(
                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                  .hasMatch(pass);

              if (Name.isEmpty) {
                setState(() {
                  nameerror = true;
                });
              } else if (Email.isEmpty) {
                setState(() {
                  emailerror = true;
                  emailmsg = "Enter Email Address";
                });
              } else if (!emailValid) {
                setState(() {
                  emailerror = true;
                  emailmsg = "Please Enter Valid Email Address";
                });
              } else if (Phone.isEmpty) {
                setState(() {
                  contacterror = true;
                  contactmsg = "Enter your Contact";
                });
              } else if (Phone.length < 10) {
                setState(() {
                  contacterror = true;
                  contactmsg = "Please Enter 10 digit Contact";
                });
              } else if (pass.isEmpty) {
                setState(() {
                  passerror = true;
                  passmsg = "Enter your password";
                });
              } else if (!passValid) {
                setState(() {
                  passerror = true;
                  passmsg = "Please Enter Valid Formatted password";
                });
              } else if (Conpass.isEmpty || pass != Conpass) {
                setState(() {
                  conpasserror = true;
                });
              } else if (date.isEmpty) {
                setState(() {
                  DateError = true;
                });
              } else {

                String qry =
                    "INSERT INTO Register ( name, email, contact, password, con_pass, birthdate) values ('$Name','$Email','$Phone','$pass','$Conpass','$date')";

                db!.rawInsert(qry).then((value) {
                  print(value);
                });

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return Login();
                },));
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
                "Register",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          Center(
            child: TextButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Login();
              },));
            }, child: Text("Already Login ?",)),
          )
        ],
      ),
    ));
  }
}
