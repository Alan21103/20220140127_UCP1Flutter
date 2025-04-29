import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ucp_1/presentation/detailbarangpage.dart';

class PendataanBarangPage extends StatefulWidget {
  const PendataanBarangPage({super.key});

  @override
  State<PendataanBarangPage> createState() => _PendataanBarangPageState();
}

class _PendataanBarangPageState extends State<PendataanBarangPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tanggalController = TextEditingController();
  final TextEditingController _jumlahController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();

  String? _selectedJenisTransaksi;
  String? _selectedJenisBarang;
  bool _isLocaleInitialized = false;
  String? _tanggalError;

  List<Map<String, dynamic>> listBarang = [];

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID', null).then((_) {
      setState(() {
        _isLocaleInitialized = true;
      });
    });
  }

  @override
  void dispose() {
    _tanggalController.dispose();
    _jumlahController.dispose();
    _hargaController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showModalBottomSheet<DateTime>(
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: CalendarDatePicker(
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
            onDateChanged: (date) {
              Navigator.pop(context, date);
            },
          ),
        );
      },
    );

    if (picked != null) {
      setState(() {
        _tanggalController.text = DateFormat(
          'EEEE-dd-MM-yyyy',
          'id_ID',
        ).format(picked);
      });
    }
  }

  void tambahBarang() {
    if (_formKey.currentState!.validate() && _tanggalError == null) {
      final newBarang = {
        'tanggal': _tanggalController.text,
        'jenisTransaksi': _selectedJenisTransaksi,
        'jenisBarang': _selectedJenisBarang,
        'jumlah': _jumlahController.text,
        'harga': _hargaController.text,
      };

      setState(() {
        listBarang.add(newBarang);
        _tanggalController.clear();
        _jumlahController.clear();
        _hargaController.clear();
        _selectedJenisTransaksi = null;
        _selectedJenisBarang = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data barang berhasil ditambahkan!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
        ),
      );

      // Navigasi ke halaman detail setelah delay singkat
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailBarangPage(barang: newBarang),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLocaleInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pendataan Barang',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.purple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _tanggalController,
                    readOnly: true,
                    style: GoogleFonts.poppins(),
                    decoration: InputDecoration(
                      hintText: 'Tanggal Transaksi',
                      hintStyle: GoogleFonts.poppins(),
                      prefixIcon: const Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? 'Tanggal transaksi tidak boleh kosong'
                                : null,
                    onTap: () => _selectDate(context),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: _selectedJenisTransaksi,
                    items:
                        ['Barang Masuk', 'Barang Keluar']
                            .map(
                              (item) => DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item,
                                  style: GoogleFonts.poppins(fontSize: 14),
                                ),
                              ),
                            )
                            .toList(),
                    onChanged:
                        (val) => setState(() => _selectedJenisTransaksi = val),
                    decoration: InputDecoration(
                      hintText: 'Jenis Transaksi',
                      hintStyle: GoogleFonts.poppins(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator:
                        (value) =>
                            value == null
                                ? 'jenis transaksi tidak boleh kosong'
                                : null,
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: _selectedJenisBarang,
                    items:
                        ['Laptop', 'PC', 'Equipment', 'Lainnya']
                            .map(
                              (item) => DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item,
                                  style: GoogleFonts.poppins(fontSize: 14),
                                ),
                              ),
                            )
                            .toList(),
                    onChanged:
                        (val) => setState(() => _selectedJenisBarang = val),
                    decoration: InputDecoration(
                      hintText: 'Jenis Barang',
                      hintStyle: GoogleFonts.poppins(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator:
                        (value) =>
                            value == null
                                ? 'jenis barang tidak boleh kosong'
                                : null,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _jumlahController,
                          keyboardType: TextInputType.number,
                          style: GoogleFonts.poppins(),
                          decoration: InputDecoration(
                            hintText: 'Jumlah Barang',
                            hintStyle: GoogleFonts.poppins(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator:
                              (value) =>
                                  value!.isEmpty
                                      ? 'Masukkan jumlah barang'
                                      : null,
                        ),
                      ),
                      const SizedBox(width: 13),
                      Expanded(
                        child: TextFormField(
                          controller: _hargaController,
                          keyboardType: TextInputType.number,
                          style: GoogleFonts.poppins(),
                          decoration: InputDecoration(
                            prefixText: 'Rp. ',
                            hintText: 'Harga Satuan',
                            hintStyle: GoogleFonts.poppins(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator:
                              (value) =>
                                  value!.isEmpty
                                      ? 'Masukkan harga satuan'
                                      : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: tambahBarang,
                      child: Text(
                        'Submit',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
