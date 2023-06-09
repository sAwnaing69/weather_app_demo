import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/network/api_client.dart';
import 'package:weather_app/network/noti_api_client.dart';
import 'package:weather_app/routes/api_routes.dart';
import 'package:weather_app/screens/all_user_sent_noti/noti_controller.dart';
import 'package:weather_app/screens/all_user_sent_noti/noti_repo.dart';
import 'package:weather_app/screens/home_screen/home_controller.dart';
import 'package:weather_app/screens/home_screen/home_repo.dart';
import 'package:weather_app/screens/search_screen/search_controller.dart';
import 'package:weather_app/screens/search_screen/search_repo.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences, fenix: true);

  //*For APi------------------------------------------------------------>
  Get.lazyPut(() =>
      ApiClient(appBaseUrl: ApiRoutes.baseUrl, sharedPreferences: Get.find()));
  Get.lazyPut(() => NotiApiClient(
      appBaseUrl: ApiRoutes.notiBaseUrl, sharedPreferences: Get.find()));
  //*For Repo---------------------------------------------------------->
  Get.lazyPut(() => HomeRepo(apiClient: Get.find<ApiClient>()), fenix: true);
  Get.lazyPut(() => SearchRepo(apiClient: Get.find<ApiClient>()), fenix: true);
  Get.lazyPut(() => NotiRepo(notiapiClient: Get.find<NotiApiClient>()),
      fenix: true);
  //*For Controller---------------------------------------------------->
  Get.lazyPut(() => HomeController(homeRepo: Get.find<HomeRepo>()),
      fenix: true);
  Get.lazyPut(
      () => SearchController(
          searchRepo: Get.find<SearchRepo>(),
          homeController: Get.find<HomeController>()),
      fenix: true);
  Get.lazyPut(
      () => NotiController(
          notiRepo: Get.find<NotiRepo>(),
          homeController: Get.find<HomeController>()),
      fenix: true);
}
