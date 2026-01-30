# Expenses Tracker App

A simple Flutter application for tracking daily expenses.  
This project focuses on writing **clean, readable, and maintainable Flutter code** while building a real, usable app.

---

##  What the app does

- Add and delete expenses
- View total expenses
- Clean and simple UI
- Light & Dark theme support
- Firebase integration

---

##  Project Structure

The project follows a **feature-based structure**.

Each feature (such as `expenses` or `auth`) is organized into:
- data
- domain
- presentation

This makes the codebase easier to understand and scale.

---

##  Architecture

The app uses **Clean Architecture** to keep responsibilities separated and the code easy to maintain.

Business logic is separated from UI, and data sources are isolated behind repositories.

---

##  State Management

State management is handled using **Riverpod**.

- Controllers manage the logic
- UI reacts to state changes
- Async states (loading / error / data) are handled cleanly

---

##  Testing

Basic testing is included to ensure the core functionality works as expected:

- Unit tests for business logic
- Widget tests for UI behavior
- Mocking dependencies using `mocktail`

The focus is on testing **logic and behavior**, not framework internals.

---

## Screenshots

<table>
  <tr>
    <td><img src="screenshots/home_page.png" width="200"/></td>
    <td><img src="screenshots/add_expense_dark_page.png" width="200"/></td>
    <td><img src="screenshots/drawer.png" width="200"/></td>
    <td><img src="screenshots/add_expense_page.png" width="200"/></td>
  </tr>
</table>

Ahmed  
Flutter Developer

Flutter developer with a strong focus on clean code and scalable app architecture.  
I enjoy building real-world applications, solving problems, and improving code quality through good structure and testing.

---

##  Run the project

```bash
flutter pub get
flutter run


## 👤 About Me



