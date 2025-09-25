import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_final/components/bottom_app_bar.dart';
import 'package:flutter_project_final/components/custom_elevated_all.dart';
import 'package:flutter_project_final/db_functions/car_db_functions.dart';
import 'package:flutter_project_final/components/custom_drop_down.dart';
import 'package:flutter_project_final/models/brandmodel.dart';
import 'package:gap/gap.dart';
import 'package:flutter_project_final/models/carsmodel.dart';
import 'package:flutter_project_final/components/custom_text_field.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddCars extends StatefulWidget {
  const AddCars({Key? key}) : super(key: key);

  @override
  State<AddCars> createState() => _AddCarsState();
}

class _AddCarsState extends State<AddCars> {
  String? selectedBrand;
  File? pollutionCertImage;
  File? InsuranceCertImage;
  File? image25;
  String? seat;
  String? fuel;
  final formKey = GlobalKey<FormState>();
  final TextEditingController modelNameController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController insuranceDateController = TextEditingController();
  late List<String> brandNames = [];

  @override
  void initState() {
    super.initState();
    loadBrandNames();
  }

  Future<void> loadBrandNames() async {
    final brandBox = await Hive.openBox<BrandModel>('brands');
    brandNames = brandBox.values.map((brand) => brand.brandNames).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Color.fromARGB(255, 255, 253, 253),
          ),
        ),
        title: const Text(
          'Add Cars',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFF1E1E1E),
      bottomNavigationBar: buildCustomBottomAppBar(
        context: context,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            imagePickerWidget('Car', image25, (File? image) {
              setState(() {
                image25 = image;
              });
            }),
            const SizedBox(height: 50),
            Form(
              key: formKey,
              child: Column(
                children: [
                  //Brand
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField<String>(
                      value: selectedBrand,
                      items: buildBrandDropdownItems(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedBrand = newValue;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Select Brand',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      hint: Text(
                        "Select Brand",
                        style: TextStyle(color: Colors.white),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Brand is required';
                        }
                        return null;
                      },
                      style: TextStyle(color: Colors.white),
                      dropdownColor: Colors.black,
                      iconEnabledColor: Colors.white,
                    ),
                  ),
                  Gap(15),
                  //Model
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      hintText: 'Enter the model name',
                      labelText: 'Model',
                      controller: modelNameController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Model name is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  //Year
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      hintText: 'Enter the year',
                      labelText: 'Year',
                      controller: yearController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Year is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  //Insurance
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      hintText: 'Pick the Insurance date',
                      labelText: 'Insurance',
                      readOnly: true,
                      controller: insuranceDateController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Insurance date is required';
                        }
                        return null;
                      },
                      onTap: () {
                        insuranceDatePicker();
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  //Amount
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      hintText: 'Enter the Amount',
                      labelText: 'Amount',
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Amount is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  //Seat
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: customDropdownField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Seat is required';
                        }
                        return null;
                      },
                      labelText: 'Seat',
                      hintText: 'Seat',
                      value: seat,
                      items: ['2', '5', '7', '10'],
                      onChanged: (String? value) {
                        setState(() {
                          seat = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  //Fuel
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: customDropdownField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Fuel is required';
                        }
                        return null;
                      },
                      labelText: 'Fuel',
                      hintText: 'Fuel',
                      value: fuel,
                      items: ['Petrol', 'Diesel'],
                      onChanged: (String? value) {
                        setState(() {
                          fuel = value;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 20),
                  //Pollution
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        imagePickerWidget(
                            'Pollution Certificate', pollutionCertImage,
                            (File? image) {
                          setState(() {
                            pollutionCertImage = image;
                          });
                        }),

                        SizedBox(
                          width: 20,
                        ),
                        //Insurance
                        imagePickerWidget(
                            'Insurance Certificate', InsuranceCertImage,
                            (File? image) {
                          setState(() {
                            InsuranceCertImage = image;
                          });
                        }),
                      ],
                    ),
                  ),

                  // //Pollution
                  // imagePickerWidget('Pollution Certificate', pollutionCertImage,
                  //     (File? image) {
                  //   setState(() {
                  //     pollutionCertImage = image;
                  //   });
                  // }),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // //Insurance
                  // imagePickerWidget('Insurance Certificate', InsuranceCertImage,
                  //     (File? image) {
                  //   setState(() {
                  //     InsuranceCertImage = image;
                  //   });
                  // }),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Cancel button
                        CustomButtonAll(
                          backgroundColor: Colors.red.withOpacity(0.2),
                          textColor: Colors.redAccent,
                          label: 'Cancel',
                          icon: Icons.cancel_outlined,
                          onPressed: () {
                            image25 = null;

                            modelNameController.clear();
                            yearController.clear();
                            amountController.clear();
                            insuranceDateController.clear();
                            setState(() {
                              selectedBrand = null;
                              fuel = null;
                              seat = null;
                            });
                          },
                        ),
                        const SizedBox(width: 40),

                        //SAVE button
                        CustomButtonAll(
                          backgroundColor: Colors.green.withOpacity(0.2),
                          textColor: Colors.greenAccent,
                          label: ' Save ',
                          icon: Icons.save_outlined,
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              SaveCars();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imagePickerWidget(
      String label, File? image, Function(File?) onSelected) {
    return GestureDetector(
      onTap: () {
        getImage(ImageSource.gallery, onSelected);
      },
      child: Container(
        height: 200,
        width: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: image != null
                ? FileImage(image)
                : AssetImage('assets/Images/grey.jpg') as ImageProvider,
            fit: BoxFit.cover,
          ),
        ),
        child: image == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_a_photo_outlined,
                    color: Colors.yellow,
                    size: 40,
                  ),
                  Text(
                    label,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )
                ],
              )
            : SizedBox(),
      ),
    );
  }

  Future<void> getImage(ImageSource source, Function(File?) onSelected) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) {
      return;
    }
    onSelected(File(image.path));
  }

  Future<void> insuranceDatePicker() async {
    final pickedinsurance = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2099),
      initialDate: DateTime.now(),
    );
    if (pickedinsurance != null) {
      setState(() {
        insuranceDateController.text =
            DateFormat('dd / MM / yyyy').format(pickedinsurance);
      });
    }
  }

  void SaveCars() {
    final brand = selectedBrand!;
    final model = modelNameController.text.trim();
    final amount = amountController.text.trim();
    final year = yearController.text.trim();
    final insurance = insuranceDateController.text.trim();

    if (image25 == null ||
        pollutionCertImage == null ||
        InsuranceCertImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload an image.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (model.isEmpty ||
        selectedBrand == null ||
        fuel == null ||
        seat == null ||
        year.isEmpty ||
        amount.isEmpty ||
        insurance.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final newCar = CarsModel(
      selectedImage: image25 != null ? image25!.path : '',
      pollutionCertImage: pollutionCertImage!.path,
      InsuranceCertImage: InsuranceCertImage!.path,
      brand: brand,
      model: model,
      year: yearController.text,
      insurance: insuranceDateController.text,
      amount: amountController.text,
      seat: seat!,
      fuel: fuel!,
    );

    addCar(newCar);
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Car added successfully'),
        backgroundColor: Colors.green,
      ),
    );

    setState(() {
      image25 = null;
      fuel = null;
      seat = null;
      selectedBrand = null;
    });

    modelNameController.clear();
    yearController.clear();
    amountController.clear();
    insuranceDateController.clear();
  }

  List<DropdownMenuItem<String>> buildBrandDropdownItems() {
    if (brandNames.isEmpty) {
      return [
        DropdownMenuItem<String>(
          value: 'None',
          child: Text('None'),
        ),
      ];
    }

    return brandNames.map((String brand) {
      return DropdownMenuItem<String>(
        value: brand,
        child: Text(brand),
      );
    }).toList();
  }
}
