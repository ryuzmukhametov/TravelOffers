TravelOffers is simple one screen application which shows information about travel offers using tab based interface.

The app internally uses next characteristics:
- Dependency Injection principle
- VIPER based approach
- Layer based architecture
- Core Data to keep all necessary information about offers as result the app is able to work in offline mode
- Usage size classes and autolayouts as result the app looks friendly in different devices
- Image loader object to load and keep images in memory and on disk
- CocoaPods to import CocoaLumberjack logging framework 
- Swift 3 (VIPER module) and Objective-C (core layer and business logic layer)
- Generamba to generate VIPER module

Skipped scopes:
- Custom animation effects and custom controls
- Unit testing
- Error handling
- iOS7 supporting (Xcode8 was used as IDE and iOS8 is minimal allowed) 
- Cancelation of network operations
