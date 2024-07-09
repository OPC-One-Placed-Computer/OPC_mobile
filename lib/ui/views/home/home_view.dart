import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opc_mobile_development/app/app.router.dart';
import 'package:stacked/stacked.dart';

import 'home_view_model.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    var listTile = ListTile(
      leading: const Icon(Icons.logout),
      title: Text(
        'Logout',
        style: GoogleFonts.poppins(),
      ),
      onTap: () async {
        bool shouldLogout = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Confirm Logout',
                style: GoogleFonts.poppins(),
              ),
              content: Text(
                'Are you sure you want to logout?',
                style: GoogleFonts.poppins(),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    'No',
                    style: GoogleFonts.poppins(),
                  ),
                ),
                TextButton(
                  onPressed: viewModel.logout,
                  child: Text(
                    'Yes',
                    style: GoogleFonts.poppins(),
                  ),
                ),
              ],
            );
          },
        );

        if (shouldLogout) {
          viewModel.navigationService.navigateTo(Routes.login);
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF13072E),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.shopping_cart_checkout,
              color: Colors.white,
            ),
            onPressed: () {
               viewModel.navigationService.navigateTo(Routes.order_placed);
            },
          )
        ],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: viewModel.getViewForIndex(viewModel.currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: viewModel.currentIndex,
        onTap: viewModel.setIndex,
        backgroundColor: const Color(0xFF13072E),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 19, 7, 46),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/placeholder.png'),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'User Name',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(
                'Settings',
                style: GoogleFonts.poppins(),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: Text(
                'Help & Feedback',
                style: GoogleFonts.poppins(),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            listTile,
          ],
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    viewModel.init();
    super.onViewModelReady(viewModel);
  }
}
