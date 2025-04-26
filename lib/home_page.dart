import 'package:flutter/material.dart';
import 'package:ucp1/login_page.dart';

class HomePage extends StatelessWidget {
  final String email;
  const HomePage({
    super.key,
    required this.email});

  @override
  Widget build(BuildContext context) {
        return Scaffold(
      backgroundColor: Colors.white, 
      body: Column(
        children: [
          Container(
            color: Colors.green,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: SafeArea(
              bottom: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                crossAxisAlignment: CrossAxisAlignment.center, 
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/images/profil.png'),
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          Text(
                            'Selamat Datang',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Text(
                            '$email',
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          // Konten lainnya di sini
        ],
      ),
    );
  }
}