part of'shared.dart';

Future<File> getImage() async{
  var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  return image;
}

Future<String> uploadImage(File file)async{
  String filename = basename(file.path);

  StorageReference ref = FirebaseStorage.instance.ref().child(filename);

  StorageUploadTask task = ref.putFile(file);
  StorageTaskSnapshot snapshot = await task.onComplete;

  return await snapshot.ref.getDownloadURL();
}