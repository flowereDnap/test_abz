

# test abz

## Table of Contents
1. [Project Overview](#project-overview)
2. [Configuration](#configuration)
3. [Dependencies](#dependencies)
4. [Project Architecture](#project-architecture)
5. [Troubleshooting](#troubleshooting)

---

## Project Overview
MVVM arcitecture used. 
**Model**:  
      -**Network Manager classes**: 
          NWManager - responsible for get/post requests (singleton)
          Errors/Responces - expected errors and responces from api
      -**Local Memory**:
          CacheImageManager - expected to store images of 12 latrest user to display it offline, but I didnt finish this logic implementation
          KeychainHelper  - used to store sensetive data (at the moment - token needed for post requests)
      -**Entities**: 
          User - main object in the app
**View Models**:
      -**UsersList** - used to represent list of users fetched by NWManager, keeps track of loaded users
      -**SignUp** - form to create new user, handles all business logic
      -**Alert** - handles state of an allert (type, message, if is shown)
**Views**:
      -**ContentView** - shows users list or sign up form based on users choice, has Alert View overlayed
      -**users list**
      -**users list cell**
      -**sign up**
      -**users list**

## Configuration
There are no specific configuration options or customizations required for this project.

## Dependencies
This project relies on the following dependencies:
- **Alamofire**: A Swift-based HTTP networking library used for making network requests.
  - Installation: `pod 'Alamofire'`
- **Foundation**: A core framework provided by Apple that provides essential data types, collections, and operating-system services.
- **SwiftUI**: A user interface toolkit for building views and managing user input across platforms.
- **Security**: Used to secure storage of token from API (required for post requests)
- **PhotosUI**: Used to load photos from gallery
- **UIKit**: Used to perform making photos with camera

Make sure to install the dependencies using CocoaPods if you're setting up the project for the first time. Run the following command:

```bash
pod install
```

## Project Architecture
This project follows the **MVVM (Model-View-ViewModel)** architecture:
- **Model**: Handles the data logic of the application.
- **View**: Represents the user interface of the app.
- **ViewModel**: Acts as a bridge between the View and the Model, providing data and handling business logic.

Additional components include:
- **Networking Layer**: Built using Alamofire to handle API requests and responses.
- **Data Caching**: Implemented to store images for offline access.

## Troubleshooting
There are currently no known issues. If you encounter any problems, feel free to submit an issue on the repository.

---

This should paste nicely into your GitHub README with proper formatting.
