class ApiEndpoints{
  //prevents the instantiation of the ApiEndpoints class and is commonly used in Dart 
  //for defining classes that only contain static members 
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration recieveTimeout = Duration(seconds: 1000);

  //For Windows Base URL
  static const String baseUrl = 'http://10.0.2.2:5500/api/';
  // For MAC
  // static const String baseUrl = "http://localhost:5500/api/";


  static const String signUp = '/signUp';
  static const String signIn = '/signIn';
  static const String getJob = '/jobs/showallJobs';
  static const String searchJob = '/jobs';
  static const String userProfile = '/profile';
  static const String applyJobs = '/user/jobHistory';
  static const String getuserjobs = '/user/jobhistory';
  static const String bookmark = '/user/bookmark/';
  static const String bookmarkbyid = '/user/bookmark/:id';
  static const String booked = '/user/booked/:id';
  
}