# 💻 Computer Rental App



<p align="center">
  <img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white" alt="Dart">
  <img src="https://img.shields.io/badge/Status-Mid--Term--Project-orange?style=for-the-badge" alt="Status">
</p>

<p align="center">
  <img src="https://img.shields.io/badge/license-Apache%202.0-blue?style=flat-square" alt="License">
  <img src="https://img.shields.io/badge/school-SMK%20Telkom%20Malang-red?style=flat-square" alt="School">
  <img src="https://img.shields.io/badge/platform-Android%20%7C%20iOS-lightgrey?style=flat-square" alt="Platform">
</p>

---

## 📖 Table of Contents

- [About the Project](#-about-the-project)
- [Features](#-features)
- [Learning Notes](#-learning-notes)
- [Tech Stack](#-tech-stack)
- [Getting Started](#-getting-started)
- [Author](#-author)
- [License](#-license)

---

## 🔍 About the Project

**Computer Rental App** is a mobile application designed to streamline the management of computer rental operations — covering unit cataloging, renter data management, and revenue tracking — with a focus on efficiency and clean user experience.

This project was built as a **Mid-Term Project for Semester 1** at **SMK Telkom Malang**, demonstrating foundational progress in Flutter and Dart development with a clean, adaptive UI approach.

> Although the application currently uses static (dummy) data, the architecture and feature set reflect real-world rental management workflows and serve as a solid foundation for future backend integration.

---

## 🚀 Features

| Feature | Description |
|---------|-------------|
| 📊 **Real-time Dashboard** | Monitor total revenue, rented units, and weekly statistics via an interactive bar chart |
| 📈 **Annual Statistics** | Monthly revenue reports displayed in a clean, readable table format |
| 💻 **Smart Catalog** | Browse computer units (Gaming, Creator, Mini) with full RAM & GPU specifications |
| 📝 **Comprehensive CRUD** | Full renter data management — Add, Edit, Search, and Delete — with active status indicators |
| 🌓 **Adaptive Theme** | Full Light and Dark mode support for optimal user comfort |

---

## 🛠️ Project Architecture

The application follows a well-organized folder structure to ensure scalability, maintainability, and clean code — aligned with the standards taught at SMK Telkom Malang.

```
lib/
├── ⚙️  config/       # App theme (Dark/Light), color palette & constants
├── 📄  models/       # Data blueprints & object mapping (SewaModel)
├── 🗺️  navigation/   # Navigation logic & Bottom Navigation Bar
├── 🖼️  screens/      # Core UI screens (Dashboard, Statistics, Rental Data)
├── 🧩  utils/        # Dummy data & helper functions
└── 📦  widgets/      # Reusable UI components
```

---

## 💡 Learning Notes

This project is the result of independent exploration and teacher guidance over the first half of Semester 1. While still relatively simple and relying on static data, the core learning objectives were:

- **Layout Mastery** — Practical implementation of `Row`, `Column`, `Stack`, and `ListView`
- **State Management** — Introduction to `Provider` for simple reactive state
- **List Logic** — Filtering and searching functionality on dynamic list data

This project reflects a deliberate focus on building strong Flutter fundamentals before progressing to backend integration and real data sources.

---

## 🛠 Tech Stack

| Tool | Purpose |
|------|---------|
| **Flutter** | Cross-platform mobile UI framework |
| **Dart** | Core programming language |
| **Provider** | Lightweight state management |

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) installed and configured
- A connected device or emulator (Android / iOS)
- Git

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/WagyuuA5/Computer_Rental_APP.git
   cd Computer_Rental_APP
   ```

2. **Install dependencies:**

   ```bash
   flutter pub get
   ```

3. **Run the application:**

   ```bash
   flutter run
   ```

> For a release build: `flutter build apk` (Android) or `flutter build ios` (iOS)

---

## 👤 Author

**Wahyu Ravi Anggoro** — [@WagyuuA5](https://github.com/WagyuuA5)
Student at **SMK Telkom Malang**

---

## 📄 License

Copyright © 2026 **Wahyu Ravi Anggoro**. All rights reserved.

This project is licensed under the **Apache License, Version 2.0** (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at:

> http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

---

<p align="center">
  Made with ❤️ by Wahyu Ravi &nbsp;|&nbsp; SMK Telkom Malang &nbsp;|&nbsp; 2026
</p>
