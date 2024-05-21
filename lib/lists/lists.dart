import 'package:flutter/material.dart';

List<Map<String , dynamic>> ProductList = [
  {
    "id": null,
    "image": "images/l1.png",
    "name": "Hp Victus",
    "desc": "Intel i5-13420H 8-Cores",
    "longdesc":
        "Hp Victus 15-fa1093dx Gaming Laptop - 13th Intel i5-13420H 8-Cores, 6GB GDDR6 NVIDIA GeForce RTX 3050 Graphics, 8GB RAM, 512GB SSD, 15.6 FHD (1920x1080) 144 Hz IPS, Backlit Keyboard, Windows 11, Blue ",
    "price": 35999 ,
    "categoryID": 1,
  },
  {
    "id": null,
    "image": "images/l2.png",
    "name": "Lenovno ideapad",
    "desc": "Intel® Core™ i7-1255U",
    "longdesc":
        "Lenovo IdeaPad 1 82QD008LED/ Intel® Core™ i7-1255U/8GB Ram/512 SSD/Intel® Iris® Xe Graphics/Win11/Abyss Blue/ 2 Years Warranty ",
    "price": 29900 ,
    "categoryID": 1,
  },
  {
    "id": null,
    "image": "images/l3.png",
    "name": "MacBook",
    "desc": "Apple 2022 MacBook Air",
    "longdesc":
        "Apple 2022 MacBook Air laptop with M2 chip: 13.6-inch Liquid Retina display, 8GB RAM, 256GB SSD storage, 1080p FaceTime HD camera. Works with iPhone and iPad Space Grey",
    "price": 57950 ,
    "categoryID": 1,
  },
  {
    "id": null,
    "image": "images/m3.png",
    "name": "Iphone 14 ",
    "desc": "ios 16, 5G , 128 GB",
    "longdesc":
        "Apple iPhone 14 (128 GB) - Midnight, Bluetooth, Wi-Fi, USB Operating System 	iOS 16 , Cellular Technology 	5G , Memory Storage Capacity 	128 GB , Color Midnight,Screen Size 	6.1 Inches",
    "price": 35900 ,
    "categoryID": 2,
  },
  {
    "id": null,
    "image": "images/m4.png",
    "name": "Samsung Galaxy A54 ",
    "desc": "Dual SIM Mobile Phone Android",
    "longdesc":
        "Samsung Galaxy A54 - Dual SIM Mobile Phone Android, 8GB RAM, 128GB, 5G, Awesome Lime ",
    "price": 13599 ,
    "categoryID": 2,
  },
  {
    "id": null,
    "image": "images/m5.png",
    "name": "POCO C65 Dual SIM ",
    "desc": "Blue 8GB RAM 256GB 4G ",
    "longdesc":
        "POCO C65 Dual SIM Blue 8GB RAM 256GB 4G - Global Version , Color 	Blue , Screen Size 	6.74 Inches",
    "price": 7880 ,
    "categoryID": 2,
  },
  {
    "id": null,
    "image": "images/m1.png",
    "name": "iphone 15 pro max",
    "desc": "ios 12, 4G , 256 GB",
    "longdesc": "Apple iPhone 15 Pro Max (256 GB) - Natural Titanium ",
    "price": 69900 ,
    "categoryID": 2,
  },
  {
    "id": null,
    "image": "images/h3.png",
    "name": "Redragon H270",
    "desc": "RGB Gaming Headset with Microphone",
    "longdesc":
        "Redragon H270 RGB Gaming Headset with Microphone, Wired, Compatible with Xbox One, Nintendo Switch, PS4, PS5, PC, Laptops and Nintendo Switch (Black) ",
    "price": 1299 ,
    "categoryID": 3,
  },
  {
    "id": null,
    "image": "images/h2.png",
    "name": "Anker P20i",
    "desc": "soundcore by Anker P20i Headphones In-Ear",
    "longdesc":
        "soundcore by Anker P20i Headphones In-Ear, 10 mm Driver, Bluetooth 5.3, Adjustable EQ, 30 Hours Playtime, IPX5 Waterproof, 2 Micros with AI, Can be Used Individually + 18 Months Local Warranty ",
    "price": 1299 ,
    "categoryID": 3,
  },
  {
    "id": null,
    "image": "images/h1.png",
    "name": "JPL",
    "desc": "tune 510 headphone",
    "longdesc":
        "JBL Tune 520BT Wireless On-Ear Headphones, Pure Bass Sound, 57H Battery with Speed Charge, Hands-Free Call + Voice Aware, Multi-Point Connection, Lightweight and Foldable - Blue, JBLT520BTBLUEU ",
    "price": 2050 ,
    "categoryID": 3,
  },
  {
    "id": null,
    "image": "images/w3.png",
    "name": "Apple Watch Series 9",
    "desc": "Smartwatch with Midnight Aluminum ",
    "longdesc":
        "Apple Watch Series 9 [GPS 41mm] Smartwatch with Midnight Aluminum Case with Midnight Sport Loop. Fitness Tracker, Blood Oxygen & ECG Apps, Always-On Retina Display, Carbon Neutral ",
    "price": 20450 ,
    "categoryID": 4,
  },
  {
    "id": null,
    "image": "images/w1.png",
    "name": "Amazfit BIP 3 Pro",
    "desc": "Sport Smart Watch ",
    "longdesc":
        "Amazfit BIP 3 Pro Sport Smart Watch 1.69 Large Color Display 4 Satellite Positioning System | 60+ Sports Mode Fitness Blood Oxygen Measurement 5 ATM Waterproof 14 Days Battery Life - Pink ",
    "price": 2249 ,
    "categoryID": 4,
  },
  {
    "id": null,
    "image": "images/w2.png",
    "name": "T800 Ultra NFC",
    "desc": "Smart Watch Bluetooth ",
    "longdesc":
        "T800 Ultra NFC Smart Watch Bluetooth Call Wireless Charging Sport Smartwatch (Orange) ",
    "price": 490 ,
    "categoryID": 4,
  },
];


List<Map<String , dynamic>>CategoryList = [
  {
    'id': 1,
    'name': 'Laptop',
    'icon': Icons.laptop,
  },
  {
    'id': 2,
    'name': 'Mobile',
    'icon': Icons.mobile_friendly_rounded,
  },
  {
    'id': 3,
    'name': 'Headphone',
    'icon': Icons.headphones,
  },
  {
    'id': 4,
    'name': 'Watch',
    'icon': Icons.watch,
  },
];
