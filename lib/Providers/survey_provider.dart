import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class SurveyProvider extends ChangeNotifier {
  String _message = "";
  bool _status = false;
  bool _deleteStatus = false;

  String get message => _message;
  bool get status => _status;
  bool get deleteStatus => _deleteStatus;

  User? user = FirebaseAuth.instance.currentUser;

  CollectionReference surveyCollection =
  FirebaseFirestore.instance.collection("surveys");

  void addSurvey({
    required String question,
    required bool isMandatory,
    required List<Map<String, dynamic>> options,
    required String duration,
  }) async {
    _status = true;
    notifyListeners();

    try {
      final data = {
        "authorId": user!.uid,
        "author": {
          "uid": user!.uid,
          "profileImage": user!.photoURL,
          "name": user!.displayName,
        },
        "dateCreated": DateTime.now(),
        "survey": {
          "total_votes": 0,
          "voters": <Map>[],
          "question": question,
          "duration": duration,
          "options": options,
        },
       // "answerChoices": Map.fromIterable(options, key: (option) => option, value: (_) => 0),
      };

      await surveyCollection.add(data);
      _message = "Survey Created";
      _status = false;
      notifyListeners();
    } on FirebaseException catch (e) {
      _message = e.message!;
      _status = false;
      notifyListeners();
    } catch (e) {
      _message = "Please try again...";
      _status = false;
      notifyListeners();
    }
  }

  void deleteSurvey({required String surveyId}) async {
    _deleteStatus = true;
    notifyListeners();

    try {
      await surveyCollection.doc(surveyId).delete();
      _message = "Survey Deleted";
      _deleteStatus = false;
      notifyListeners();
    } on FirebaseException catch (e) {
      _message = e.message!;
      _deleteStatus = false;
      notifyListeners();
    } catch (e) {
      _message = "Please try again...";
      _deleteStatus = false;
      notifyListeners();
    }
  }

  void voteSurvey({
    required String? surveyId,
    required DocumentSnapshot surveyData,
    required String selectedOption,
    required int previousTotalVotes,
  }) async {
    _status = true;
    notifyListeners();

    try {
      List voters = surveyData['survey']["voters"];

      voters.add({
        "name": user!.displayName,
        "uid": user!.uid,
        "selected_option": selectedOption,
      });

      List options = surveyData["survey"]["options"];
      for (var i in options) {
        if (i["answer"] == selectedOption) {
          i["percent"]++;
        } else {
          if (i["percent"] > 0) {
            i["percent"]--;
          }
        }
      }
      // Update answerChoices
/*      Map<String, dynamic> answerChoices = Map.from(surveyData["answerChoices"]);
      answerChoices[selectedOption]++;*/

      // Update survey
      final data = {
        "author": {
          "uid": surveyData["author"]["uid"],
          "profileImage": surveyData["author"]["profileImage"],
          "name": surveyData["author"]["name"],
        },
        "dateCreated": surveyData["dateCreated"],
        "survey": {
          "total_votes": previousTotalVotes + 1,
          "voters": voters,
          "question": surveyData["survey"]["question"],
          "duration": surveyData["survey"]["duration"],
          "options": options,
          //"isMandatory": surveyData["isMandatory"],
        }
      };

      await surveyCollection.doc(surveyId).update(data);
      _message = "Vote Recorded";
      _status = false;
      notifyListeners();
    } on FirebaseException catch (e) {
      _message = e.message!;
      _status = false;
      notifyListeners();
    } catch (e) {
      print(e);
      _message = "Please try again...";
      _status = false;
      notifyListeners();
    }
  }

  void clear() {
    _message = "";
    notifyListeners();
  }
}
