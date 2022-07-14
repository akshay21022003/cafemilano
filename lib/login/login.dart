import 'package:cafemilanoadmin/login/button.dart';
import 'package:cafemilanoadmin/login/login_auth_provider.dart';
import 'package:cafemilanoadmin/signup/signuppage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Widget Textfield({required String hinttext,required IconData icon,required Color? iconColor,required TextEditingController controller}){
    return
      Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon,color: iconColor,),
          hintText: hinttext,
          hintStyle: TextStyle(color: Colors.brown[900]),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.brown.shade900,strokeAlign: StrokeAlign.center,width:1),
              borderRadius: BorderRadius.circular(10)
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    LoginAuthProvider loginAuthProvider =
    Provider.of<LoginAuthProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('LOGIN HERE',style: TextStyle(color: Colors.brown[900],fontSize: 30,fontWeight: FontWeight.bold,letterSpacing: 3),),
        backgroundColor: Colors.amber,
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              children: [
                Expanded(child: Container(
                  width: double.infinity,
                  color: Colors.brown[900],
                  child:FittedBox(
                    fit: BoxFit.contain,
                    child: Padding(
                      padding: EdgeInsets.only(top: 10,bottom: 10),
                      child: CircleAvatar(
                        backgroundImage:AssetImage('asset/burger.png'),
                        maxRadius: 90,
                      ),
                    ),
                  ),

                )),
                Expanded(flex: 2,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height:380,
                            child: Column(

                              children: [
                                Textfield(hinttext: 'Email',icon: Icons.person_outline,iconColor: Colors.brown[900],controller: email),
                                SizedBox(height: 20,),
                                Textfield(hinttext: 'Password',icon: Icons.lock_open_outlined,iconColor: Colors.brown[900],controller: password),
                                SizedBox(height: 25,),

                                MyButton(
                                      onPressed: (){
                                        loginAuthProvider.loginPageVaidation(
                                          email: email,
                                          password: password,
                                          context: context,
                                        );
                                        },
                                      text: 'LOGIN'),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('New User?',style: TextStyle(color: Colors.grey[600]),),
                                      TextButton(onPressed:(){Navigator.push(context,MaterialPageRoute(builder: (context){return signuppage();}));},
                                          child: Text('Register Now',style:TextStyle(color: Colors.amber),))



                                  ],
                                ),



                              ],
                            ),
                          ),

                        ],
                      ),

                    ))
              ],
            ),

          ],
        ),
      ),

    );
  }
}
