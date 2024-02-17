import 'dart:developer';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Providers/survey_fetch_provider.dart';
import '../../Providers/survey_provider.dart';
import '../../components/message.dart';

class SurveyPage extends StatefulWidget {
  const SurveyPage({Key? key}) : super(key: key);

  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  bool _isFetched = false;

  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<FetchSurveysProvider>(builder: (context, surveys, child) {
        if (_isFetched == false) {
          surveys.fetchAllSurveys();

          Future.delayed(const Duration(microseconds: 1), () {
            _isFetched = true;
          });
        }
        return SafeArea(
          child: surveys.isLoading == true
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : surveys.surveysList.isEmpty
              ? const Center(
            child: Text("No surveys at the moment"),
          )
              : CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      ...List.generate(surveys.surveysList.length,
                              (index) {
                            final data = surveys.surveysList[index];

                            log(data.data().toString());
                            Map author = data["author"];
                            Map survey = data["survey"];
                            Timestamp date = data["dateCreated"];

                            List voters = survey["voters"];
                            List<dynamic> options = survey["options"];

                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  border:
                                  Border.all(color: Colors.grey),
                                  borderRadius:
                                  BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    contentPadding:
                                    const EdgeInsets.all(0),
                                    title: Text(author["name"]),
                                    subtitle: Text(DateFormat.yMEd()
                                        .format(date.toDate())),

                                  ),
                                  Text(survey["question"]),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  ...List.generate(options.length,
                                          (index) {
                                        final dataOption = options[index];
                                        return Consumer<SurveyProvider>(
                                            builder: (context, vote, child) {
                                              WidgetsBinding.instance
                                                  .addPostFrameCallback(
                                                    (_) {
                                                  if (vote?.message != "") {
                                                    if (vote!.message.contains(
                                                        "Vote Recorded")) {
                                                      success(context,
                                                          message: vote.message);
                                                      surveys.fetchAllSurveys();
                                                      vote.clear();
                                                    } else {
                                                      error(context,
                                                          message: vote.message);
                                                      vote.clear();
                                                    }
                                                  }
                                                },
                                              );
                                              return GestureDetector(
                                                onTap: () {
                                                  log(user!.uid);

                                                  ///Update vote
                                                  if (voters.isEmpty) {
                                                    log("No vote");
                                                    vote.voteSurvey(
                                                        surveyId: data.id,
                                                        surveyData: data,
                                                        previousTotalVotes: survey["total_votes"],
                                                        selectedOption: dataOption["answer"]);
                                                  } else {
                                                    final isExists =
                                                    voters.firstWhere(
                                                            (element) =>
                                                        element["uid"] ==
                                                            user!.uid,
                                                        orElse: () {});
                                                    if (isExists == null) {
                                                      log("User does not exist");
                                                      vote.voteSurvey(
                                                          surveyId: data.id,
                                                          surveyData: data,
                                                          previousTotalVotes:
                                                          survey["total_votes"],
                                                          selectedOption:  dataOption["answer"]);
                                                      //
                                                    } else {
                                                      error(context,
                                                          message:
                                                          "You have already voted");
                                                    }
                                                    print(isExists.toString());
                                                  }
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 5),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Stack(
                                                          children: [
                                                            LinearProgressIndicator(
                                                              minHeight: 30,
                                                              value: dataOption[
                                                              "percent"] /
                                                                  100,
                                                              backgroundColor:
                                                              Colors.white,
                                                            ),
                                                            Container(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                  10),
                                                              height: 30,
                                                              child: Text(
                                                                  dataOption[
                                                                  "answer"]),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Text(
                                                          "${dataOption["percent"]}%")
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      }),
                                  Text(
                                      "Total votes : ${survey["total_votes"]}")
                                ],
                              ),
                            );
                          })
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}


