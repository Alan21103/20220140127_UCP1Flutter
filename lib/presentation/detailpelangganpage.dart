import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPelangganPage extends StatelessWidget {
  final String nama;
  final String email;
  final String noHp;
  final String alamat;
  final String provinsi;
  final String kodePos;

  const DetailPelangganPage({
    super.key,
    required this.nama,
    required this.email,
    required this.noHp,
    required this.alamat,
    required this.provinsi,
    required this.kodePos,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7F4),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 148, 17, 171),
        title: Text(
          'Detail $nama',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: const AssetImage('assets/img/6858504.png'), // atau gunakan NetworkImage
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                nama,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    email,
                    style: GoogleFonts.poppins(),
                  ),
                  Text(
                    noHp,
                    style: GoogleFonts.poppins(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Alamat
            _buildTextField(label: "Alamat", value: alamat),

            // Row: Provinsi & Kode Pos
            Row(
              children: [
                Expanded(
                  child: _buildTextField(label: "Provinsi", value: provinsi),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildTextField(label: "Kode Pos", value: kodePos),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Tombol Selesai
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 148, 17, 171),
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Text(
                'Selesai',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          initialValue: value,
          readOnly: true,
          style: GoogleFonts.poppins(fontSize: 14),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.black12),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.black12),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
