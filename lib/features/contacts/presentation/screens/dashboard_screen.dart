import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:houzeo/core/common/widgets/common_textfield.dart';
import 'package:houzeo/core/theme/app_color.dart';
import 'package:houzeo/core/utils/database_utils.dart';
import 'package:houzeo/features/contacts/data/datasource/contact_local_data_source.dart';
import 'package:houzeo/features/contacts/data/repositories/contact_repository_impl.dart';
import 'package:houzeo/features/contacts/domain/usecase/get_all_contacts.dart';
import 'package:houzeo/features/contacts/presentation/cubit/contact_crud_cubit.dart';
import 'package:houzeo/features/contacts/presentation/screens/contact_search_screen.dart';
import 'package:houzeo/features/contacts/presentation/screens/favourite_screen.dart';
import 'package:houzeo/features/contacts/presentation/screens/contact_screen.dart';
import 'package:sqflite/sqflite.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Widget> _screens= [ContactScreen(),FavouriteScreen()];
  int _currentIndex=0;
  late final Database db;

  @override
  Widget build(BuildContext context) {
    final theme= Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: InkWell(
                onTap: ()=>
                    Navigator.push(context, MaterialPageRoute(builder: (builder)=>ContactSearchScreen())),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15.h,horizontal: 15.w),
                  decoration: BoxDecoration(
                    color: theme.textTheme.titleSmall?.color?.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10.r)
                  ),
                  child: Row(
                    spacing: 10.w,
                    children: [
                      Icon(Icons.search),
                      Text('Search',
                        style: theme.textTheme.bodySmall,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: IndexedStack(
                index: _currentIndex,
                children: _screens,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (currentIndex){
          setState(() {
            _currentIndex= currentIndex;
          });
        },
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favourite'
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    DatabaseUtils().closeDB();
    super.dispose();
  }
}
