# Feature Navigator

## Overview

**Feature Navigator** is a Flutter package that enhances your application's navigation by allowing users to search for specific features using a chatbot interface. It extends the capabilities of the `go_router` package by introducing `FeatureRoute`, which includes additional properties like `name`, `description`, and supports advanced features like dynamic parameters and multiple `extra` data entries for better route management and accessibility.

## Features

- **Easy Integration**: Seamlessly integrate with your existing Flutter app using `go_router`.
- **ChatBot Interface**: Allows users to search for app functionalities via a chatbot.
- **Extended Routing**: Use `FeatureRoute` to add `name`, `description`, and control chat appearance with `includeChat`.
- **Dynamic Parameters and Extras**: Handle dynamic routes with path parameters and multiple `extra` data entries.
- **Nested Routing Support**: Supports nested routes and `StatefulShellRoute`.
- **GPT Model Selection**: Optionally choose GPT models, with `gpt-4o-mini` as the default.
- **Control Chat Visibility**: Use `includeChat` in `FeatureRoute` to show or hide the chat on specific pages.
- **Fallback Compatibility**: Compatible with `GoRoute`; you can mix `GoRoute` and `FeatureRoute`.

## Installation

Add the `feature_navigator` package to your project:

```bash
flutter pub add feature_navigator
```

## Usage

### 1. Setting Up the Router

In your `main.dart` or wherever you set up your router, declare the `FeatureRouter` as follows:

```dart
FeatureRouter(
  goRouter: router,
  apiKey: 'your-gpt-api-key',
  gptModel: GPTModel.gpt4oMini, // Optional, defaults to gpt-4o-mini
);
```

#### Selecting GPT Models

You can optionally choose the GPT model to use. The default is `gpt-4o-mini`. Available models are:

```dart
enum GPTModel {
  gpt4o('gpt-4o'),
  gpt4('gpt-4'),
  gpt4oMini('gpt-4o-mini');

  final String modelName;

  const GPTModel(this.modelName);
}
```

Set the `gptModel` parameter when initializing `FeatureRouter`:

```dart
FeatureRouter(
  goRouter: router,
  apiKey: 'your-gpt-api-key',
  gptModel: GPTModel.gpt4, // Choose the desired model
);
```

### 2. Defining Routes with `FeatureRoute`

Within your `GoRouter`, use `FeatureRoute` instead of `GoRoute` to define your routes. This allows you to add additional metadata like `name` and `description` for each route.

```dart
final GoRouter router = GoRouter(
  routes: [
    FeatureRoute(
      name: 'main',
      description: 'The main page where users can see an overview or access various features.',
      path: '/',
      builder: (context, state) => const MainPage(),
    ),
    // Additional routes...
  ],
);
```

#### Note

- When using `FeatureRoute`, you **must** provide the `name` and `description` parameters.
- `FeatureRoute` supports nested routing and `StatefulShellRoute`.
- **Control Chat Visibility**: Use the `includeChat` parameter to show or hide the chat on specific pages. The default value is `true`.

```dart
FeatureRoute(
  name: 'settings',
  description: 'User settings page',
  path: '/settings',
  includeChat: false, // Chat will not appear on this page
  builder: (context, state) => const SettingsPage(),
),
```

### 3. Dynamic Routing with Path Parameters

`FeatureRoute` makes it easy to handle dynamic routes. You can define path parameters and multiple `extra` data entries to create dynamic and flexible routing.

#### Defining Parameters

Use the `parameters` property to define dynamic path parameters.

##### Method 1: Using a Map for Parameter Values

Use a `Map` where the key is the path parameter, and the value is another `Map` of possible path values to their display names.

```dart
FeatureRoute(
  path: '/invest/:companyID',
  name: 'investment_company',
  description: 'Investment company details',
  parameters: {
    'companyID': {
      '1': 'CompanyA',
      '2': 'CompanyB',
      '3': 'CompanyC',
    },
  },
  builder: (context, state) {
    final companyID = state.params['companyID']!;
    final companyName = getCompanyNameById(companyID);
    return InvestmentCompanyPage(
      companyID: companyID,
      companyName: companyName,
    );
  },
),
```

##### Method 2: Using a List for Parameter Values

Use a `List` where the path parameter maps to a list of possible values.

```dart
FeatureRoute(
  path: '/:action',
  name: 'investment_action',
  description: 'Buy or sell investments',
  parameters: {
    'action': ['buy', 'sell'],
  },
  builder: (context, state) {
    final action = state.params['action']!;
    // ... your code ...
  },
),
```

### 4. Using `extras` for Additional Data

