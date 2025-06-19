### 📄 `README.md`

# 🌡️ Smart Room Condition Monitoring App

A Flutter application that displays real-time data from a Firebase Realtime Database to monitor smart room conditions such as temperature, humidity, light, and power consumption.

<br/>

## 📱 Features

📡 **Real-time monitoring** via Firebase Realtime Database
- 📊 Displays:
  - 🌡️ Temperature
  - 💧 Humidity
  - 💡 Light levels
  - ⚡ Power  
<br/>

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Firebase account
- A Firebase project with Realtime Database enabled

### Setup Instructions

1. **Clone the repo:**

   ```bash
   git clone https://github.com/KPabsy/RoomSync_MobileApp.git
   cd smart-room-monitor

2. **Install packages:**

   ```bash
   flutter pub get
   ```

3. **Connect Firebase:**

   * Run:

     ```bash
     flutterfire configure
     ```
   * Follow the prompts to link your Firebase project and generate `firebase_options.dart`.

4. **Update Firebase Realtime Database Rules (for testing):**

   ```json
   {
     "rules": {
       ".read": true,
       ".write": false
     }
   }
   ```

5. **Run the app:**

   ```bash
   flutter run
   ```

---

## 🔧 Firebase Database Structure

Your database should look like this:

```
conditions: {
  temp: 
  hum: 
  light:
  pow: }
```

Missing values will automatically display as `--` in the app.

---

## 🖼️ UI Preview

📱 2×2 Grid layout:

```
+--------------+-------------+
| Temperature  | Humidity    |
+--------------+-------------+
| Light Level  | Power       |
+--------------+-------------+
```
## 🎥 Demo (Embedded Video)

<video width="100%" controls>
  <source src="https://github.com/KPabsy/RoomSync_MobileApp/raw/main/roomsync%20app.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>

---

## 📁 Project Structure (simplified)

```
lib/
├── main.dart                # Main UI and Firebase logic
├── firebase_options.dart    # Auto-generated Firebase config

```

## 🙌 Credits

Developed by \Kavindu Pabasara using [Flutter](https://flutter.dev) and [Firebase](https://firebase.google.com).



