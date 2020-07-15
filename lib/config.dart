import 'package:logger/logger.dart';
import 'package:normalpranzoapp/bloc/bloc.dart';

class Config {
  static Bloc bloc;
  static const String serverAddress = '72.52.142.19';
  static const String apiPrefix =
      'http://$serverAddress/foodapp-pranzo/api/web/v1';
  static const token = 'id0hbKqbNprWagfH774qjollWRYni-eK';

  static const String apiRestaurant =
      '$apiPrefix/restaurant/data?access-token=$token';
  static const String apiCustomerLogin =
      '$apiPrefix/customerLogin?access-token=$token';
  static const String apiCustomerSignUp =
      '$apiPrefix/customer/create?access-token=$token';
  static const String apiEvents = '$apiPrefix/event/data?access-token=$token';
  static const String apiPromotion =
      '$apiPrefix/promotion/data?access-token=$token';
  static const String apiPostOrder =
      '$apiPrefix/order/create?access-token=$token';
  static const String apiLogin =
      '$apiPrefix/customer/customerLogin?access-token=$token';
  static const String apiTableReservation =
      '$apiPrefix/reservation/create?access-token=$token';

  static const int connectionTimeout = 10; // seconds
  static const int splashTime = 3; // seconds

  static double deviceDisplayWidth;
  static double deviceDisplayHeight;

  static Logger log = new Logger(
      printer: PrettyPrinter(
          colors: true,
          errorMethodCount: 1,
          printEmojis: true,
          printTime: false,
          lineLength: 80,
          methodCount: 0));
}
