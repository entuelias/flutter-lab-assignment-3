# 📱 Flutter Lab Assignment 3 – Album Viewer App

This Flutter application fetches and displays a list of albums and their photos from the JSONPlaceholder API. Users can scroll through albums, view photos, and access detailed information about each album.

---

## 🎯 Objective

Build a mobile app that:
- Retrieves albums and photos using HTTP requests.
- Shows them in a scrollable list with titles and thumbnails.
- Navigates to a detail screen on tap.
- Handles loading and network errors gracefully.
- Uses a clean architecture with MVVM structure and Bloc-based state management (optional in progress).

---

## 📦 Features

### ✅ List Screen
- Scrollable list of album titles and thumbnails
- Responsive UI with loading indicators
- Error messages on network failure

### ✅ Detail Screen
- Tapping an album shows its full list of photos
- Photo ID, title, and placeholder boxes
- Clean navigation using `go_router`

---

## 🔧 Tech Stack

| Layer               | Tool/Library                     |
|---------------------|----------------------------------|
| UI Layer            | Flutter Widgets                  |
| State Management    | ViewModel (MVVM pattern)         |
| Navigation          | GoRouter                         |
| HTTP Requests       | `http` package                   |
| Architecture        | MVVM (Model-View-ViewModel)      |
| API Source          | [JSONPlaceholder](https://jsonplaceholder.typicode.com) |

---

## 🚦 How to Run

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/flutter-lab-assignment-3.git
   cd flutter-lab-assignment-3


2. Get packages:

   ```bash
   flutter pub get
   ```

3. Run the app:

   ```bash
   flutter run
   ```



## 🧪 Requirements Checklist

✅ Remote data fetch from Album & Photo APIs
✅ Scrollable list with album titles + thumbnails
✅ Detail screen for selected album
✅ Error handling (network failure)
✅ Loading states
✅ Navigation with `go_router`
✅ Clean architecture (MVVM)
🟡 Bloc folder setup 


## 📎 Author

**Entisar Elias**
Third-Year Software Engineering Student
[GitHub Profile](https://github.com/entuelias) | [LinkedIn](https://www.linkedin.com/in/entisar-elias-q/)






