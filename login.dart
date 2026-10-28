import 'package:empty_project/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OpenState extends StatefulWidget {
  const new({super.key});

  @override
  State<OpenState> createState() => _OpenStateState();
}

class _OpenStateState extends State<OpenState> {
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;

    Future<void> signUp(String mail, String password) async {
      await auth.createUserWithEmailAndPassword(
        email: mail,
        password: password,
      );
    }

    Future<void> signIn(String mail, String password) async {
      try {
        await auth.signInWithEmailAndPassword(email: mail, password: password);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found' ||
            e.code == 'invalid-credential' ||
            e.code == 'wrong-password') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Pagedetails()),
          );
        }
      }
    }

    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    Future<void> forgotPassword() async {
      await auth.sendPasswordResetEmail(email: emailController.text);
    }

    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              Text("Welcome Back", style: TextStyle(fontSize: 40)),
              Text(
                "Enter your credential to login!",
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 5),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  'https://tse3.mm.bing.net/th/id/OIP.dVqS9mohW2h9FUzbp5kpJwHaHZ?r=0&pid=Api&h=220&P=0',
                ),
              ),
              SizedBox(height: 30),

              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter the email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter the password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 40),

              SizedBox(
                width: 150,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    signIn(emailController.text, passwordController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),

              SizedBox(height: 90),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: forgotPassword,
                  child: Text('Forgot Password?'),
                ),
              ),
              SizedBox(height: 200),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 15),
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Pagedetails()),
                      );
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 15),
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
