import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ucp_1/presentation/datapiketpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7F4),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
             backgroundColor: const Color.fromARGB(255, 134, 11, 156),
          elevation: 0,
          flexibleSpace: SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Profile Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(28),
                        child: Image.network(
                          'https://storage.googleapis.com/a1aa/image/a156d4c1-ab9e-437b-847a-8846cf22d52a.jpg',
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Texts
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Selamat Datang',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Admin',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      // Logout Icon
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        icon: const Icon(
                          Icons.logout,
                          color: Colors.white,
                          size: 28,
                        ),
                        tooltip: 'Logout',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Banner Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              './assets/img/6364_1900.jpg',
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
              semanticLabel: 'Food tray with burger, pizza slice, taco, fries, and drinks on a red background with text "Dapatkan Diskon 25% disetiap harinya" and a green button labeled "Order now"',
            ),
          ),
          const SizedBox(height: 32),
          // Top two buttons
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DataPiketPage(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 134, 11, 156),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.sync_alt,
                          color: Colors.white,
                          size: 32,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Data Piket',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Add navigation to DataPelangganPage if available
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 134, 11, 156),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.grid_view,
                          color: Colors.white,
                          size: 32,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Data Pelanggan',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Bottom full width button
          GestureDetector(
            onTap: () {
              // Add combined functionality or navigation
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 134, 11, 156),
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.symmetric(vertical: 56),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.receipt_long,
                    color: Colors.white,
                    size: 32,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Barang Masuk/Keluar',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
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