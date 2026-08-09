import 'package:flutter/material.dart';

void main() {
  runApp(const HudhudakApp());
}

class HudhudakApp extends StatelessWidget {
  const HudhudakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'هدهدك',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        scaffoldBackgroundColor: const Color(0xFFFFFBF5),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFAE17),
          brightness: Brightness.light,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tab = 0;

  final cities = const [
    City('مشهد', 'حرم الإمام الرضا', Icons.mosque),
    City('قم', 'حرم السيدة معصومة', Icons.account_balance),
    City('طهران', 'عاصمة إيران', Icons.location_city),
    City('شيراز', 'مدينة الورود', Icons.local_florist),
    City('أصفهان', 'نصف جهان', Icons.account_balance),
    City('شمال إيران', 'طبيعة خلابة', Icons.landscape),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const Icon(Icons.menu_rounded),
          title: const Text(
            'هدهدك',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_rounded),
            ),
          ],
        ),
        body: IndexedStack(
          index: tab,
          children: [
            _home(),
            const SearchPage(),
            const BookingsPage(),
            const FavoritesPage(),
            const ProfilePage(),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: tab,
          onDestinationSelected: (v) => setState(() => tab = v),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'الرئيسية'),
            NavigationDestination(icon: Icon(Icons.search), label: 'بحث'),
            NavigationDestination(icon: Icon(Icons.calendar_month_outlined), label: 'حجوزاتي'),
            NavigationDestination(icon: Icon(Icons.favorite_border), label: 'المفضلة'),
            NavigationDestination(icon: Icon(Icons.person_outline), label: 'حسابي'),
          ],
        ),
      ),
    );
  }

  Widget _home() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
      children: [
        const Text(
          'احجز فندقك في إيران بسهولة',
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 6),
        Text(
          'أفضل الفنادق وبأسعار مناسبة',
          style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
        ),
        const SizedBox(height: 18),
        _searchCard(),
        const SizedBox(height: 24),
        _sectionTitle('اكتشف أفضل المدن في إيران'),
        const SizedBox(height: 12),
        SizedBox(
          height: 150,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: cities.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (_, i) => _cityCard(cities[i]),
          ),
        ),
        const SizedBox(height: 26),
        _sectionTitle('فنادق مقترحة لك'),
        const SizedBox(height: 12),
        ...sampleHotels.map((h) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: HotelCard(hotel: h),
        )),
      ],
    );
  }

  Widget _searchCard() {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _field(Icons.location_on_outlined, 'إلى أين تريد أن تذهب؟', 'مثال: مشهد، قم، طهران...'),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: _field(Icons.login_rounded, 'تاريخ الوصول', '10 أغسطس 2026')),
                const SizedBox(width: 10),
                Expanded(child: _field(Icons.logout_rounded, 'تاريخ المغادرة', '13 أغسطس 2026')),
              ],
            ),
            const SizedBox(height: 10),
            _field(Icons.people_outline, 'الضيوف والغرف', '2 ضيوف • غرفة واحدة'),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: FilledButton.icon(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SearchPage()),
                ),
                icon: const Icon(Icons.search),
                label: const Text('ابحث عن الفنادق', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(IconData icon, String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFFFA800)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 3),
                Text(value, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(text, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900));
  }

  Widget _cityCard(City city) {
    return Container(
      width: 145,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFC247), Color(0xFFFFA400)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white.withOpacity(.9),
            child: Icon(city.icon, color: const Color(0xFF9A5C00)),
          ),
          Text(city.name, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w900)),
          Text(city.subtitle, style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('نتائج البحث', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
          const SizedBox(height: 6),
          Text('مشهد • 10 - 13 أغسطس • 2 ضيوف', style: TextStyle(color: Colors.grey.shade600)),
          const SizedBox(height: 18),
          ...sampleHotels.map((h) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: HotelCard(hotel: h, detailed: true),
          )),
        ],
      ),
    );
  }
}

