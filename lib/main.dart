import 'package:flutter/material.dart';
import 'package:project/Providers/survey_fetch_provider.dart';
import 'package:project/Providers/survey_provider.dart';
import 'package:project/services/forgot_password_page.dart';
import 'package:project/services/login_or_register.dart';
import 'package:project/services/provider.dart';
import 'package:project/ui/auth/auth_page.dart';
import 'package:project/ui/auth/change_password.dart';
import 'package:project/ui/feedback/add_polls.dart';
import 'package:project/ui/feedback/polls.dart';
import 'package:project/ui/incident/report_incident.dart';
import 'package:project/ui/incident/report_incident_2.dart';
import 'package:project/ui/incident/report_incident_3.dart';
import 'package:project/ui/noticeboard/announcements.dart';
import 'package:project/ui/onboarding/onboarding_screens.dart';
import 'package:project/ui/profile/edit_profile_page.dart';
import 'package:project/ui/profile/filling_profile_details.dart';
import 'package:project/ui/gatepass/generate_qr.dart';
import 'package:project/ui/home/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project/ui/profile/profile_page.dart';
import 'package:project/ui/reservations/movie_booking/presentation/movie_booking_screen.dart';
import 'package:project/ui/reservations/reservation_selection_page.dart';
import 'package:project/ui/services/service_details_page.dart';
import 'package:project/ui/services/services_selection_page.dart';
import 'package:project/ui/settings/help_and_support_page.dart';
import 'package:project/ui/settings/settings_page.dart';
import 'package:project/ui/settings/terms_of_service_page.dart';
import 'package:project/ui/surveys/add_surveys.dart';
import 'package:project/ui/surveys/survey.dart';
import 'package:provider/provider.dart';
import 'Providers/polls_fetch_provider.dart';
import 'Providers/polls_provider.dart';
import 'Providers/service_provider.dart';
import 'chat/AllChat.dart';
import 'components/feedback_banner.dart';
import 'firebase_options.dart';
import 'ui/auth/login_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserData()),
        ChangeNotifierProvider(create: (context) => DbProvider()),
        ChangeNotifierProvider(create: (context) => FetchPollsProvider()),
        ChangeNotifierProvider(create: (context) => SurveyProvider()),
        ChangeNotifierProvider(create: (context) => FetchSurveysProvider()),
        ChangeNotifierProvider(create: (context) => ServiceProviderProvider()),
        // Add this line
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DbProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //theme: lightTheme,
        //darkTheme: darkTheme,
        home:  AuthPage(),
        routes: {
          '/login': (context) =>  LoginPage(onSignUpClicked: (){}),
          '/auth': (context) =>  AuthPage(),
          '/home': (context) => HomePage(),
          '/profile': (context) =>  ProfilePage(),
          '/registerOrLogin': (context) =>  LoginOrRegisterPage(),
          '/editProfile': (context) =>  EditProfilePage(),
          '/fillProfile': (context) =>  FillProfilePage(),
          '/settings': (context) =>  SettingsPage(),
          //'/changePassword': (context) =>  ChangePassword(),
          '/generateQR': (context) =>  GenerateGatepass(),

          //'/amenities': (context) =>  Reservation(),
          '/movie_booking': (context) =>  MovieBookingScreen(),
          '/amenities': (context) =>  ReservationSelectionPage(),

          '/feedback': (context) =>  FeedbackBanner(),
          '/polls': (context) =>  PollView(),

          ///Admin side
          '/addPoll': (context) =>  AddPollPage(),
          '/addSurvey': (context) =>  AddSurveysPage(),
          ///

          //'/survey': (context) =>  SurveyPage(),
          '/survey': (context) =>  Survey(),
          '/noticeboard': (context) =>  Announcement(),
          '/servicesSelection': (context) =>  ServicesSelectionPage(),
          '/serviceDetails': (context) =>  Services(),
          '/reportIncident': (context) =>  ReportIncident(),
          '/report_incident_2': (context) =>  ReportIncident2(),
          '/report_incident_3': (context) =>  ReportIncident3(),

          '/chat_page': (context) =>  MyChats(),
          '/helpAndSupport': (context) =>  HelpCentre(),
          '/terms': (context) => TermsOfService(),
          '/resetPassword': (context) => ForgotPasswordPage(),
        }
      ),
    );
  }
}

