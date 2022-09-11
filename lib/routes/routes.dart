import 'package:get/route_manager.dart';
import 'package:meow/binding/upload_binding.dart';
import 'package:meow/screen/advertisement/view/advertisement_screen.dart';
import 'package:meow/screen/cart.dart';
import 'package:meow/screen/check_out_screen.dart';
import 'package:meow/screen/detail_screen.dart';
import 'package:meow/screen/home_screen.dart';
import 'package:meow/screen/item_upload_screen.dart';
import 'package:meow/screen/manage_item.dart';
import 'package:meow/screen/product_category/view/product_category_view.dart';
import 'package:meow/screen/search_screen.dart';
import 'package:meow/screen/status/status_screen.dart';
import 'package:meow/screen/tags/tags_screen.dart';
import 'package:meow/screen/user_order_view.dart';
import 'package:meow/screen/view/favourite.dart';
import 'package:meow/screen/view_all/view/view_all.dart';

import '../intro_screen.dart';
import '../screen/promotion/view/promotion_view.dart';

const String introScreen = '/intro-screen';
const String homeScreen = '/home';
const String checkOutScreen = '/checkout';
const String detailScreen = '/detail';
const String uploadItemScreen = '/uploadItemScreen';
const String mangeItemScreen = '/manage-item';
const String purchaseScreen = '/purchase-screen';
const String blueToothScreen = '/bluetooth-screen';
const String searchScreen = '/searchScreen';
const String advertisementUrl = '/advertisement';
const String categoriesUrl = '/categories';
const String statusUrl = '/status';
const String tagsUrl = '/tags';
const String viewAllUrl = '/view_all';
const String cartUrl = '/cart_url';
const String favouriteUrl = '/favourite';
const String promotionUrl = '/promotions';

List<GetPage> routes = [
  GetPage(
    name: introScreen,
    page: () => OnBoardingPage(),
  ),
  GetPage(
    name: homeScreen,
    page: () => HomeScreen(),
  ),
  GetPage(
    name: checkOutScreen,
    page: () => CheckOutScreen(),
  ),
  GetPage(
    name: detailScreen,
    page: () => DetailScreen(),
  ),
  GetPage(
    name: uploadItemScreen,
    page: () => UploadItem(),
    binding: UploadBinding(),
  ),
  GetPage(
    name: purchaseScreen,
    page: () => UserOrderView(),
  ),
  GetPage(
    name: searchScreen,
    page: () => SearchScreen(),
  ),
  GetPage(
    name: advertisementUrl,
    page: () => AdvertisementScreen(),
  ),
  GetPage(
    name: statusUrl,
    page: () => StatusScreen(),
  ),
  GetPage(
    name: categoriesUrl,
    page: () => ProductCategoryView(),
  ),
  GetPage(
    name: promotionUrl,
    page: () => PromotionView(),
  ),
  GetPage(
    name: tagsUrl,
    page: () => TagsScreen(),
  ),
  GetPage(
    name: viewAllUrl,
    page: () => ViewAllScreen(),
  ),
  GetPage(
    name: cartUrl,
    page: () => CartView(),
  ),
  GetPage(
    name: mangeItemScreen,
    page: () => ManageItem(),
  ),
  GetPage(
    name: favouriteUrl,
    page: () => FavouriteView(),
  ),
];
