import 'package:flutter/material.dart';
import 'package:historico_academico/assets/widgets/styles.dart';
import 'package:historico_academico/env.dart';
import 'package:historico_academico/assets/widgets/inputs.dart';
import 'package:historico_academico/assets/widgets/buttons.dart';
import 'package:historico_academico/Data/DataResponse.dart';
import 'package:historico_academico/Business/UserBusiness.dart';
import '../../assets/widgets/dialog.dart';
import 'package:historico_academico/main.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  UserBusiness userBuiness=new UserBusiness();
  final controllerRegister = TextEditingController();
  final controllerPass = TextEditingController();
  bool _visible = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style().backgroundColor(),
      body: SafeArea(
        child: SizedBox.expand(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: todo(context),
              )
            ],
          ),
        ),
      ),
    );
  }


  Widget todo(BuildContext context) {
    return
      SafeArea(
          child: Container(
            padding: EdgeInsets.all(20.0),
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Image.asset(assetURL()+"JaldinSolutions.png", alignment: Alignment.center, height: 350, width: 350,),
                _registerBox(),
                const SizedBox(height: 20.0),
                _passwordBox(),
                const SizedBox(height: 20.0),
                buttonPrimary(context, "INICIAR SESION", login),
                const SizedBox(height: 20.0),
                buttonSeccondary(context, "REGISTRARME", (){}),
              ],
            ),
          )
      );
  }
  Widget _passwordBox(){
    return SizedBox(
      width: 300,
      child: Material(
        elevation: 3.0,
        borderRadius: const BorderRadius.all(
            Radius.circular(15.0)
        ),
        child: TextField(
          obscureText: !_visible,
          controller: controllerPass,
          decoration: InputDecoration(
              hintText: "Password",
              fillColor: Colors.white,
              filled: true,
              suffixIcon: TextButton(
              child: _visible?const Icon(Icons.lock_open):const Icon(Icons.lock),
              onPressed: (){
                setState(() {
                  _visible = !_visible;
                });
              },
            ),
          ),
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _registerBox(){
    return SizedBox(
      width: 300,
      child: Material(
        elevation: 3.0,
        borderRadius: const BorderRadius.all(
            Radius.circular(15.0)
        ),
        child: TextField(
          controller: controllerRegister,
          decoration: InputDecoration(
            hintText: "Registro",
            fillColor: Colors.white,
            filled: true,
            suffixIcon: TextButton(
              child: Icon(Icons.person),
              onPressed: (){
              }
            ),
          ),
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.black,

          ),
        ),
      ),
    );
  }
  Future<void> login() async{
    showLoadingIndicator(context,'Iniciando sesion');
    DataResponse dataResponse=await userBuiness.login(controllerRegister.text,controllerPass.text);
    //DataResponse dataResponse=await userBuiness.login('218081146','123');
    setState(() {
      hideOpenDialog(context);
      if (dataResponse.status){
        Navigator.pushReplacementNamed(context,userIndexRoute());
      }else{
        showAlertDialog(context, "Error al iniciar Sesion", dataResponse.message);
      }
    });
  }
  //
  // Future<void> signUp() async{
  //   Navigator.pushReplacementNamed(context, signupRoute());
  // }
  //

}
