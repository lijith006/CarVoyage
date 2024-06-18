import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project_final/components/appbar.dart';
import 'package:flutter_project_final/components/custom_elevated_all.dart';
import 'package:flutter_project_final/models/brandmodel.dart';
import 'package:flutter_project_final/screens/home_screen.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';

class BrandPage extends StatefulWidget {
  const BrandPage({super.key});

  @override
  State<BrandPage> createState() => _BrandPageState();
}

class _BrandPageState extends State<BrandPage> {
  File? brandLogoImage;
  final TextEditingController BrandNameDropdownController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Add Brands',
      ),
      backgroundColor: const Color(0xFF1E1E1E),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        color: Colors.black45,
        shape: const CircularNotchedRectangle(),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              child: Container(
                  height: 28,
                  width: 28,
                  child: Image.asset(
                    'lib/icons/house.png',
                    color: Color.fromARGB(255, 147, 247, 150),
                  )),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: pickBrandLogoImage,
              child: Center(
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      brandLogoImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                brandLogoImage!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            )
                          : Center(
                              child: Text('Tap to select brand logo image'),
                            ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Icon(
                          Icons.add_a_photo_outlined,
                          color: Color.fromARGB(255, 228, 228, 36),
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: BrandNameDropdownController,
              decoration: InputDecoration(
                labelText: 'Brand Name',
                labelStyle: TextStyle(color: Colors.grey),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            Center(
              child: CustomButtonAll(
                label: 'Save Brand',
                onPressed: saveBrand,
              ),
            )
          ],
        ),
      ),
    );
  }

  void pickBrandLogoImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        brandLogoImage = File(pickedImage.path);
      });
    }
  }

  void saveBrand() async {
    if (BrandNameDropdownController.text.isNotEmpty && brandLogoImage != null) {
      final brandName = BrandNameDropdownController.text.trim();
      final brandLogoImagePath = brandLogoImage!.path;
      final brandBox = await Hive.openBox<BrandModel>('brands');
      final newBrand = BrandModel(
          brandNames: brandName, brandLogoImagePath: brandLogoImagePath);
      brandBox.add(newBrand);
      print(brandBox);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            'Brand name and Logo added',
          ),
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Please enter brand name and select logo image.'),
        ),
      );
    }
  }
}
