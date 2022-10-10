
import 'package:chat_app/Models/LoginModel.dart';

abstract class socialState{}
class initialSocial extends socialState{}
class loadingSocial extends socialState{}
class successSocial extends socialState{
final String uId;

  successSocial(this.uId);

}
class errorSocial extends socialState
{
  final String error;

  errorSocial(this.error);
}
class successChange extends socialState{}
//class bottomChange extends socialState{}

//class loadingHome extends socialState{}
//class successHome extends socialState{

/*}
class errorHome extends socialState
{
  final String error;

  errorHome(this.error);
}

class loadingCategory extends socialState{}
class successCategory extends socialState{

}
class errorCategory extends socialState
{
  final String error;

  errorCategory(this.error);
}

class loadingSettings extends socialState{}
class successSettings extends socialState{

}
class errorSettings extends socialState
{
  final String error;

  errorSettings(this.error);
}

class loadingFav extends socialState{}
class successFav extends socialState{

}
class errorFav extends socialState
{
  final String error;

  errorFav(this.error);
}
class changefav extends socialState{}

class loadingFavScreen extends socialState{}
class successFavScreen extends socialState{

}
class errorFavScreen extends socialState
{
  final String error;

  errorFavScreen(this.error);
}

class darkState extends socialState{}*/