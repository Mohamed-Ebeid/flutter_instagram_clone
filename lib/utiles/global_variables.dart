import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/screens/add_post_screen.dart';
import 'package:instagram_flutter/screens/home_screen.dart';
import 'package:instagram_flutter/screens/profile_screen.dart';
import 'package:instagram_flutter/screens/search_screen.dart';

const webScreenSize = 600;

List<Widget> bottomNavBarItems = [
  const HomeScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Center(child: Text('Favourite! coming soon...')),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
];
