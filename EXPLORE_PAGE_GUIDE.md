# 🔍 Zomato-Style Explore Page

## ✅ Created!

Beautiful Explore page with Zomato-inspired design featuring location badge, search bar, and video/image background!

---

## 🎨 **Design Features:**

### **1. Header Section (30% height):**
✅ **Background video/image/GIF** support
✅ **Gradient overlay** for better text visibility
✅ **Placeholder image** from Unsplash (food)
✅ **Fallback** if image fails to load

### **2. Location Badge (Top-left):**
✅ **Location icon** (green)
✅ **City name** (Mumbai, Maharashtra)
✅ **Dropdown arrow** indicator
✅ **Rounded badge** with shadow
✅ **White background** (95% opacity)
✅ **Tap to change** location

### **3. Profile Icon (Top-right):**
✅ **Circular badge** with "D" initial
✅ **White background** with shadow
✅ **Green text** (brand color)
✅ **40x40px** size
✅ **Tap to open** menu/profile

### **4. Search Bar (Row 2):**
✅ **Read-only** (taps to open search page)
✅ **Search icon** (prefix)
✅ **Mic icon** (suffix) for voice search
✅ **White background** with shadow
✅ **Rounded corners** (12px)
✅ **Placeholder text**: "Search for restaurants, dishes..."

### **5. Layout:**
✅ **SliverAppBar** - Floating transparent header
✅ **Stack** - Background behind scroll content
✅ **Positioned search** - Overlaps gradient
✅ **Scrollable content** area below

---

## 📐 **Visual Structure:**

```
┌──────────────────────────────────┐
│ 🌆 Video/Image/GIF Background    │ ← 30% height
│   (with gradient overlay)        │
│                                  │
│ 📍 Mumbai, Maharashtra    [D]    │ ← Location + Profile
│                                  │
├──────────────────────────────────┤
│  🔍 Search for restaurants...🎤  │ ← Search bar (overlaps)
├──────────────────────────────────┤
│                                  │
│   Content Area                   │ ← Scrollable content
│   (Ready for your design)        │
│                                  │
└──────────────────────────────────┘
```

---

## 🎥 **Adding Video/Image/GIF:**

### **Option 1: Local Image**
```dart
// 1. Add to pubspec.yaml
flutter:
  assets:
    - assets/images/explore_bg.jpg
    - assets/videos/food_clip.mp4

// 2. Use in code
Image.asset(
  'assets/images/explore_bg.jpg',
  fit: BoxFit.cover,
)
```

### **Option 2: Network Image (Current)**
```dart
Image.network(
  'https://images.unsplash.com/photo-1504674900247-0877df9cc836',
  fit: BoxFit.cover,
)
```

### **Option 3: GIF**
```dart
Image.network(
  'https://your-gif-url.gif',
  fit: BoxFit.cover,
)
// or
Image.asset('assets/gifs/food.gif', fit: BoxFit.cover)
```

### **Option 4: Video (Auto-play)**

**Add package:**
```yaml
dependencies:
  video_player: ^2.8.0
```

