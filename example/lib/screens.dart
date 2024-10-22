import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/account_management'),
              child: const Text('View Service'),
            ),
          ],
        ),
      ),
    );
  }
}

// AccountManagementScreen
class AccountManagementScreen extends StatelessWidget {
  const AccountManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account Management')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'AccountManagement',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text('Manage your account details and settings'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/account_management/details'),
              child: const Text('View Account Details'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/account_management/open'),
              child: const Text('Open a New Account'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/account_management/close'),
              child: const Text('Close an Existing Account'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/account_management/savings'),
              child: const Text('View Savings Account'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/account_management/loans'),
              child: const Text('View Loan Options'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/account_management/investments'),
              child: const Text('Manage Investments'),
            ),
          ],
        ),
      ),
    );
  }
}

// AccountDetailsScreen
class AccountDetailsScreen extends StatelessWidget {
  const AccountDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account Details')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'AccountDetails',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text('Detailed information about the account'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () =>
                  context.go('/account_management/details/transactions'),
              child: const Text('View Account Transactions'),
            ),
            ElevatedButton(
              onPressed: () =>
                  context.go('/account_management/details/settings'),
              child: const Text('Manage Account Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

// TransactionsScreen
class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transactions')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'AccountTransactions',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text('View and manage account transactions'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context
                  .go('/account_management/details/transactions/details'),
              child: const Text('View Transaction Details'),
            ),
          ],
        ),
      ),
    );
  }
}

// TransactionDetailsScreen
class TransactionDetailsScreen extends StatelessWidget {
  const TransactionDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transaction Details')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'TransactionDetails',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('Details of a specific transaction'),
          ],
        ),
      ),
    );
  }
}

// AccountSettingsScreen
class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account Settings')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'AccountSettings',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('Manage account settings'),
          ],
        ),
      ),
    );
  }
}

// OpenAccountScreen
class OpenAccountScreen extends StatelessWidget {
  const OpenAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Open Account')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'OpenAccount',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('Open a new account'),
          ],
        ),
      ),
    );
  }
}

// CloseAccountScreen
class CloseAccountScreen extends StatelessWidget {
  const CloseAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Close Account')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'CloseAccount',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('Close an existing account'),
          ],
        ),
      ),
    );
  }
}

// SavingsScreen
class SavingsScreen extends StatelessWidget {
  const SavingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Savings')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'SavingsAccount',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('View savings account details'),
          ],
        ),
      ),
    );
  }
}

// LoansScreen
class LoansScreen extends StatelessWidget {
  const LoansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Loans')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Loans',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('View loan options'),
          ],
        ),
      ),
    );
  }
}

// InvestmentsScreen
class InvestmentsScreen extends StatelessWidget {
  const InvestmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Investments')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Investments',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('Manage your investments'),
          ],
        ),
      ),
    );
  }
}

// CardsScreen
class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cards')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Cards',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text('Manage your credit and debit cards'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/cards/apply'),
              child: const Text('Apply for a New Card'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/cards/usage'),
              child: const Text('View Card Usage Details'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/cards/benefits'),
              child: const Text('View Card Benefits'),
            ),
          ],
        ),
      ),
    );
  }
}

// ApplyCardScreen
class ApplyCardScreen extends StatelessWidget {
  const ApplyCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Apply for a Card')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'ApplyCard',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text('Apply for a new card'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/cards/apply/credit'),
              child: const Text('Apply for a Credit Card'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/cards/apply/debit'),
              child: const Text('Apply for a Debit Card'),
            ),
          ],
        ),
      ),
    );
  }
}

// CardUsageScreen
class CardUsageScreen extends StatelessWidget {
  const CardUsageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Card Usage Details')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'CardUsage',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('View card usage details'),
          ],
        ),
      ),
    );
  }
}

// CardBenefitsScreen
class CardBenefitsScreen extends StatelessWidget {
  const CardBenefitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Card Benefits')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'CardBenefits',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('View card benefits'),
          ],
        ),
      ),
    );
  }
}

// CreditCardApplicationScreen
class CreditCardApplicationScreen extends StatelessWidget {
  const CreditCardApplicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Credit Card Application')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ApplyCreditCard',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('Apply for a credit card'),
          ],
        ),
      ),
    );
  }
}

// DebitCardApplicationScreen
class DebitCardApplicationScreen extends StatelessWidget {
  const DebitCardApplicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Debit Card Application')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ApplyDebitCard',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('Apply for a debit card'),
          ],
        ),
      ),
    );
  }
}

// InsuranceScreen
class InsuranceScreen extends StatelessWidget {
  const InsuranceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Insurance')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Insurance',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text('Manage your insurance policies'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/insurance/details'),
              child: const Text('View Insurance Details'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/insurance/apply'),
              child: const Text('Apply for Insurance'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/insurance/payment'),
              child: const Text('Manage Insurance Payments'),
            ),
          ],
        ),
      ),
    );
  }
}

// InsuranceDetailsScreen
class InsuranceDetailsScreen extends StatelessWidget {
  const InsuranceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Insurance Details')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'InsuranceDetails',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text('Detailed information about the insurance policy'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/insurance/details/claim'),
              child: const Text('File an Insurance Claim'),
            ),
          ],
        ),
      ),
    );
  }
}

// InsuranceClaimScreen
class InsuranceClaimScreen extends StatelessWidget {
  const InsuranceClaimScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Insurance Claim')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'InsuranceClaim',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('File an insurance claim'),
          ],
        ),
      ),
    );
  }
}

// ApplyInsuranceScreen
class ApplyInsuranceScreen extends StatelessWidget {
  const ApplyInsuranceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Apply for Insurance')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ApplyInsurance',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('Apply for new insurance'),
          ],
        ),
      ),
    );
  }
}

// InsurancePaymentScreen
class InsurancePaymentScreen extends StatelessWidget {
  const InsurancePaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Insurance Payment')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'InsurancePayment',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('Manage insurance payments'),
          ],
        ),
      ),
    );
  }
}

// CustomerServiceScreen
class CustomerServiceScreen extends StatelessWidget {
  const CustomerServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customer Service')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'CustomerService',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text('Access customer service options'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/customer_service/faq'),
              child: const Text('Frequently Asked Questions'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/customer_service/inquiry'),
              child: const Text('Submit an Inquiry'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/customer_service/locations'),
              child: const Text('Service Center Locations'),
            ),
          ],
        ),
      ),
    );
  }
}

// FAQScreen
class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FAQ')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'FAQ',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('Frequently Asked Questions'),
          ],
        ),
      ),
    );
  }
}

// InquiryScreen
class InquiryScreen extends StatelessWidget {
  const InquiryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inquiry')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Inquiry',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('Submit an inquiry'),
          ],
        ),
      ),
    );
  }
}

// ServiceCenterLocationsScreen
class ServiceCenterLocationsScreen extends StatelessWidget {
  const ServiceCenterLocationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Service Center Locations')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ServiceCenterLocations',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('Service center locations'),
          ],
        ),
      ),
    );
  }
}
