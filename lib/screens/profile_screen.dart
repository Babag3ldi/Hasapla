// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double Width = MediaQuery.of(context).size.width / 100;
    double Height = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: Width * 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 SizedBox(height: Height * 5),
                 const Text(
                  "Programma Barada",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: Height * 10),
                const Text(
                  "Hasapla türkmen ykjam elektron programasyna hoş geldiňiz! Siz bu programmada ýyllyk, aýlyk we günlik býujediňizi hasaplap bilersiňiz!",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF203A43),
                  ),
                ),
                SizedBox(height: Height * 5),
                const Text(
                  "Programmany taýýarlan:",
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: Height * 2),
                Row(
                  children: [
                    Container(
                        width: Width * 16,
                        height: Height * 8,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 40,
                          color: Color(0xFF203A43),
                        )),
                    const Text(
                      "   Ýomut Begmyradow ",
                      style: TextStyle(
                        fontSize: 24,
                        color: Color(0xFF203A43),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: Height * 2,
                ),
                const Text(
                  "Türkmenistanyn Oguz han adyndaky Inžener-tehnologiýalar uniwersitetiniň \n3-nji ýyl talyby",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: Height * 5,
                ),
                Row(
                  children: [
                    Container(
                        width: Width * 14,
                        height: Height * 7,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(Icons.phone_android,
                            size: 24, color: Color(0xFF203A43))),
                    const Text(
                      "   Wersiýasy   1.0.1 ",
                      style: TextStyle(fontSize: 20, color: Color(0xFF203A43)),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
