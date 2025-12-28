# Mini Chat Application (Flutter)

A mini chat application built as part of a technical assignment, focusing on UI/UX accuracy, clean architecture, state management, and graceful error handling.

---

## 📱 Features

### Home Screen
- Custom top-tab switcher between **Users List** and **Chat History**
- Switcher scrolls away on scroll down and reappears on scroll up
- Scroll position preserved between tabs

### Users List Tab
- Add users dynamically using Floating Action Button
- Each user displays name and avatar initial
- Snackbar confirmation on adding user
- Scroll position preserved
- Tap on user navigates to Chat Screen

### Chat History Tab
- Displays previous chat sessions
- Shows user avatar, name, last message, and last chat time
- Scroll position preserved

### Chat Screen
- Sender messages (local) aligned to right with avatar and bubble
- Receiver messages fetched from open-source public API
- Rounded chat bubbles with avatar initials
- Keyboard-aware layout (no content hidden)
- Auto-scrolls to latest message
- Graceful handling of network failures

### Bonus Feature
- Long-press on any message shows a bottom sheet with word meaning
- Uses open-source Dictionary API

---

## 🌐 APIs Used (Open Source)

- Receiver Messages:
  https://jsonplaceholder.typicode.com/comments/1
- Dictionary API (Bonus Feature):
  https://api.dictionaryapi.dev/api/v2/entries/en/<word>




---

## 🧠 Architecture & State Management

- Clean, feature-first architecture
- State management using **Bloc**
- Separation of presentation, domain, and data layers
- Reusable UI components

---

## 🧪 Testing

Basic tests added for brownie points:
- Widget test for chat bubble UI
- Bloc test for HomeBloc state transitions

Run tests using:
```bash
flutter test

