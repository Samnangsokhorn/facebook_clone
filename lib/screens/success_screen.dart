import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  String? image;
  List<String> allImage = [];
  final storageRef = FirebaseStorage.instance.ref();
  @override
  void initState() {
    // downloadImage().then((value) {
    //   setState(() {
    //     image = value;
    //   });
    // });
    super.initState();
    getAllImage();
  }

  Future<String> downloadImage() async {
    return await storageRef.child("images/drink1.png").getDownloadURL();
  }

  File? img;

  Future<void> pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    setState(() {
      img = File(image.path);
    });
  }

  uploadImage(File imageFile) async {
    final path = "images/${imageFile.path.split('/').last}";
    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(imageFile);
    print("Uploaded to Server");
  }

  deleteImage(File imageFile) async{
    final path = "images/${imageFile.path.split('/').last}";
    final ref = FirebaseStorage.instance.ref().child(path);
    await ref.delete();
    print('deleted image');
  }

  Future getAllImage() async{
    final ref = FirebaseStorage.instance.ref().child('/images/');
   final images = await ref.listAll();
   await Future.forEach(images.items, (Reference reference) async{
     final String url =  await reference.getDownloadURL();
     setState(() {
       allImage.add(url);
     });
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () {
                pickImage(ImageSource.camera);
              },
              child: const Icon(
                Icons.camera_alt_outlined,
              ),
            ),
          )
        ],
        // actions: [
        //   IconButton(onPressed: () {
        //     FirebaseAuth.instance.signOut().then((value) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginWithPhoneNum(),), (route) => false));
        //   }, icon: Icon(Icons.logout))
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: allImage.map((e) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Image.network(e),
            );
          }).toList(),
        ),
      ),
      // body: img != null ? Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Stack(
      //     children: [
      //       ClipRRect(
      //         borderRadius: BorderRadius.circular(20),
      //         child: Image.file(img!),
      //       ),
      //       Positioned(
      //         right: 0,
      //         child: Padding(
      //           padding: const EdgeInsets.only(right: 10,top: 5),
      //           child: CircleAvatar(
      //             backgroundColor: Colors.white,
      //             child: IconButton(
      //               onPressed: () {
      //                 deleteImage(img!);
      //               }, 
      //               icon: const Icon(
      //                 Icons.delete_outline_outlined,
      //                 color: Colors.red,
      //               )
      //               ),
      //           ),
      //         ),
      //       )
      //     ],
      //   ),
      // ) : const SizedBox(),
      // body: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: image != null
      //       ? ClipRRect(
      //           borderRadius: BorderRadius.circular(20),
      //           child: Image.network(
      //             '$image',
      //           ),
      //         )
      //       : const SizedBox(),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(img != null){
            uploadImage(img!);
          }else{
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("please select image")
              )
            );
          }
        },
        child: const Icon(Icons.upload_file_outlined),
      ),
    );
  }
}
