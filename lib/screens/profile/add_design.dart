import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AddDesign extends StatefulWidget {
  const AddDesign({super.key});

  @override
  State<AddDesign> createState() => _AddDesignState();
}

class _AddDesignState extends State<AddDesign> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();

  File? _pickedMobileImage;
  Uint8List webImage = Uint8List(8);
  bool isUpload = false;

  @override
  void dispose() {
    _titleController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Design',
          style: TextStyle(color: Colors.black),
        ),
      ),

      //
      body: Form(
        key: _globalKey,
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: size.width > 1000 ? size.width * .2 : 16,
            vertical: 16,
          ),
          children: [
            // title
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Title',
                label: Text('Title'),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
              ),
              keyboardType: TextInputType.text,
              validator: (value) => value!.isEmpty ? 'Enter title' : null,
            ),

            const SizedBox(height: 16),

            // link
            TextFormField(
              controller: _linkController,
              minLines: 1,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Link',
                label: Text('Link'),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
              ),
              keyboardType: TextInputType.url,
              // validator: (value) => value!.isEmpty ? 'Enter link' : null,
            ),

            const SizedBox(height: 16),

            //
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                //
                _pickedMobileImage == null
                    ? Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.grey.shade300,
                        alignment: Alignment.center,
                        child: const Text('No image selected'),
                      )
                    : SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: kIsWeb
                            ? Image.memory(
                                webImage,
                                fit: BoxFit.fitHeight,
                              )
                            : Image.file(
                                _pickedMobileImage!,
                                fit: BoxFit.fitHeight,
                              ),
                      ),

                //
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: FloatingActionButton(
                    onPressed: () async {
                      addImage();
                    },
                    child: const Icon(Icons.add),
                  ),
                )
              ],
            ),

            const SizedBox(height: 24),

            //
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: () async {
                  if (_globalKey.currentState!.validate()) {
                    if (_pickedMobileImage == null) {
                      Fluttertoast.cancel();
                      Fluttertoast.showToast(msg: 'No image selected');
                    } else {
                      String title = _titleController.text.trim();
                      String link = _linkController.text.trim();

                      //
                      setState(() => isUpload = true);

                      //
                      await uploadImage(link: link, title: title);

                      //todo: fcm
                      // FCMSender().sendPushMessage(
                      //   topic: 'blog',
                      //   title: title,
                      //   body: content.characters.take(150).toString(),
                      // );

                      //
                      setState(() => isUpload = false);
                    }
                  }
                },
                child: isUpload
                    ? const CircularProgressIndicator(color: Colors.red)
                    : const Text('Add Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //add image
  addImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (!kIsWeb) {
      if (image != null) {
        var selectedMobileImage = File(image.path);
        setState(() {
          _pickedMobileImage = selectedMobileImage;
        });
      }
    } else if (kIsWeb) {
      if (image != null) {
        var selectedWebImage = await image.readAsBytes();
        setState(() {
          webImage = selectedWebImage;
          _pickedMobileImage = File('');
        });
      }
    }
  }

  //upload image
  uploadImage({required String link, required String title}) async {
    String uid = DateTime.now().millisecondsSinceEpoch.toString();

    //
    var ref = FirebaseStorage.instance.ref('design').child('$uid.jpg');
    var imageUrl = '';

    //
    if (kIsWeb) {
      await ref.putData(webImage);
      imageUrl = await ref.getDownloadURL();
    } else {
      await ref.putFile(_pickedMobileImage!);
      imageUrl = await ref.getDownloadURL();
    }

    // BlogModel blog = BlogModel(
    //   // blogId: uid,
    //   title: title,
    //   content: content,
    //   date: Timestamp.fromDate(DateTime.now()),
    //   image: imageUrl,
    // );

    //
    await FirebaseFirestore.instance.collection('design').doc(uid).set({
      "uid": uid,
      "title": title,
      "link": link,
      "image": imageUrl,
    }).then(
      (value) {
        Fluttertoast.showToast(msg: 'Upload successfully');
        Navigator.pop(context);
      },
    );
  }
}
