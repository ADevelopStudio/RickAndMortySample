
# SwiftUI Advanced Demo Project

This project is a **SwiftUI** application built to showcase advanced iOS development techniques and best practices. It targets **iOS 16** as a minimum deployment version and demonstrates how to handle earlier iOS limitations gracefully using `if #available`.

The app is **pure SwiftUI**—no third-party UI frameworks—and leverages a wide range of native iOS features, patterns, and frameworks.

---

## Key Highlights

1. **Minimum iOS 16 Support**  
   - Demonstrates latest SwiftUI features and handles graceful degradation for older iOS versions with `if #available`.

2. **No Third-Party Libraries**  
   - Implements everything natively, ensuring minimal dependencies and deeper control over the codebase.

3. **Async/Await Network Layer**  
   - Uses the native Swift **async/await** features for clean, structured concurrency.  
   - Includes **caching** mechanisms to optimize network usage and performance.

4. **Image Caching**  
   - Caches images locally to reduce redundant network calls, improving both performance and user experience.

5. **Architecture & Patterns**  
   - **MVVM** architecture, keeping UI logic separated from business logic.  
   - **Coordinator** pattern in SwiftUI for managing navigation flows.  
   - **Protocols** and **Dependency Injection** for flexible, testable, and maintainable code.  
   - **Functional Programming** principles applied where it makes sense to keep code concise and testable.

6. **Logging with OSLog**  
   - Adopts Apple’s **OSLog** framework for efficient and organized logging at various severity levels.

7. **Custom View Modifiers**  
   - Showcases how SwiftUI **ViewModifiers** can encapsulate repeated view styling and behaviors for improved reusability.

8. **Asset Catalogs**  
   - Centralizes images and color assets for consistent usage and easy updates.  
   - Includes a custom colour scheme (dark mode with orange accent) in addition to system-based colour schemes.

9. **Push Notifications and Deep Links**  
   - Implements push notification handling and support for deep linking, including a convenient method to **test push notifications in the iOS Simulator** for easier debugging and development.

10. **Swift’s New Native Testing Framework**  
    - Migrates away from **XCTest** to the new **Swift Testing** framework, leveraging improved syntax and developer experience.
---

## Requirements

- Xcode 14 or later (to fully support iOS 16 features)  
- iOS 16 or later (tested on iOS 16 and above)  
- Swift 6
---

## Installation & Usage

1. **Clone the repository**  
   ```bash
   git clone https://github.com/ADevelopStudio/RickAndMortySample
   
2. **Open the project in Xcode**  
- Navigate to the project folder and double-click `RickAndMortySample.xcodeproj` (or open via **File -> Open** in Xcode).

3. **Select a simulator or a connected device**  
- Make sure it runs **iOS 18** or later to see all the features in action. (although app supports iOS16)

4. **Build & Run**  
- Press **Cmd + R** to build and run.
___
## Testing
This project uses the new  **Swift Testing**  framework. All test targets are located under the  `RickAndMortySampleTests`  folder. To run tests:
1.  Open the  **Test Navigator**  in Xcode (`⌘ + 6`).
2.  Select the test or test suite you want to run.
3.  Press  **Cmd + U**  or the  **Play**  button to execute tests.

You will see a detailed report in the Xcode console, including logs from  **OSLog**.

----------

___
## Testing Push notification on simulator
You can test on simulator the app behaviour and deep link handling from push notifications. To do so, please folllow the instruction:
1.  Run the app on Simulator.
2.  In the app open the last tab `Extra`.
3.  Open `Push notifications` screen and request push notification access by clicking on **Allow** button. Allow the push access.
5.  Once push is allowed you can simply drag and drop `Explore the character.apns` or `New Episode.apns` files from the root folder of the project to the simulator screen. Application can be on active or background state.
6.  Deeplink will handle by tapping on the push notification. 
7.  **Please note** that `.apns` files contain `bundleID` of the project. So if you change the bundleId of the project for some reasons, you have to change the content of `.apns` files as well.
  
----------

## Contributing

Feel free to open issues, fork, or submit pull requests. All contributions are welcome and appreciated!

----------

## License

This project is licensed under the  MIT License. You’re free to use, modify, and distribute it as you see fit.

----------

_Thank you for checking out this SwiftUI Advanced Demo Project! If you have any questions or feedback, please open an issue or reach out via  GitHub Issues._
