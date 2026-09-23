# 🌶️ SPICE STREET - Online Restaurant Ordering & Kitchen Dashboard

> **Good Food • Great Mood**  
> Authentic Indian Flavours, Dum Biryanis, Fiery Starters, Rich Curries, Chilled Beverages & Fresh Desserts.

---

## 🌟 Live Demo & Free Domain Deployment
- **Customer Storefront**: `https://<your-username>.github.io/spice-street/` (or `index.html`)
- **Live Kitchen Operations Dashboard**: `https://<your-username>.github.io/spice-street/dashboard.html`

---

## 🚀 Key Features

### 1. 💳 Full Online Payment Suite
- **UPI ID**: `8341643180@ptyes`
- **Supported Payment Methods**:
  - 🔵 **Google Pay (G Pay)**
  - 🟣 **PhonePe**
  - 🔷 **Paytm UPI & Wallet**
  - ⚡ **Dynamic UPI QR Code Scanner** (BHIM, Cred, Amazon Pay, Any Bank App)
  - 💳 **Credit & Debit Cards** (with live virtual card animation and 3D Secure OTP)
  - 💵 **Cash on Delivery (COD)**
- **Direct WhatsApp Auto-Redirect**: Immediately forwards the verified paid order receipt to WhatsApp upon payment completion.

### 2. 🏍️ 3rd-Party Delivery Rider Auto-Connect (Zomato & Swiggy Fleet)
- **Auto-Dispatch Engine**: Automatically searches and connects the nearest **Zomato Fleet** or **Swiggy Fleet** rider within 1.5–2 seconds of order confirmation.
- **1-Click WhatsApp to Rider**: Instantly formats and sends the customer's delivery address, phone, and food package details to the rider.
- **Customer Live Tracking**: Displays live delivery partner cards with vehicle number, star rating, and direct call/WhatsApp buttons.

### 3. 🔔 Realtime Kitchen Dashboard & Audio Buzzer
- Plays a realistic commercial 3-tone kitchen chime + buzzer when a new order arrives.
- Real-time Supabase cloud synchronization and live order stage updates.
- Thermal Kitchen Order Ticket (KOT) print preview.

---

## 📂 Project Architecture
```
├── index.html              # Customer ordering website & checkout
├── dashboard.html          # Kitchen operations dashboard
├── .github/
│   └── workflows/
│       └── deploy.yml      # GitHub Actions auto-deployment to free domain
├── css/
│   ├── styles.css          # Storefront design system & styling
│   └── dashboard.css       # Kitchen dashboard styling
├── js/
│   ├── app.js              # Application core & checkout logic
│   ├── cart.js             # Shopping cart state management
│   ├── checkout.js         # Validation & order creation
│   ├── dashboard.js        # Kitchen dashboard & auto-dispatch
│   ├── data.js             # Menu catalog & restaurant information
│   └── tracking.js         # 5-stage order tracking
└── assets/                 # High-resolution food photography
```

---

## 🌐 Free Domain Deployment via GitHub Pages
1. Push this repository to GitHub: `git push origin main`
2. Go to repository **Settings** → **Pages**.
3. Under **Build and deployment** → **Source**, select **GitHub Actions** (or Deploy from branch: `main` / root).
4. Your website is automatically live on your free domain:
   👉 **`https://<your-username>.github.io/spice-street/`**
