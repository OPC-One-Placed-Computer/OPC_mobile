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
      onViewModelReady: (model) => model.init(),
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
                  viewModel.navigationService
                      .navigateTo(Routes.cancelled_message);
                });
              },
            )
          ],
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: viewModel.isBusy
            ? const Center(child: CircularProgressIndicator())
            : viewModel.getViewForIndex(viewModel.currentIndex),
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
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_sharp),
              label: 'My Purchase',
            ),
          ],
        ),
        drawer: Drawer(
          child: Container(
            color: const Color.fromARGB(255, 255, 255, 255),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    height: 162,
                    width: 304,
                    decoration: const BoxDecoration(
                      color: Color(0xFF13072E),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0.0),
                        topRight: Radius.circular(0.0),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 166,
                  left: -1,
                  child: Container(
                    height: 340,
                    width: 305,
                    decoration: const BoxDecoration(
                      color: Color(0xFF13072E),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16.0),
                        bottomRight: Radius.circular(16.0),
                      ),
                    ),
                  ),
                ),
                ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    const SizedBox(height: 70),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(0.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.white, width: 4.0),
                            ),
                            child: CircleAvatar(
                              radius: 80,
                              backgroundImage: viewModel.profileImage != null
                                  ? MemoryImage(viewModel.profileImage!)
                                  : null,
                              child: viewModel.profileImage == null
                                  ? const Icon(
                                      Icons.person,
                                      size: 110,
                                    )
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'My Profile',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Row(
                              children: [
                                const Icon(Icons.person,
                                    color: Colors.white, size: 20),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    viewModel.user != null
                                        ? '${viewModel.firstName} ${viewModel.lastName}'
                                        : '',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Row(
                              children: [
                                const Icon(Icons.email,
                                    color: Colors.white, size: 20),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    viewModel.user != null
                                        ? viewModel.email
                                        : '',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Row(
                              children: [
                                const Icon(Icons.location_on,
                                    color: Colors.white, size: 20),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    viewModel.address ?? '',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 35),
                      leading: const Icon(
                        Icons.logout,
                        color: Colors.white,
                        size: 20,
                      ),
                      title: Transform.translate(
                        offset: const Offset(-14, 0),
                        child: Text(
                          'Logout',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
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
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
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
                          viewModel.logout();
                        }
                      },
                    )
                  ],
                ),
                Positioned(
                  top: 180,
                  right: 16,
                  child: GestureDetector(
                    onTap: () {
                      viewModel.navigationService.navigateTo(Routes.profile);
                    },
                    child: const Icon(
                      Icons.edit,
                      color: Color.fromARGB(255, 255, 255, 255),
                      size: 24,
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
}
