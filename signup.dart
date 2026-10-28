import 'package:empty_project/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Pagedetails extends StatefulWidget {
  const new({super.key});

  @override
  State<Pagedetails > createState() => _PagedetailsState();
}

class _PagedetailsState extends State<Pagedetails > {
  final auth = FirebaseAuth.instance;

    Future<void> signUp(
  String username,
  String mail,
  String password,
  String confirmPassword,
) async {
  if (password != confirmPassword) {
    print('Passwords do not match');
    return;
  }

  await auth.createUserWithEmailAndPassword(
    email: mail,
    password: password,
  );

  await auth.currentUser?.updateDisplayName(username);
}

Future<void> signIn(String mail, String password) async {
  await auth.signInWithEmailAndPassword(
    email: mail,
    password: password,
  );
}



  final usernamecontroller= TextEditingController();
  final emailController=TextEditingController();
  final passwordController = TextEditingController();
  final confirmController =  TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
height: MediaQuery.of(context).size.height,
decoration: BoxDecoration(color: Colors.white),
padding: EdgeInsets.all(8),
margin: EdgeInsets.all(8),
child: Column(

  children: [
    Text('Sign up',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40),),
    SizedBox(height: 5),
    Text('Create your account',style: TextStyle(letterSpacing: 2),),
    SizedBox(height: 20),
    TextField(
      controller: usernamecontroller,
      decoration: InputDecoration(
        hintText: 'Username',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),


      ),
    ),SizedBox(height: 15,),
TextField(
  controller: emailController,
  decoration: InputDecoration(
    hintText: 'Email',
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  ),
),
SizedBox(height: 15,),

    TextField(
      controller: passwordController,
      obscureText: true,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],
      decoration: InputDecoration(
      hintText: 'Password',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),SizedBox(height: 15),
    TextField(
      controller: confirmController,
      obscureText: true,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],
      decoration: InputDecoration(
        hintText: 'Confirm Password',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),

    SizedBox(height: 20,),
    SizedBox(
      height: 45,
      width: 150,
      child: ElevatedButton(
    onPressed: () {
      signUp(
        usernamecontroller.text,
        emailController.text,
        passwordController.text,
        confirmController.text,

      );
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blueAccent,
      foregroundColor: Colors.white,
  
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    child: Text(
      'Sign up',
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    ),
  ),
    ),SizedBox(height: 25,),
    Center(child:
    Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Or',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,)),
        SizedBox(height: 25,),
      ],
    ), 
    ),
SizedBox(
  height: 45,
  width: 300,
  child: ElevatedButton(onPressed: (){
    signIn(emailController.text, passwordController.text);
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),)
  ),
   child: Text('Sign in with Google',
   style: TextStyle(color: Colors.blueAccent,fontSize: 20),)),
),

SizedBox(height: 50,),

 Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(fontSize: 15),
                  ),
                
                 TextButton(
  onPressed: (
    
  ) {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>OpenState()));
  
  },
  child: Text(
    'Login',
    style: TextStyle(
      color: Colors.blueAccent,
      fontSize: 15,
    ),
  ),
),
                ],
              ),
  ],
),

      ),
    
    
    
      ),
    );
  }
}