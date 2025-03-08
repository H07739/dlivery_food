import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Assure-toi que Get est importé
import 'package:my_project/Pages/auth/auth_view.dart';
import 'package:my_project/Pages/auth/login/loginView.dart';
import 'package:my_project/Pages/home/view/home_view.dart';





class RestaurantHomePage extends StatelessWidget {
  const RestaurantHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Arrière-plan fixe
          BackgroundImage(),

          // Contenu de la page
          Column(
            children: [
              // Logo en forme de cercle et positionné à gauche
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(20.0), // Espacement du logo à gauche
                  child: ClipOval(
                    child: Image.network(
                      'https://img.freepik.com/vecteurs-premium/belle-unique-conception-logo-pour-entreprise-alimentation-restauration_1317464-450.jpg?w=740',
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              // Espacement entre le logo et les boutons
              const Expanded(child: SizedBox()),

              // Deux boutons, positionnés en bas
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Action pour le bouton "Découverte"
                        Get.to(() => HomeView()); // Navigation vers Myapphomescreen
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Découverte',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Action pour le bouton "Connexion"
                        Get.to(() => AuthView()); // Navigation vers Loginview
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Connexion',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.network(
        'https://img.freepik.com/photos-gratuite/delicieux-burger-ingredients-frais_23-2150857908.jpg?t=st=1740692419~exp=1740696019~hmac=f261dc8f1dec9f3e2eb9226659763ca38350155ca9c0bea67cd1d726df1c47f1&w=740', // Exemple d'image d'arrière-plan
        fit: BoxFit.cover,
      ),
    );
  }
}
