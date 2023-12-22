import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserDetail(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .set(userInfoMap);
  }

  updateUserWallet(String id, String amount) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .update({"Wallet": amount});
  }

  Future addFoodItem(Map<String, dynamic> userInfoMap, String name) async {
    return await FirebaseFirestore.instance.collection(name).add(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getFoodItem(String name) async {
    return FirebaseFirestore.instance.collection(name).snapshots();
  }

  Future addFoodToCart(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection("Cart")
        .add(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getFoodCart(String id) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Cart")
        .snapshots();
  }

  Future<void> removeCartItem(String userId, String cartItemId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('Cart')
          .doc(cartItemId)
          .delete();
    } catch (e) {
      // ignore: avoid_print
      print("Error removing cart item: $e");
      // Handle errors or exceptions
    }
  }

  Future<void> removeAllCartItems(String userId) async {
    try {
      QuerySnapshot cartItems = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('Cart')
          .get();

      for (DocumentSnapshot cartItem in cartItems.docs) {
        await cartItem.reference.delete();
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error removing cart items: $e");
      // Handle errors or exceptions
    }
  }
}
