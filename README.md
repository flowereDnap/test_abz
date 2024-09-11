

# test abz

## Table of Contents
1. [Project Overview](#project-overview)
2. [Configuration](#configuration)
3. [Dependencies](#dependencies)
4. [Project Architecture](#project-architecture)
5. [Troubleshooting](#troubleshooting)

---

## Project Overview

**MVVM Architecture used**

- **Model**:  
  - **Network Manager classes**:  
    - `NWManager`: Responsible for GET/POST requests (singleton)  
    - `Errors/Responses`: Handles expected errors and responses from the API  
  - **Local Memory**:  
    - `CacheImageManager`: Expected to store images of the 12 latest users to display offline, but this logic is not yet implemented  
    - `KeychainHelper`: Used to store sensitive data (currently the token needed for POST requests)  
  - **Entities**:  
    - `User`: The main object in the app  

- **View Models**:  
  - `UsersList`: Represents a list of users fetched by `NWManager`, keeps track of loaded users  
  - `SignUp`: Form to create a new user, handles all business logic  
  - `Alert`: Manages the state of an alert (type, message, visibility)  

- **Views**:  
  - `ContentView`: Displays the users list or sign-up form based on user choice, with an alert view overlayed  
  - `Users List`  
  - `Users List Cell`  
  - `Sign Up`  
  - `Alert`
 
---

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
