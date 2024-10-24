import 'package:example/screens.dart';
import 'package:feature_navigator/feature_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final FeatureRouter _featureRouter = FeatureRouter(
    apiKey: 'your-api-key',
    goRouter: GoRouter(
      initialLocation: '/account_management',
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) =>
              const HomeScreen(), // Replace with your home screen widget
        ),
        StatefulShellRoute.indexedStack(
          builder: (BuildContext context, GoRouterState state,
              StatefulNavigationShell navigationShell) {
            return Scaffold(
              body: navigationShell,
              bottomNavigationBar: BottomNavigationBar(
                showUnselectedLabels: true,
                selectedItemColor: const Color.fromARGB(255, 93, 144, 95),
                unselectedItemColor: Colors.black,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    backgroundColor: Color(0xffeeeeee),
                    icon: Icon(Icons.person),
                    label: 'Account Management',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.credit_card),
                    label: 'Cards',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shield),
                    label: 'Insurance',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.support_agent),
                    label: 'Customer Service',
                  ),
                ],
                currentIndex: navigationShell.currentIndex,
                onTap: (int index) {
                  navigationShell.goBranch(index);
                },
              ),
            );
          },
          branches: <StatefulShellBranch>[
            StatefulShellBranch(
              routes: <RouteBase>[
                FeatureRoute(
                  path: '/account_management',
                  name: 'AccountManagement',
                  description: 'Manage your account details and settings',
                  builder: (BuildContext context, GoRouterState state) =>
                      const AccountManagementScreen(),
                  routes: [
                    FeatureRoute(
                      path: 'details',
                      name: 'AccountDetails',
                      description: 'Detailed information about the account',
                      builder: (context, state) => const AccountDetailsScreen(),
                      routes: [
                        FeatureRoute(
                          path: 'transactions',
                          name: 'AccountTransactions',
                          description: 'View and manage account transactions',
                          builder: (context, state) =>
                              const TransactionsScreen(),
                          routes: [
                            FeatureRoute(
                              path: 'details',
                              name: 'TransactionDetails',
                              description: 'Details of a specific transaction',
                              builder: (context, state) =>
                                  const TransactionDetailsScreen(),
                            ),
                          ],
                        ),
                        FeatureRoute(
                          path: 'settings',
                          name: 'AccountSettings',
                          description: 'Manage account settings',
                          builder: (context, state) =>
                              const AccountSettingsScreen(),
                        ),
                      ],
                    ),
                    FeatureRoute(
                      path: 'open',
                      name: 'OpenAccount',
                      description: 'Open a new account',
                      builder: (context, state) => const OpenAccountScreen(),
                    ),
                    FeatureRoute(
                      path: 'close',
                      name: 'CloseAccount',
                      description: 'Close an existing account',
                      builder: (context, state) => const CloseAccountScreen(),
                    ),
                    FeatureRoute(
                      path: 'savings',
                      name: 'SavingsAccount',
                      description: 'View savings account details',
                      builder: (context, state) => const SavingsScreen(),
                    ),
                    FeatureRoute(
                      path: 'loans',
                      name: 'Loans',
                      description: 'View loan options',
                      builder: (context, state) => const LoansScreen(),
                    ),
                    FeatureRoute(
                      path: 'investments',
                      name: 'investments',
                      description: 'Manage your investments',
                      builder: (context, state) => const InvestmentsScreen(),
                      routes: [
                        FeatureRoute(
                          path: ':companyID',
                          name: 'investment_company',
                          description: 'Investment company details',
                          parameters: const {
                            'companyID': {
                              '1': 'Company_A',
                              '2': 'Company_B',
                              '3': 'Company_C',
                            },
                          },
                          builder: (context, state) {
                            final companyID =
                                state.pathParameters['companyID']!;
                            final companyName = getCompanyNameById(companyID);
                            return InvestmentCompanyPage(
                                companyID: companyID, companyName: companyName);
                          },
                          routes: [
                            FeatureRoute(
                              path: ':action',
                              name: 'investment_action',
                              description: 'Buy or sell investments',
                              parameters: const {
                                'action': ['buy', 'sell'],
                              },
                              builder: (context, state) {
                                final companyID =
                                    state.pathParameters['companyID']!;
                                final companyName =
                                    getCompanyNameById(companyID);
                                final action = state.pathParameters['action']!;
                                return InvestmentActionPage(
                                  companyID: companyID,
                                  companyName: companyName,
                                  action: action,
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    GoRoute(
                      path: 'restricted_page',
                      name: 'Restricted_Page',
                      builder: (context, state) => const RestrictedScreen(),
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                FeatureRoute(
                  path: '/cards',
                  name: 'Cards',
                  description: 'Manage your credit and debit cards',
                  builder: (BuildContext context, GoRouterState state) =>
                      const CardsScreen(),
                  routes: [
                    FeatureRoute(
                      path: 'apply',
                      name: 'ApplyCard',
                      description: 'Apply for a new card',
                      builder: (context, state) => const ApplyCardScreen(),
                      routes: [
                        FeatureRoute(
                          path: 'credit',
                          name: 'ApplyCreditCard',
                          description: 'Apply for a credit card',
                          builder: (context, state) =>
                              const CreditCardApplicationScreen(),
                        ),
                        FeatureRoute(
                          path: 'debit',
                          name: 'ApplyDebitCard',
                          description: 'Apply for a debit card',
                          builder: (context, state) =>
                              const DebitCardApplicationScreen(),
                        ),
                      ],
                    ),
                    FeatureRoute(
                      path: 'usage',
                      name: 'CardUsage',
                      description: 'View card usage details',
                      builder: (context, state) => const CardUsageScreen(),
                    ),
                    FeatureRoute(
                      path: 'benefits',
                      name: 'CardBenefits',
                      description: 'View card benefits',
                      builder: (context, state) => const CardBenefitsScreen(),
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                FeatureRoute(
                  path: '/insurance',
                  name: 'Insurance',
                  description: 'Manage your insurance policies',
                  builder: (BuildContext context, GoRouterState state) =>
                      const InsuranceScreen(),
                  routes: [
                    FeatureRoute(
                      path: 'details',
                      name: 'InsuranceDetails',
                      description:
                          'Detailed information about the insurance policy',
                      builder: (context, state) =>
                          const InsuranceDetailsScreen(),
                      routes: [
                        FeatureRoute(
                          path: 'claim',
                          name: 'InsuranceClaim',
                          description: 'File an insurance claim',
                          builder: (context, state) =>
                              const InsuranceClaimScreen(),
                        ),
                      ],
                    ),
                    FeatureRoute(
                      path: 'apply',
                      name: 'ApplyInsurance',
                      description: 'Apply for new insurance',
                      builder: (context, state) => const ApplyInsuranceScreen(),
                    ),
                    FeatureRoute(
                      path: 'payment',
                      name: 'InsurancePayment',
                      description: 'Manage insurance payments',
                      builder: (context, state) =>
                          const InsurancePaymentScreen(),
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                FeatureRoute(
                  path: '/customer_service',
                  name: 'CustomerService',
                  description: 'Access customer service options',
                  builder: (BuildContext context, GoRouterState state) =>
                      const CustomerServiceScreen(),
                  routes: [
                    FeatureRoute(
                      path: 'faq',
                      name: 'FAQ',
                      description: 'Frequently Asked Questions',
                      builder: (context, state) => const FAQScreen(),
                    ),
                    FeatureRoute(
                      path: 'inquiry',
                      name: 'Inquiry',
                      description: 'Submit an inquiry',
                      builder: (context, state) => const InquiryScreen(),
                    ),
                    FeatureRoute(
                      path: 'locations',
                      name: 'ServiceCenterLocations',
                      description: 'Service center locations',
                      builder: (context, state) =>
                          const ServiceCenterLocationsScreen(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _featureRouter.router,
    );
  }
}

String getCompanyNameById(String companyID) {
  const companyMap = {
    '1': 'Company_A',
    '2': 'Company_B',
    '3': 'Company_C',
  };
  return companyMap[companyID] ?? 'Unknown Company';
}
