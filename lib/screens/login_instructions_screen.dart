import 'package:flutter/material.dart';

class LoginInstructionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login Instructions',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.1),
                  BlendMode.dstATop,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  // Instructions list
                  Text(
                    '1. Go To \'Forget Password\' screen.',
                    style: TextStyle(fontSize: 20, color: Colors.black87),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '2. Enter your email address and click on \'Forget Password\' button. You will receive an OTP on your email.',
                    style: TextStyle(fontSize: 20, color: Colors.black87),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '3. Login with your OTP and set your new password.',
                    style: TextStyle(fontSize: 20, color: Colors.black87),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '4. If you have not updated your \'email address\', please update it in Personnel System from your concerned Admin/LB.',
                    style: TextStyle(fontSize: 20, color: Colors.black87),
                  ),
                  SizedBox(height: 30),
                  // Mock Video Player Placeholder
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[900],
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            Icons.play_circle_fill,
                            color: Colors.white,
                            size: 60,
                          ),
                          Positioned(
                            bottom: 10,
                            left: 10,
                            right: 10,
                            child: Row(
                              children: [
                                Icon(Icons.volume_up, color: Colors.white),
                                SizedBox(width: 8),
                                Expanded(
                                  child: LinearProgressIndicator(
                                    value: 0.2, // Mock progress
                                    backgroundColor: Colors.white54,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '0:16 / 1:24',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.fullscreen, color: Colors.white),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
