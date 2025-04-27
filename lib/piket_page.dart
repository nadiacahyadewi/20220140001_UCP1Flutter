import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ucp1/detailTugas_page.dart';

class PiketPage extends StatefulWidget {
  final String email;
  const PiketPage({Key? key, required this.email}) : super(key: key);

  @override
  State<PiketPage> createState() => _PiketPageState();
}

class _PiketPageState extends State<PiketPage> {
  late TextEditingController emailController;
  late TextEditingController tugasController;

  final _formKey = GlobalKey<FormState>();
  final List<Map<String, String>> taskList = [];
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: widget.email);
    tugasController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    tugasController.dispose();
    super.dispose();
  }

  void addTask() {
    if (!_formKey.currentState!.validate() || _selectedDate == null) {
      return;
    }

    setState(() {
      taskList.add({
        'nama': emailController.text,
        'tanggal': DateFormat(
          'EEEE, d MMMM yyyy',
          'id_ID',
        ).format(_selectedDate!),
        'tugas': tugasController.text,
      });
      tugasController.clear();
      _selectedDate = null;
    });
  }

  Future<void> pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Piket Gudang',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Nama Anggota',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: 'Nama Anggota',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Pilih Tanggal',
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
                          ? 'Pilih Tanggal'
                          : DateFormat(
                            'EEEE, d MMMM yyyy',
                            'id_ID',
                          ).format(_selectedDate!),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) {
                  if (_selectedDate == null) {
                    return 'Tanggal tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Tugas Piket',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: tugasController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: 'Tugas Piket',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tugas tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    height: 55,
                    width: 170,
                    child: FilledButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            _selectedDate != null) {
                          addTask();
                        }
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: const Text('Tambah'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Daftar Tugas Piket',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child:
                    taskList.isEmpty
                        ? const Center(child: Text('Belum ada Data'))
                        : ListView.builder(
                          itemCount: taskList.length,
                          itemBuilder: (context, index) {
                            final tugas = taskList[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                title: Text(
                                  tugas['tugas'] ?? '',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => DetailTugasPage(
                                            tugas: tugas['tugas'] ?? '',
                                            tanggal: tugas['tanggal'] ?? '',
                                            nama: tugas['nama'] ?? '',
                                          ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