class HotelCard extends StatelessWidget {
  final Hotel hotel;
  final bool detailed;
  const HotelCard({super.key, required this.hotel, this.detailed = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => HotelDetailsPage(hotel: hotel)),
      ),
      child: Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            Container(
              width: detailed ? 125 : 105,
              height: detailed ? 145 : 115,
              color: const Color(0xFFFFD477),
              child: const Icon(Icons.hotel_rounded, size: 48, color: Color(0xFF9A5C00)),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(hotel.name, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text('⭐ ${hotel.rating} • ${hotel.distance}', style: TextStyle(color: Colors.grey.shade600)),
                    const SizedBox(height: 5),
                    Text(hotel.description, maxLines: 2, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 8),
                    Text('${hotel.price} د.ع / ليلة', style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF159447))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HotelDetailsPage extends StatelessWidget {
  final Hotel hotel;
  const HotelDetailsPage({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('تفاصيل الفندق')) ,
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              height: 220,
              decoration: BoxDecoration(
                color: const Color(0xFFFFD477),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Center(child: Icon(Icons.hotel, size: 90, color: Color(0xFF9A5C00))),
            ),
            const SizedBox(height: 16),
            Text(hotel.name, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
            const SizedBox(height: 5),
            Text('⭐ ${hotel.rating} • ${hotel.distance}', style: TextStyle(color: Colors.grey.shade700)),
            const SizedBox(height: 18),
            const Text('المرافق', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900)),
            const SizedBox(height: 10),
            const Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                Chip(label: Text('Wi-Fi مجاني'), avatar: Icon(Icons.wifi, size: 18)),
                Chip(label: Text('إفطار'), avatar: Icon(Icons.restaurant, size: 18)),
                Chip(label: Text('موقف سيارات'), avatar: Icon(Icons.local_parking, size: 18)),
                Chip(label: Text('تكييف'), avatar: Icon(Icons.ac_unit, size: 18)),
              ],
            ),
            const SizedBox(height: 22),
            const Text('الغرف المتاحة', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900)),
            const SizedBox(height: 10),
            RoomTile(name: 'غرفة مزدوجة', price: 85000),
            RoomTile(name: 'غرفة ثلاثية', price: 120000),
            RoomTile(name: 'جناح عائلي', price: 160000),
          ],
        ),
      ),
    );
  }
}

class RoomTile extends StatelessWidget {
  final String name;
  final int price;
  const RoomTile({super.key, required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.bed)),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('$price د.ع / ليلة'),
        trailing: FilledButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => BookingPage(roomName: name, price: price)),
          ),
          child: const Text('احجز الآن'),
        ),
      ),
    );
  }
}

class BookingPage extends StatelessWidget {
  final String roomName;
  final int price;
  const BookingPage({super.key, required this.roomName, required this.price});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('تأكيد الحجز')),
        body: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('فندق قصر الضيافة', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900)),
              const SizedBox(height: 6),
              Text('مشهد • إيران', style: TextStyle(color: Colors.grey.shade700)),
              const SizedBox(height: 20),
              _row('تاريخ الوصول', '10 أغسطس 2026'),
              _row('تاريخ المغادرة', '13 أغسطس 2026'),
              _row('الغرفة', roomName),
              _row('الضيوف', '2 ضيوف'),
              _row('المبلغ الإجمالي', '${price * 3} د.ع'),
              const Spacer(),
              SizedBox(
                height: 54,
                child: FilledButton(
                  onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const SuccessPage()),
                  ),
                  child: const Text('تأكيد الحجز', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _row(String a, String b) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 9),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(a, style: TextStyle(color: Colors.grey.shade600)),
        Flexible(child: Text(b, style: const TextStyle(fontWeight: FontWeight.bold))),
      ],
    ),
  );
}

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 44,
                  backgroundColor: Color(0xFFE6F7EA),
                  child: Icon(Icons.check_rounded, size: 55, color: Color(0xFF1BA24A)),
                ),
                const SizedBox(height: 20),
                const Text('تم تأكيد حجزك بنجاح', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
                const SizedBox(height: 10),
                const Text('رقم الحجز: HDK-58291', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 26),
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: const Icon(Icons.qr_code_2, size: 160),
                ),
                const SizedBox(height: 20),
                const Text('يمكنك عرض هذا الرمز عند الوصول إلى الفندق.'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BookingsPage extends StatelessWidget {
  const BookingsPage({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text('حجوزاتي', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)));
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text('المفضلة', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)));
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text('حسابي', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)));
}

class City {
  final String name;
  final String subtitle;
  final IconData icon;
  const City(this.name, this.subtitle, this.icon);
}

class Hotel {
  final String name;
  final double rating;
  final String distance;
  final int price;
  final String description;
  const Hotel(this.name, this.rating, this.distance, this.price, this.description);
}

const sampleHotels = [
  Hotel('فندق قصر الضيافة', 4.7, '800 م من الحرم', 75000, 'قريب من حرم الإمام الرضا وخدمات مناسبة للعائلات'),
  Hotel('فندق الماس 1', 4.5, '1.2 كم من الحرم', 68000, 'إقامة مريحة وموقع مناسب للزوار'),
  Hotel('فندق جواد', 4.3, '900 م من الحرم', 62000, 'غرف مريحة وخدمة استقبال على مدار الساعة'),
];
