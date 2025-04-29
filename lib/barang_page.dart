import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ucp1/detailBarang_page.dart';

class BarangPage extends StatefulWidget {
  const BarangPage({super.key});

  @override
  State<BarangPage> createState() => _BarangPageState();
}

class _BarangPageState extends State<BarangPage> {
  final _formKey = GlobalKey<FormState>();

  DateTime? _selectedDate;
  String? _selectedJenisTransaksi;
  String? _selectedJenisBarang;
  final TextEditingController _jumlahBarangController = TextEditingController();
  final TextEditingController _hargaSatuanController = TextEditingController();

  final List<String> _jenisTransaksiOptions = ['Barang Masuk', 'Barang Keluar'];
  final List<String> _jenisBarangOptions = [
    'Carrier',
    'Sleeping Bag',
    'Tenda',
    'Sepatu',
  ];

  final Map<String, int> _hargaBarang = {
    'Carrier': 540000,
    'Sleeping Bag': 250000,
    'Tenda': 700000,
    'Sepatu': 350000,
  };

  Future<void> pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: const Locale('id', 'ID'),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _onJenisBarangChanged(String? value) {
    setState(() {
      _selectedJenisBarang = value;
      if (value != null) {
        _hargaSatuanController.text = _hargaBarang[value]!.toString();
      }
    });
  }


  @override
  void dispose() {
    _jumlahBarangController.dispose();
    _hargaSatuanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Pendataan Barang',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Tanggal Transaksi',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  readOnly: true,
                  onTap: pickDate,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.date_range_outlined),
                    hintText:
                        _selectedDate == null
                            ? 'Tanggal Transaksi'
                            : DateFormat(
                              'EEEE, d MMMM yyyy',
                              'id_ID',
                            ).format(_selectedDate!),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (_) {
                    if (_selectedDate == null) {
                      return 'Tanggal tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Jenis Transaksi',
                  ),
                  items:
                      _jenisTransaksiOptions
                          .map(
                            (jenis) => DropdownMenuItem(
                              value: jenis,
                              child: Text(jenis),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedJenisTransaksi = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Pilih jenis transaksi';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Jenis Barang',
                  ),
                  items:
                      _jenisBarangOptions
                          .map(
                            (barang) => DropdownMenuItem(
                              value: barang,
                              child: Text(barang),
                            ),
                          )
                          .toList(),
                  onChanged: _onJenisBarangChanged,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Pilih jenis barang';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Jumlah Barang',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _jumlahBarangController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Jumlah Barang',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Jumlah barang tidak boleh kosong';
                              }
                              if (int.tryParse(value) == null) {
                                return 'Jumlah barang harus angka';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Harga Satuan',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _hargaSatuanController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixIcon: const Padding(
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  'Rp.',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              hintText: 'Harga Satuan',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Harga satuan tidak boleh kosong';
                              }
                              if (int.tryParse(value) == null) {
                                return 'Harga satuan harus angka';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 100),
                SizedBox(
                  width: 1000,
                  height: 56,
                  child: FilledButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        int jumlahBarang = int.parse(
                          _jumlahBarangController.text,
                        );
                        int hargaSatuan = int.parse(
                          _hargaSatuanController.text,
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => DetailbarangPage(
                                  tanggal: _selectedDate!,
                                  jenisTransaksi: _selectedJenisTransaksi!,
                                  jenisBarang: _selectedJenisBarang!,
                                  jumlahBarang: jumlahBarang,
                                  hargaSatuan: hargaSatuan,
                                ),
                          ),
                        );
                      }
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text('Simpan'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
