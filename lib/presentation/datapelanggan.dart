import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DataPelangganPage extends StatelessWidget {
  const DataPelangganPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController namaController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController noHpController = TextEditingController();
    final TextEditingController alamatController = TextEditingController();
    final TextEditingController provinsiController = TextEditingController();
    final TextEditingController kodePosController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF7F4), // warna latar belakang soft
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF4516), // warna oranye
        title: Text(
          'Data Pelanggan',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildLabel('Nama Cust'),
            buildTextField(controller: namaController, hint: 'Nama Cust'),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLabel('Email'),
                      buildTextField(controller: emailController, hint: 'Email'),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLabel('No Hp'),
                      buildTextField(controller: noHpController, hint: 'No Hp'),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            buildLabel('Alamat'),
            buildTextField(controller: alamatController, hint: 'Alamat'),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLabel('Provinsi'),
                      buildTextField(controller: provinsiController, hint: 'Provinsi'),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLabel('Kode Pos'),
                      buildTextField(controller: kodePosController, hint: 'Kode Pos'),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                // Logika simpan data
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF4516),
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 5,
              ),
              child: Text(
                'Simpan',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),

            const SizedBox(height: 16),

            OutlinedButton(
              onPressed: () {
                // Logika reset field
                namaController.clear();
                emailController.clear();
                noHpController.clear();
                alamatController.clear();
                provinsiController.clear();
                kodePosController.clear();
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFFF4516)),
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Text(
                'Reset',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFFF4516),
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget buildTextField({required TextEditingController controller, required String hint}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.poppins(color: Colors.black45),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: Colors.black26),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: Color(0xFFFF4516)),
        ),
      ),
    );
  }
}
