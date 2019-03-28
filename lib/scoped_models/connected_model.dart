import "dart:convert";
import "dart:async";

import "package:http/http.dart" as http;
import "package:scoped_model/scoped_model.dart";
import 'package:shared_preferences/shared_preferences.dart';

import './../models/auth_user.dart';

mixin ConnectedModel on Model {
  AuthUser authenticatedUser;
  bool setLoading = false;
}

mixin UtilityModel on ConnectedModel {
  bool get isLoading {
    return setLoading;
  }
}

mixin UserModel on ConnectedModel {
//    header: {'Content-Type': 'application/json'}

  AuthUser get user {
    return authenticatedUser;
  }
  AuthUser get authUser {
    return authenticatedUser;
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    setLoading = true;
    notifyListeners();

    final Map<String, dynamic>userFormData = {
      'email': email,
      'password': password,
    };
//        'https://choirhub-staging.rmdform.com/api/login?email=$email&password=$password',
    final http.Response tokenResponse = await http.post(
        'https://choirhub-staging.rmdform.com/api/login',
        headers: {'Accept': 'application/json', 'Content-Type': 'application/json'},
        body: json.encode(userFormData),
    );

    final Map<String, dynamic>tokenData = json.decode(tokenResponse.body);
    bool hasError = false;
    String message = 'Something went wrong.';

    if (tokenData.containsKey('error')) {
      hasError = true;
      message = 'Email and passwords don\'t match. Please try again';
    }
    else if (tokenData.containsKey('token')) {
      hasError = false;
      message = 'Authentication succeeded!';

      // We got a token, now we progress
      final String userToken = tokenData['token'];

      final http.Response userResponse = await http.get(
          'https://choirhub-staging.rmdform.com/api/user',
          headers: {'Authorization': 'Bearer ' + userToken, 'Accept': 'application/json'},
      );
      final Map<String,dynamic>userResponseData = json.decode(userResponse.body);

      authenticatedUser = AuthUser(
        token: userToken,
        id: userResponseData['user']['id'],
        email: userResponseData['user']['email'],
        name: userResponseData['user']['name'],
        photoUrl: userResponseData['user']['photo_url'],
        currentTeamId: userResponseData['user']['current_team_id'],
        currentTeamName: userResponseData['user']['current_team_name'],
      );

      // Save the TOKEN!!!!
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', userToken);
      await prefs.setInt('userId', userResponseData['user']['id']);
      await prefs.setString('userEmail', userResponseData['user']['email']);
    }

    setLoading = false;
    notifyListeners();
    return {'success': !hasError, 'message': message};
  }


  void autoAuthenticate() async {
    print('start auto auth');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //TODO: Test how the server handles a bad token request — use this to refresh and ask for a new token, or to ask the user to sign in again
    String token = prefs.getString('token');
    authenticatedUser = null;

    if (token != null) {
      setLoading = true;
      notifyListeners();

      // Get the user data from the server again
      http.get(
          'https://choirhub-staging.rmdform.com/api/user',
          headers: {'Authorization': 'Bearer ' + token, 'Accept': 'application/json'},
      ).then((http.Response response) {
        // TODO: check the response if the token is invalid
        final Map<String,dynamic>responseData = json.decode(response.body);

        authenticatedUser = AuthUser(
          token: token,
          id: responseData['user']['id'],
          email: responseData['user']['email'],
          name: responseData['user']['name'],
          photoUrl: responseData['user']['photo_url'],
          currentTeamId: responseData['user']['current_team_id'],
          currentTeamName: responseData['user']['current_team_name'],
        );
        //        current_team_name: responseData['user']['current_team_id'], ///TODO: How to get the Team Name

        setLoading = false;
        notifyListeners();
      });
    }
  }

  void logout() async {

    // TODO: this needs to be implemented on the server end
//    // Submit LOGOUT to the server
//    setLoading = true;
//    http.post(
//      'https://choirhub-staging.rmdform.com/api/logout',
//      headers: {'Authorization': 'Bearer ' + authenticatedUser.token, 'Accept': 'application/json'},
//    ).then((http.Response response) {
// // TODO: then authUser = null and remove all prefs...
//
//      setLoading = false;
//      notifyListeners();
//    });

    authenticatedUser = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('userEmail');
    prefs.remove('userId');
  }


  //TODO: not if this is necessary to have an internal App logout timer...
  void setAuthTimeout(int time) {
    Timer(Duration(seconds: time), logout);
  }

}

