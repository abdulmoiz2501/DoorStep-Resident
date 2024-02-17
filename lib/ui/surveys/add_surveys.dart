import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Providers/survey_fetch_provider.dart';
import '../../components/message.dart';
import '../../constants/colors.dart';
import '../../components/message.dart';
import '../../Providers/survey_provider.dart';

class AddSurveysPage extends StatefulWidget {
  const AddSurveysPage({Key? key}) : super(key: key);

  @override
  _AddSurveysPageState createState() => _AddSurveysPageState();
}

class _AddSurveysPageState extends State<AddSurveysPage> {
  TextEditingController question = TextEditingController();
  TextEditingController option1 = TextEditingController();
  TextEditingController option2 = TextEditingController();
  TextEditingController option3 = TextEditingController();
  TextEditingController option4 = TextEditingController();
  TextEditingController duration = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Survey"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    /// Form field for adding question
                    formWidget(question, label: "Question"),
                    formWidget(option1, label: "Option 1"),
                    formWidget(option2, label: "Option 2"),
                    formWidget(option3, label: "Option 3"),
                    formWidget(option4, label: "Option 4"),
                    formWidget(
                      duration,
                      label: "Duration",
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.utc(2027),
                        ).then((value) {
                          if (value == null) {
                            duration.clear();
                          } else {
                            duration.text = value.toString();
                          }
                        });
                      },
                    ),

                    /// Create button
                    Consumer<SurveyProvider>(
                      builder: (context, surveyProvider, child) {
                        WidgetsBinding.instance!.addPostFrameCallback((_) {
                          if (surveyProvider?.message != "") {
                            if (surveyProvider!.message.contains("Survey Created")) {
                              success(context, message: surveyProvider.message);
                              surveyProvider.clear();
                            } else {
                              error(context, message: surveyProvider.message);
                              surveyProvider.clear();
                            }
                          }
                        });
                        return GestureDetector(
                          /*onTap: surveyProvider.isLoading == true
                              ? null
                              : () {
                            if (_formKey.currentState!.validate()) {
                              List<Map<String, dynamic>> options = [
                                {"answer": option1.text.trim(), "percent": 0},
                                {"answer": option2.text.trim(), "percent": 0},
                                {"answer": option3.text.trim(), "percent": 0},
                                {"answer": option4.text.trim(), "percent": 0},
                              ];
                              surveyProvider.addSurvey(
                                question: question.text.trim(),
                                duration: duration.text.trim(),
                                options: options, isMandatory: true,
                              );
                            }*/
                          onTap: surveyProvider.status == true
                              ? null
                              : () {
                            if (_formKey.currentState!.validate()) {
                              List<Map<String, dynamic>> options = [
                                {
                                  "answer": option1.text.trim(),
                                  "percent": 0,
                                },
                                {
                                  "answer": option2.text.trim(),
                                  "percent": 0,
                                },
                                {
                                  "answer": option3.text.trim(),
                                  "percent": 0,
                                },
                                {
                                  "answer": option4.text.trim(),
                                  "percent": 0,
                                },
                              ];
                              surveyProvider.addSurvey(
                                  question: question.text.trim(),
                                  duration: duration.text.trim(),
                                  options: options,
                                  isMandatory: true
                              );
                            }

                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width - 100,
                            decoration: BoxDecoration(
                              color: surveyProvider.status == true
                                  ? Colors.grey
                                  : kAccentColor3,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                                surveyProvider.status == true
                                    ? "Please wait..."
                                    : "Post Survey"
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget formWidget(TextEditingController controller,
      {String? label, VoidCallback? onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        onTap: onTap,
        readOnly: onTap == null ? false : true,
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return "Input is required";
          }
          return null;
        },
        decoration: InputDecoration(
          errorBorder: const OutlineInputBorder(),
          labelText: label!,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
