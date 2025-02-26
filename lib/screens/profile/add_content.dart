import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddContent extends StatefulWidget {
  const AddContent({super.key});

  @override
  State<AddContent> createState() => _AddContentState();
}

class _AddContentState extends State<AddContent> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  bool isUpload = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Content',
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

            // cont
            TextFormField(
              controller: _contentController,
              minLines: 10,
              maxLines: 20,
              decoration: const InputDecoration(
                hintText: 'Content',
                label: Text('Content'),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
              ),
              keyboardType: TextInputType.multiline,
              textCapitalization: TextCapitalization.sentences,
              validator: (value) => value!.isEmpty ? 'Enter content' : null,
            ),

            const SizedBox(height: 24),

            //
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: () async {
                  if (_globalKey.currentState!.validate()) {
                    String title = _titleController.text.trim();
                    String content = _contentController.text.trim();

                    //
                    setState(() => isUpload = true);

                    //
                    await uploadContent(content: content, title: title);

                    //todo: fcm
                    // FCMSender().sendPushMessage(
                    //   topic: 'blog',
                    //   title: title,
                    //   body: content.characters.take(150).toString(),
                    // );

                    //
                    setState(() => isUpload = false);
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

  //upload image
  uploadContent({required String content, required String title}) async {
    String uid = DateTime.now().millisecondsSinceEpoch.toString();
    // final creator = FirebaseAuth.instance.currentUser!.displayName;

    //
    await FirebaseFirestore.instance.collection('content').doc(uid).set({
      "title": title,
      "content": content,
      "creator": "",
    }).then(
      (value) {
        Fluttertoast.showToast(msg: 'Upload successfully');
        Navigator.pop(context);
      },
    );
  }
}
