# Feature Navigator

## Overview

**Feature Navigator** is a Flutter package that enhances your application's navigation by allowing users to search for specific features using a chatbot interface. It extends the capabilities of the `go_router` package by introducing `FeatureRoute`, which includes additional properties like `name` and `description` for better route management and accessibility.

## Features

- **Easy Integration**: Seamlessly integrate with your existing Flutter app using `go_router`.
- **ChatBot Interface**: Allows users to search for app functionalities via a chatbot.
- **Extended Routing**: Use `FeatureRoute` to add `name`, `description`, and control chat appearance with `includeChat`.
- **Nested Routing Support**: Supports nested routes and `StatefulShellRoute`.
- **Dynamic Routing**: Easily handle dynamic routes with path parameters.
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
  includeChat: false, // Chat Button will not appear on this page
  builder: (context, state) => const SettingsPage(),
),
```

### 3. Dynamic Routing with Path Parameters

`FeatureRoute` makes it easy to handle dynamic routes. You can define path parameters using two methods:

#### Method 1: Using a Map for Parameter Values

Use a `Map` where the key is the path parameter, and the value is another `Map` of possible path values to their display names.

```dart
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
    final companyID = state.pathParameters['companyID']!;
    final companyName = getCompanyNameById(companyID);
    return InvestmentCompanyPage(
      companyID: companyID,
      companyName: companyName,
    );
  },
),
```

#### Method 2: Using a List for Parameter Values

Use a `List` where the path parameter maps to a list of possible values.

```dart
FeatureRoute(
  path: ':action',
  name: 'investment_action',
  description: 'Buy or sell investments',
  parameters: const {
    'action': ['buy', 'sell'],
  },
  builder: (context, state) {
    final action = state.pathParameters['action']!;
    // ... your code ...
  },
),
```

### 4. Mixing `FeatureRoute` with `GoRoute`

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
- **Compatibility**: Since `FeatureRoute` extends `GoRoute`, you can use both in your application without any issues.
- **Chat Visibility Control**: Use `includeChat: false` in `FeatureRoute` to hide the chat on specific pages.

## Developers

| [![Developer 1](https://avatars.githubusercontent.com/u/117894155?v=4?s=150)](https://github.com/yunseoLee0343) | [![Developer 2](https://avatars.githubusercontent.com/u/3265750?v=4?s=150)](https://github.com/hin6150) |
| :-------------------------------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------------------------: |
|                         [@yunseoLee0343](https://github.com/yunseoLee0343)                         |                         [@hin6150](https://github.com/hin6150)                         |

*Note: The images are resized to maintain appropriate dimensions. Replace `?s=150` with the desired size if needed.*

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
