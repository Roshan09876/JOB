import 'dart:async';
import 'package:all_sensors2/all_sensors2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/config/constant/app_constants.dart';
import 'package:job_finder/config/constant/reusable_text.dart';
import 'package:job_finder/features/auth/presentation/view_model/auth_view_model.dart';

class ProfilePageView extends ConsumerStatefulWidget {
  const ProfilePageView({Key? key}) : super(key: key);

  @override
  _ProfilePageViewState createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends ConsumerState<ProfilePageView> {
  final List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  double _proximityValue = 0;

  @override
  void initState() {
    super.initState();

    _streamSubscriptions.add(
      proximityEvents!.listen((ProximityEvent event) {
        setState(() {
          _proximityValue = event.proximity;
        });

        // Check for a double tap on proximity
        if (_proximityValue == 0) {
          // Trigger logout when double-tapped
          _showLogoutConfirmation(context);
        }
      }),
    );
  }

  @override
  void dispose() {
    for (var subscription in _streamSubscriptions) {
      subscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var userState = ref.watch(authViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(kDark.value),
        title: Center(
          child: ReusableText(
            text: 'Profile',
            fontSize: 24,
            // fontWeight: FontWeight.bold,
            color: Color(kLight.value),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(kLight.value), Color(kLightGrey.value)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/user.jpeg'),
                ),
                SizedBox(height: 20),
                Text(
                  '${userState.currentUser.firstName} ${userState.currentUser.lastName}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(kDark.value),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Location: ${userState.currentUser.location}',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(kDark.value),
                  ),
                ),
                SizedBox(height: 20),
                _buildProfileInfoRow(
                  'Email',
                  "${userState.currentUser.email}",
                  Icons.email,
                ),
                SizedBox(height: 10),
                _buildProfileInfoRow(
                  'Phone',
                  "${userState.currentUser.phoneNum}",
                  Icons.phone,
                ),
                SizedBox(height: 10),
                _buildProfileInfoRow(
                  'Location',
                  '${userState.currentUser.location}',
                  Icons.location_on,
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(kOrange.value),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.all(16),
                    ),
                    onPressed: () {
                      ref.read(authViewModelProvider.notifier).logout(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Log Out',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.logout),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileInfoRow(String title, String info, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: Color(kDark.value),
          size: 30,
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(kDark.value),
              ),
            ),
            SizedBox(height: 4),
            Text(
              info,
              style: TextStyle(
                fontSize: 16,
                color: Color(kDark.value),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout Confirmation'),
          content: const Text('Do you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
