import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController noHpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void _showSnackBar(BuildContext context, String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Center(
                child: Image.asset(
                  './assets/img/Contoh-Logo-Purple.jpg',
                  height: 170,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'DAFTAR AKUN BARU',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 30),
              // Nama
              _buildTextField(
                label: 'Nama Lengkap',
                controller: namaController,
                icon: Icons.person,
                validatorText: 'Nama lengkap tidak boleh kosong',
              ),
              const SizedBox(height: 25),
              // Email dan No HP
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      label: 'Email',
                      controller: emailController,
                      icon: Icons.email,
                      validatorText: 'Email tidak boleh kosong',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildTextField(
                      label: 'No HP',
                      controller: noHpController,
                      icon: Icons.phone,
                      validatorText: 'Nomor HP tidak boleh kosong',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              // Password dan Konfirmasi Password
              Row(
                children: [
                  Expanded(
                    child: _buildPasswordField(
                      label: 'Password',
                      controller: passwordController,
                      obscureText: _obscurePassword,
                      toggleObscure: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildPasswordField(
                      label: 'Konfirmasi Password',
                      controller: confirmPasswordController,
                      obscureText: _obscureConfirmPassword,
                      toggleObscure: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // Tombol Daftar
              Builder(
                builder: (context) => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              if (passwordController.text != confirmPasswordController.text) {
                                _showSnackBar(context, 'Password dan Konfirmasi Password tidak sama', Colors.red);
                                return;
                              }

                              setState(() {
                                _isLoading = true;
                              });

                              await Future.delayed(const Duration(seconds: 2));

                              setState(() {
                                _isLoading = false;
                              });

                              _showSnackBar(context, 'Registrasi Berhasil', Colors.green);

                              Navigator.pushReplacementNamed(context, '/login'); // Ganti halaman ke Login
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 92, 7, 111),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Daftar',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sudah memiliki akun? ',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text(
                      'Login disini!',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required String validatorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return validatorText;
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: label,
            prefixIcon: Icon(icon),
            filled: true,
            fillColor: Colors.purple.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.purple),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool obscureText,
    required VoidCallback toggleObscure,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '$label tidak boleh kosong';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: label,
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: toggleObscure,
            ),
            filled: true,
            fillColor: Colors.purple.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.purple),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
