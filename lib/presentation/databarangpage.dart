import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:google_fonts/google_fonts.dart';

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
        _tanggalController.text = DateFormat('dd-MM-yyyy', 'id_ID').format(picked);
      });
    }
  }

  void tambahBarang() {
    setState(() {
      _tanggalError = _tanggalController.text.isEmpty ? 'Harap pilih tanggal transaksi' : null;
    });

    if (_formKey.currentState!.validate() && _tanggalError == null) {
      setState(() {
        listBarang.add({
          'tanggal': _tanggalController.text,
          'jenisTransaksi': _selectedJenisTransaksi,
          'jenisBarang': _selectedJenisBarang,
          'jumlah': _jumlahController.text,
          'harga': _hargaController.text,
        });
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
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}