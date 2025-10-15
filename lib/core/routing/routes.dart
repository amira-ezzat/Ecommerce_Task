// import 'package:flutter/material.dart';
// import 'package:hoshi_app/features/auth/presentation/pages/ForgetPassword/otp_code_screen.dart'
//     hide OtpVerificationScreen;
//
// import 'package:hoshi_app/features/navigation/Presentation/pages/offers_page/details_order/select_day_screen.dart';
//
// import '../../features/auth/presentation/pages/CreateNewPassword/create_new_password.dart';
// import '../../features/auth/presentation/pages/ForgetPassword/forget_password.dart';
// import '../../features/auth/presentation/pages/Login/login_screen.dart';
// import '../../features/auth/presentation/pages/Register/otp_verification_screen.dart';
// import '../../features/auth/presentation/pages/Register/register_screen.dart';
// import '../../features/home_layout/site_layout.dart';
//
// import '../../features/navigation/Presentation/pages/offers_page/details_order/cancel_order_screen.dart';
// import '../../features/navigation/Presentation/pages/offers_page/details_order/completed_screen.dart';
//
// import '../../features/onboarding_screens/presentaion/onboarding/on_boarding_view.dart';
// import '../../features/side_menu_pages/presentation/pages/contact_us_screen.dart';
// import '../../features/side_menu_pages/presentation/pages/how_app_work.dart';
// import '../../features/side_menu_pages/presentation/pages/my_rating_screen.dart';
// import '../../features/side_menu_pages/presentation/pages/support_customer.dart';
// import '../../features/side_menu_pages/presentation/pages/wallet_sreen.dart';
// import '../../features/splashscreen/account_type_screen.dart';
// import '../../features/worker_verification/presentation/pages/PhoneVerification/activation_account_Screen.dart';
// import '../../features/worker_verification/presentation/pages/PhoneVerification/otp_phone_code_screen.dart';
// import '../../features/worker_verification/presentation/pages/PhoneVerification/phone_verification_screen.dart';
// import '../../features/worker_verification/presentation/pages/setup_worker_profile/setup_worker_profile_screen.dart';
//
// class AppRouter {
//   static Route<dynamic> onGenerateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case '/home':
//         return MaterialPageRoute(builder: (_) => const SiteLayout());
//       case '/register':
//         return MaterialPageRoute(builder: (_) => const RegisterScreen());
//       case '/loginScreen':
//         return MaterialPageRoute(builder: (_) => const LoginScreen());
//       case '/forgetPasswordScreen':
//         return MaterialPageRoute(builder: (_) => const ForgetPassword());
//
//       case '/activationAccountScreen':
//         return MaterialPageRoute(
//           builder: (_) => const ActivationAccountScreen(),
//         );
//
//       case '/phoneVerificationScreen':
//         return MaterialPageRoute(
//           builder: (_) => const PhoneVerificationScreen(),
//         );
//       case '/OtpPhoneCodeScreen':
//         return MaterialPageRoute(builder: (_) => const OtpPhoneCodeScreen());
//       case '/setupWorkerScreen':
//         return MaterialPageRoute(
//           builder: (_) => const SetupWorkerProfileScreen(),
//         );
//
//       case '/activationAccountScreen':
//         return MaterialPageRoute(
//           builder: (_) => const ActivationAccountScreen(),
//         );
//
//       case '/phoneVerificationScreen':
//         return MaterialPageRoute(
//           builder: (_) => const PhoneVerificationScreen(),
//         );
//       case '/OtpPhoneCodeScreen':
//         return MaterialPageRoute(builder: (_) => const OtpPhoneCodeScreen());
//       case '/setupWorkerScreen':
//         return MaterialPageRoute(
//           builder: (_) => const SetupWorkerProfileScreen(),
//         );
//
//       case '/otpScreen':
//         return MaterialPageRoute(builder: (_) => const OtpVerificationScreen());
//
//       case '/otpCodeScreen':
//         return MaterialPageRoute(builder: (_) => const OtpCodeScreen());
//
//       case '/createNewPassword':
//         return MaterialPageRoute(builder: (_) => const CreateNewPassword());
//
//       case '/accountTypeScreen':
//         return MaterialPageRoute(builder: (_) => const AccountTypeScreen());
//       case '/onBoardingPageView':
//         return MaterialPageRoute(builder: (_) => const OnBoardingPageView());
//
//       /*  case '/editClientProfileScreen':
//         return MaterialPageRoute(
//           builder:
//               (context) => EditClientAccount(
//                 onBack: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//         );
//  */
//       /*       case '/EditWorkerAccount':
//         return MaterialPageRoute(builder: (_) => const EditWorkerAccount()); */
//
//       case '/contactUs':
//         return MaterialPageRoute(builder: (_) => const ContactUs());
//
//       case '/supportCustomer':
//         return MaterialPageRoute(builder: (_) => const SupportCustomer());
//
//       case '/myRatingScreen':
//         return MaterialPageRoute(builder: (_) => const MyRatingScreen());
//
//       case '/howAppWorkScreen':
//         return MaterialPageRoute(builder: (_) => const HowAppWork());
//       case '/selectDayScreen':
//         return MaterialPageRoute(builder: (_) => const SelectDayScreen());
//
//       case '/walletSrceen':
//         return MaterialPageRoute(builder: (_) => const WalletScreen());
//
//       case '/completedScreen':
//         return MaterialPageRoute(builder: (_) => const CompletedScreen());
//       case '/cancelOrderScreen':
//         return MaterialPageRoute(builder: (_) => const CancelOrderScreen());
//       case '/contactUs':
//         return MaterialPageRoute(builder: (_) => const ContactUs());
//       case '/howAppWorkScreen':
//         return MaterialPageRoute(builder: (_) => const HowAppWork());
//       case '/myRatingScreen':
//         return MaterialPageRoute(builder: (_) => const MyRatingScreen());
//       case '/supportCustomer':
//         return MaterialPageRoute(builder: (_) => const SupportCustomer());
//
//       default:
//         return MaterialPageRoute(
//           builder:
//               (_) =>
//                   const Scaffold(body: Center(child: Text("Page Not Found"))),
//         );
//     }
//   }
// }
