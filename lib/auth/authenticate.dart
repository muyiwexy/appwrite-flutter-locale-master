import 'dart:convert';
import 'package:appwrite/appwrite.dart';
import 'package:ecommerce/data/localedata.dart';
import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../data/userdata.dart';

class Authenticate extends ChangeNotifier {
  Client client = Client(); // create a new Appwrite client
  Account? account; //call the Appwrite acccount API
  Locale? locale; //call the Appwrite Locale API
  late bool _isLoggedin; //Creates a boolean instance to check if user is logged in
  late bool _createaccount; //Creates a boolean instance to check if user is logged in
  User? _user; // calls our model class for userdata
  LocaleData? _localeData; // calls our model class for userdata

  bool get isLoggedin => _isLoggedin; //getter for _isLoggedin
  bool get createaccount => _createaccount;  //getter for _createaccount
  User? get user => _user;  //getter for _user
  LocaleData? get localedata => _localeData;  //getter for _localeData

  Authenticate() {
    _init(); // This function creates our appwrite instance
  }

  _init() {
    _isLoggedin = false; // initial boolean value for _isLoggedin
    _createaccount = false; // initial boolean value for _createaccount
    _user = null; 
    _localeData = null;
    client
        .setEndpoint(Appconstants.endpoint)
        .setProject(Appconstants.projectid);

    account = Account(client);  // create a new Appwrite account
    locale = Locale(client);  // create a new Appwrite locale
    _checkisLoggedin(); // checks two future functions (_user and _localeData)
  }

  _checkisLoggedin() async {
    try {
      _user = await _getaccount(); //_getaccount function checks if the user is already logged in and if true, load the userdata
      _localeData = await _localise(); //_localise function checks for the user's locale and loads it once the user is logged in
      _isLoggedin = true;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future _localise() async {
    try {
      var result = await locale?.get();
      _isLoggedin = true;
      _user = await _getaccount();
      notifyListeners();
      if (result?.ip != null) {
        var data = jsonEncode(result?.toMap());
        var jsondata = jsonDecode(data);
        return LocaleData.fromJson(jsondata);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<User?> _getaccount() async {
    try {
      final res = await account?.get();
      if (res?.status != null || res?.status == true) {
        final jsondata = jsonEncode(res!.toMap());
        final json = jsonDecode(jsondata);
        return User.fromJson(json);
        // return res;
      } else {
        return null;
      }
    } catch (e) {
      throw (e);
    }
  }

  localisation() async {
    return await locale?.get();
  }

  login(String email, String password) async {
    try {
      await account!.createEmailSession(email: email, password: password); // create a new email session with respect to the parameters provided (if an account exist, then we will be able to create a new session)
      _user = await _getaccount(); 
      _localeData = await _localise();
      _isLoggedin = true;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  signup(String name, String email, String password) async {
    try {
      var result = await account!.create(
          userId: 'unique()', name: name, email: email, password: password); // create a new account with respect to the parameters given
      _createaccount = false;
      if (result.status == true) {  // checks of the status of the create account command is true or false.if it is true, it will set the _createaccount boolean to true and if it false, it will return the _getaccount function
        _createaccount = true;
      } else {
        return await _getaccount();
      }
    } catch (e) {
      print(e);
    }
  }

  signout() async {
    try {
      await account?.deleteSession(sessionId: 'current'); // delete the current logged in user session
      _isLoggedin = false; // sets _isLoggedin to false thus the page won't automatically be logged in when re initialised
      _user = await _getaccount();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
