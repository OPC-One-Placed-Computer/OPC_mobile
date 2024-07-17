import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opc_mobile_development/app/app.router.dart';
import 'package:stacked/stacked.dart';

import 'home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.laptop, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                'One Place Computer',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFF13072E),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.shopping_cart_checkout,
                color: Colors.white,
              ),
              onPressed: () {
                viewModel.checkAuthenticationAndNavigate(() {
                  viewModel.navigationService.navigateTo(Routes.order_placed);
                });
              },
            )
          ],
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: viewModel.getViewForIndex(viewModel.currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: viewModel.currentIndex,
          onTap: (index) {
            viewModel.checkAuthenticationAndNavigate(() {
              viewModel.setIndex(index);
            });
          },
          backgroundColor: const Color(0xFF13072E),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
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
              ListTile(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
