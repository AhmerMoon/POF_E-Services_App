import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pof_e_services/screens/change_password_screen.dart';
import 'package:pof_e_services/screens/cma_screen.dart';
import 'package:pof_e_services/screens/complaint_screen.dart';
import 'package:pof_e_services/screens/login_screen.dart';
import 'package:pof_e_services/services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('POF e-Services', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              await authService.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Logged out successfully.')),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg.png'), // Use your background image
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.2),
                  BlendMode.dstATop,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Welcome Text
                  Text(
                    'Welcome AHMER MOON MAJID',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(height: 20),
                  // Grid of services
                  GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    shrinkWrap: true,
                    physics:
                        NeverScrollableScrollPhysics(), // Important to prevent inner scrolling
                    children: [
                      _buildGridItem(
                        context: context,
                        iconPath: 'assets/station_engineer.png',
                        label: 'Station Engineer',
                        onTap:
                            () {}, // The onTap logic is now handled inside _buildGridItem
                      ),
                      _buildGridItem(
                        context: context,
                        iconPath: 'assets/telephone_internet.png',
                        label: 'Telephone Internet',
                        onTap: () {},
                      ),
                      _buildGridItem(
                        context: context,
                        iconPath: 'assets/water_supply.png',
                        label: 'Water Supply',
                        onTap: () {},
                      ),
                      _buildGridItem(
                        context: context,
                        iconPath: 'assets/cma.png',
                        label: 'CMA (POFs)',
                        onTap: () {},
                      ),
                      _buildGridItem(
                        context: context,
                        iconPath: 'assets/student_bus_pass.png',
                        label: 'Student Bus Pass',
                        onTap: () {},
                      ),
                      _buildGridItem(
                        context: context,
                        iconPath: 'assets/pof_merit_scholarship.png',
                        label: 'POF Merit Scholarship',
                        onTap: () {},
                      ),
                      _buildGridItem(
                        context: context,
                        iconPath: 'assets/electric_distribution.png',
                        label: 'Electric Distribution',
                        onTap: () {},
                      ),
                      _buildGridItem(
                        context: context,
                        iconPath: 'assets/change_password.png',
                        label: 'Change Password',
                        onTap: () {},
                      ),
                      _buildGridItem(
                        context: context,
                        iconPath: 'assets/gcc_training.png',
                        label: 'GCC Training',
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem({
    required BuildContext context,
    required String iconPath,
    required String label,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: () {
          // Use a conditional check to determine which screen to open.
          if (label == 'Station Engineer' ||
              label == 'Telephone Internet' ||
              label == 'Water Supply') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ComplaintScreen(title: label),
              ),
            );
          } else if (label == 'CMA (POFs)') {
            // This is the placeholder for the CMA screen, which you will create later.
            // You can add a print statement or a simple pop-up here for now.
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CmaScreen()),
            );
          } else if (label == 'Change Password') {
            // This is the placeholder for the CMA screen, which you will create later.
            // You can add a print statement or a simple pop-up here for now.
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
            );
          } else {
            // For all other widgets, do nothing.
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('This feature is not implemented yet.')),
            );
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconPath, height: 70, width: 70),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
