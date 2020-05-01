part of 'services.dart';

class UserServices {
  static CollectionReference _userCollection =
      Firestore.instance.collection("users");
  static Future<void> updateUser(User user) async {
    String genres = "";
    for (var genre in user.selectedGenres) {
      genres += genre + ((genre != user.selectedGenres.last) ? ',' : '');
    }
    _userCollection.document(user.id).setData({
      'email': user.email,
      'name': user.name,
      'balance': user.balance,
      'selectedGenres': genres,
      'selectedLanguage': user.selectedLanguage,
      'profilePicture': user.profilePicture ?? ''
    });
  }

  static Future<User> getUser(String id) async {
    DocumentSnapshot snapshot = await _userCollection.document(id).get();
    
    List<String> genres =  (snapshot.data['selectedGenres'] as String).split(',');
    return User(
      id,
      snapshot.data['email'],
      name: snapshot.data['name'],
      profilePicture: snapshot.data['profilePicture'],
      selectedGenres: genres,
      selectedLanguage: snapshot.data['selectedLanguage'],
      balance: snapshot.data['balance']
    );
  }
}
