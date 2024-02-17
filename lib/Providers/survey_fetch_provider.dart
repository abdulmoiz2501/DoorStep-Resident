import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FetchSurveysProvider extends ChangeNotifier {
  List<DocumentSnapshot> _surveysList = [];
  List<DocumentSnapshot> _usersSurveysList = [];

  DocumentSnapshot? _individualSurvey;

  bool _isLoading = true;

  ///
  bool get isLoading => _isLoading;

  List<DocumentSnapshot> get surveysList => _surveysList;
  List<DocumentSnapshot> get userSurveysList => _usersSurveysList;

  DocumentSnapshot get individualSurvey => _individualSurvey!;

  User? user = FirebaseAuth.instance.currentUser;

  CollectionReference surveyCollection =
  FirebaseFirestore.instance.collection("surveys");

  ///Fetch all surveys
  void fetchAllSurveys() async {
    surveyCollection.get().then((value) {
      if (value.docs.isEmpty) {
        _surveysList = [];
        _isLoading = false;
        notifyListeners();
      } else {
        final data = value.docs;

        _surveysList = data;
        _isLoading = false;
        notifyListeners();
      }
    });
  }

  ///Fetch user surveys
  void fetchUserSurveys() async {
    surveyCollection
        .where("authorId", isEqualTo: user!.uid)
        .get()
        .then((value) {
      print(user!.uid);
      // print(value.docs[0].data());
      if (value.docs.isEmpty) {
        _usersSurveysList.clear();
        _isLoading = false;
        notifyListeners();
      } else {
        final data = value.docs;

        _usersSurveysList = data;
        _isLoading = false;
        notifyListeners();
      }
    });
  }

  ///fetch individual surveys
  void fetchIndividualSurveys(String id) async {
    surveyCollection.doc(id).get().then((value) {
      if (!value.exists) {
        _individualSurvey = value;
        _isLoading = false;
        notifyListeners();
      } else {
        final data = value;

        _individualSurvey = data;
        _isLoading = false;
        notifyListeners();
      }
    });
  }
}
