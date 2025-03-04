class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);

  // for android virtual emulator
  // static const String baseUrl = "http://10.0.2.2:4000/api/v2/";

  // Phone as emulator must connect both phone and laptop in same network
  static const String baseUrl = "http://192.168.16.100:4000/api/v2/";

  // ============= Auth Routes =============
  static const String loginUser = "login";
  static const String createUser = "register";
  static const String getAllUsers = "auth/getAllUsers";
  static const String updateUser = "auth/updateUser";
  static const String deleteUser = "auth/deleteUser";
  static const String imageUrl = "http://10.0.2.2:3000/uploads/";
  static const String uploadImage = "auth/uploadImage";

  // ======== Products ============

  static const String createProduct = "product/createProduct";
  static const String getAllProduct = "products";
  static const String deleteProduct = "product/";

  // ======== order  =============
  static const String createOrder = "order/createOrder";
  static const String getAllOrder = "order/getAllOrder";
  static const String deleteOrder = "order/deleteOrder/";
  static const String getUserOrder = "orders/me";

  // Profile API Endpoints
  static const String updateProfile = "$baseUrl/me/update/profile";
  static const String updatePassword = "$baseUrl/me/update";
  static const String logout = "$baseUrl/logout";
  static const String getUserProfile = "$baseUrl/me";


}
