import 'package:job_finder/features/auth/presentation/view/login_view.dart';
import 'package:job_finder/features/auth/presentation/view/profile_page_view.dart';
import 'package:job_finder/features/auth/presentation/view/register_view.dart';
import 'package:job_finder/chat_view.dart';
import 'package:job_finder/features/bookmarks/presentation/view/bookmarks_page.dart';
import 'package:job_finder/features/home/main_screen_view.dart';
import 'package:job_finder/features/home/presentation/view/home_view.dart';
import 'package:job_finder/features/pagination/presentation/view/jobs_view_detail.dart';
import 'package:job_finder/features/search/presentation/view/search_show.dart';
import 'package:job_finder/features/view/ui/screens/first_page.dart';
import 'package:job_finder/features/splash/splash_screen.dart';

class AppRoute {
  //Private Constructor
  AppRoute._();

  static const String splashscreenRoute = '/splashscreenRoute';
  static const String firstpageRoute = '/firstpageRoute';
  static const String loginviewRoute = '/loginviewRoute';
  static const String registerviewRoute = '/registerviewRoute';
  static const String homeViewRoute = '/homeViewRoute';
  static const String mainscreenRoute = '/mainscreenRoute';
  static const String chatviewRoute = '/chatviewRoute';
  static const String profileviewRoute = '/profileviewRoute';
  static const String jobsviewDetail = '/jobsviewDetail';
  static const String bookmarkView = '/bookmarkView';
  // static const String searchShowScreen = '/searchShowScreen';

  static getApplicationRoute() {
    return {
      splashscreenRoute: (context) => SplashScreen(),
      firstpageRoute: (context) => FirstPage(),
      loginviewRoute: (context) => LoginView(),
      registerviewRoute: (context) => RegisterView(),
      homeViewRoute: (context) => HomeView(),
      mainscreenRoute: (context) => MainScreenView(),
      chatviewRoute: (context) => ChatView(),
      jobsviewDetail: (context) => JobsViewDetail(),
      profileviewRoute: (context) => ProfilePageView(),
      bookmarkView: (context) => BookMarksPage(),
      // searchShowScreen: (context) => SearchShowScreen(),
    };
  }
}