**Usage:**
```dart
import 'package:video_player/video_player.dart';

class _ExplorePageState extends State<ExplorePage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/food.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
        _controller.setVolume(0); // Mute
      });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Video background
        if (_controller.value.isInitialized)
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
        // Rest of UI...
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

---

## 🎨 **Customization:**

### **Change Location:**
```dart
LocationBadge(
  location: 'Delhi, NCR', // Change city
  onTap: () {
    // Show location picker
  },
)
```

### **Change Profile Initial:**
```dart
Text(
  'A', // Change from 'D' to any letter
  style: TextStyle(...),
)
```

### **Change Search Placeholder:**
```dart
SearchBarWidget(
  // In search_bar_widget.dart, change:
  'Search for food, restaurants...'
)
```

### **Change Header Height:**
```dart
final headerHeight = screenHeight * 0.4; // 40% instead of 30%
```

### **Change Background Opacity:**
```dart
Opacity(
  opacity: 0.5, // Change from 0.3
  child: Image.network(...),
)
```

---

## 📱 **Widget Components Created:**

### **1. LocationBadge** (`location_badge.dart`)
- Location icon (green)
- City name text
- Dropdown arrow
- Rounded badge with shadow
- Tap callback

### **2. SearchBarWidget** (`search_bar_widget.dart`)
- Search icon (prefix)
- Placeholder text
- Mic icon (suffix)
- Tap callbacks for search & voice
- Read-only design

---

## 🎯 **How It Works:**

### **1. Stack Layout:**
```dart
Stack(
  children: [
    Positioned(  // Background at top 30%
      top: 0,
      height: headerHeight,
      child: BackgroundMedia(),
    ),
    CustomScrollView(  // Scrollable content
      slivers: [
        SliverAppBar(...),  // Transparent header
        SliverToBoxAdapter(  // Search bar
          child: SearchBarWidget(),
        ),
        SliverList(...),  // Content
      ],
    ),
  ],
)
```

### **2. Transparent SliverAppBar:**
- `backgroundColor: Colors.transparent`
- `elevation: 0`
- `floating: true` (reappears on scroll up)
- Contains location badge + profile icon

### **3. Search Bar Positioning:**
```dart
padding: EdgeInsets.only(
  top: headerHeight - 100, // Overlaps gradient
)
```

---

## 🔥 **Features:**

| Feature | Status | Description |
|---------|--------|-------------|
| Location Badge | ✅ | Rounded, white, with icon |
| Profile Icon | ✅ | Circular "D" badge |
| Search Bar | ✅ | Read-only with mic |
| Background | ✅ | Image with gradient |
| Video Support | 📝 | Ready to add |
| GIF Support | ✅ | Works with Image.network |
| Scrolling | ✅ | SliverAppBar floats |
| Responsive | ✅ | 30% height adapts |

---

## 🎨 **Color Scheme:**

```dart
Location Badge:
- Background: White (95% opacity)
- Icon: Green (primary)
- Text: Dark gray (textPrimary)
- Shadow: Light

Profile Badge:
- Background: White (95% opacity)
- Text: Green (primary)
- Shadow: Light

Search Bar:
- Background: White
- Search Icon: Gray (textSecondary)
- Mic Icon: Green (primary)
- Text: Light gray (textHint)
- Shadow: Medium

Background:
- Gradient: Green gradient
- Image Opacity: 30%
- Overlay: Black gradient (30% → 60%)
```

---

## 🚀 **Test It Now:**

```bash
flutter run
```

**You'll see:**
1. ⏱️ Splash screen (3 seconds)
2. 🔍 **Explore page** with:
   - 🌆 Food image background (top 30%)
   - 📍 Location badge (Mumbai)
   - 👤 Profile icon (D)
   - 🔍 Search bar with mic icon
   - 📄 Scrollable content area

---

## 💡 **Next Steps:**

### **Add Content Below:**
```dart
SliverList(
  delegate: SliverChildListDelegate([
    // Categories
    CategorySection(),
    // Featured restaurants
    RestaurantsList(),
    // Special offers
    OffersCarousel(),
  ]),
)
```

### **Add Video:**
1. Add `video_player` package
2. Add video asset
3. Replace Image with VideoPlayer
4. Set auto-play + loop + mute

### **Add Real Location:**
1. Add `geolocator` package
2. Get current location
3. Reverse geocode to city name
4. Update LocationBadge

---

## 📊 **Performance:**

✅ **Optimized:**
- Image cached by Flutter
- Gradient is lightweight
- SliverAppBar efficient scrolling
- Minimal rebuilds

⚠️ **For Video:**
- Use low-res clips (< 5MB)
- Compress for mobile
- Consider data usage
- Lazy load when tab active

---

## ✨ **Zomato-Style Features:**

| Feature | Zomato | Your App | Status |
|---------|--------|----------|--------|
| Location badge | ✅ | ✅ | Done |
| Profile icon | ✅ | ✅ | Done |
| Search bar | ✅ | ✅ | Done |
| Voice search | ✅ | ✅ | Done |
| Background media | ✅ | ✅ | Done |
| Floating header | ✅ | ✅ | Done |

---

**Your Explore page is Zomato-ready! 🎉**

