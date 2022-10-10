
import 'package:chat_app/Models/LoginModel.dart';

abstract class RegisterStates{}
class initialRegister extends RegisterStates{}
class loadingRegister extends RegisterStates{}
class successRegister extends RegisterStates{

}
class errorRegister extends RegisterStates
{
  final String error;

  errorRegister(this.error);
}
class successChangeRegister extends RegisterStates{}
class successCreateUser extends RegisterStates{}
class errorCreateUser extends RegisterStates{
  final String error;

  errorCreateUser(this.error);
}