`FeatureRoute` supports passing additional data using the `extras` property. This allows you to define multiple `extra` data entries for a route, similar to how parameters are handled.

#### Defining Multiple `extras`

Use the `extras` property, which is a `Map` where each key corresponds to a unique `extra` data entry.

```dart
FeatureRoute(
  path: 'transactions',
  name: 'transactions',
  description: 'Transactions Page',
  builder: (context, state) {
    final info = state.extra?['info'];
    return TransactionsPage(info: info);
  },
  extras: {
    'Transaction A': {'info': 'Additional Data 1'},
    'Transaction B': {'info': 'Additional Data 2'},
    // ... more entries ...
  },
),
```

#### How It Works

- **Route Generation**: The `RouteDataProvider` will generate routes for each combination of parameters and `extras`.
- **Adjusted Route Names**: Route names and descriptions will include the `extra` key to uniquely identify each route.
- **Navigation**: When navigating to these routes, the corresponding `extra` data will be passed along via `state.extra`.

#### Example with Parameters and `extras`

```dart
FeatureRoute(
  path: 'investments/:companyID',
  name: 'investment',
  description: 'Investment Page',
  parameters: {
    'companyID': {
      '1': 'CompanyA',
      '2': 'CompanyB',
    },
  },
  extras: {
    'Transaction A': {'info': 'Additional Data 1'},
    'Transaction B': {'info': 'Additional Data 2'},
  },
  builder: (context, state) {
    final companyID = state.params['companyID']!;
    final companyName = getCompanyNameById(companyID);
    final info = state.extra?['info'];
    return InvestmentPage(
      companyID: companyID,
      companyName: companyName,
      info: info,
    );
  },
),
```

**Generated Route Names:**

- `investment_CompanyA_Transaction A`
- `investment_CompanyA_Transaction B`
- `investment_CompanyB_Transaction A`
- `investment_CompanyB_Transaction B`

### 5. Accessing `extra` Data in the Builder

In your route's `builder` function, you can access the `extra` data via `state.extra`.

```dart
builder: (context, state) {
  final info = (state.extra as Map<String, dynamic>?)?['info'];
  return SomePage(info: info);
},
```

### 7. Mixing `FeatureRoute` with `GoRoute`

Since `FeatureRoute` extends `GoRoute`, you can still declare routes using `GoRoute`. However, be aware that the chatbot functionality provided by `Feature Navigator` cannot access routes defined with `GoRoute`. To utilize the chatbot features fully, it's recommended to use `FeatureRoute`.

```dart
routes: [
  FeatureRoute(
    // ... FeatureRoute definitions ...
  ),
  GoRoute(
    path: '/help',
    builder: (context, state) => const HelpPage(),
  ),
],
```

## Important Notes

- **ChatBot Accessibility**: The chatbot in `Feature Navigator` can only access routes defined with `FeatureRoute`. Routes defined with `GoRoute` will not be accessible via the chatbot interface.
- **Unique Route Names**: When using parameters and `extras`, route names are automatically adjusted to include parameter values and `extra` keys to ensure uniqueness.
- **Compatibility**: Since `FeatureRoute` extends `GoRoute`, you can use both in your application without any issues.
- **Chat Visibility Control**: Use `includeChat: false` in `FeatureRoute` to hide the chat on specific pages.

## Developers

| [![Developer 1](https://avatars.githubusercontent.com/u/117894155?v=4?s=150)](https://github.com/yunseoLee0343) | [![Developer 2](https://avatars.githubusercontent.com/u/3265750?v=4?s=150)](https://github.com/hin6150) |
| :-------------------------------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------------------------: |
|                         [@yunseoLee0343](https://github.com/yunseoLee0343)                         |                         [@hin6150](https://github.com/hin6150)                         |

## Contributing

Contributions are welcome! If you'd like to improve the `Feature Navigator` package or fix bugs, please submit a pull request. We recommend creating an issue or discussing your changes beforehand to share your ideas.

### How to Contribute

1. **Fork the Repository**: Create a fork of this repository.
2. **Create a Branch**: Create a new branch for your feature or bug fix.

   ```bash
   git checkout -b feature/new-feature
   ```

3. **Commit Your Changes**: Commit your changes with descriptive messages.

   ```bash
   git commit -m "Add new feature"
   ```

4. **Push to the Branch**: Push your changes to the branch.

   ```bash
   git push origin feature/new-feature
   ```

5. **Open a Pull Request**: Create a pull request on GitHub.

## License

`Feature Navigator` is distributed under the MIT License. See the [LICENSE](LICENSE) file for more information.

## Contact

For inquiries or suggestions regarding the project, please contact us at [hin6150@gmail.com](mailto:hin6150@gmail.com).
