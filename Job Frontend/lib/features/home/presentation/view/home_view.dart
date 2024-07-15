import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:job_finder/config/constant/app_constants.dart';
import 'package:job_finder/features/home/presentation/view_model/home_view_model.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final homeState = ref.watch(homeStateListViewProvider);
    return Scaffold(
      body: homeState.lstWidget[homeState.index],
      bottomNavigationBar: Container(
        color: Color(kDark.value),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: GNav(
            backgroundColor: Color(kDark.value),
            color: Color(kLight.value),
            activeColor: Color(kLight.value),
            tabBackgroundColor: Color(kDark.value),
            gap: 2,
            tabs: [
              GButton(
                onPressed: () {},
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                onPressed: () {},
                icon: Icons.search,
                text: 'Search',
              ),
              GButton(
                onPressed: () {},
                icon: Icons.chat,
                text: 'Applied',
              ),
              GButton(
                onPressed: () {},
                icon: Icons.verified_user,
                text: 'Profile',
              ),
            ],
            onTabChange: (index) {
              ref.read(homeStateListViewProvider.notifier).changeIndex(index);
            },
          ),
        ),
      ),
    );
  }
}
