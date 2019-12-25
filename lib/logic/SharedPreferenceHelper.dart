import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static final String name = 'name';
  static final String email = 'email';
  static final String imageUrl = 'imageUrl';

   Future setDetails(String name, String email, String imageUrl) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(name, name);
    prefs.setString(email, email);
    prefs.setString(imageUrl, imageUrl);

    if (prefs.containsKey('name')) {
      return true;
    }
  }

  // static Future<ProfDetail> getDetails() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   ProfDetail details = ProfDetail(prefs.getString('name'),
  //       prefs.getString(email), prefs.getString(imageUrl));

  //   return details;
  // }

  static removedetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(name);
    prefs.remove(email);
    prefs.remove(imageUrl);
  } 

  
}
