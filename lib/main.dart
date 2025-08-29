import 'package:flutter/material.dart';

void main() {
  runApp(const GopalMenuApp());
}

class GopalMenuApp extends StatelessWidget {
  const GopalMenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gopal Restaurant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: const Color(0xFFFF6B6B),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF6B6B)),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const MenuScreen(),
    );
  }
}

class MenuItem {
  final String name;
  final double price;
  final String description;
  final List<String> tags;
  final String category;

  MenuItem({
    required this.name,
    required this.price,
    required this.description,
    required this.tags,
    required this.category,
  });
}

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String selectedCategory = 'All';
  String searchQuery = '';
  final TextEditingController searchController = TextEditingController();

// 🍽️ Restaurant Menu Data
final List<MenuItem> menuItems = [
  // 🌟 Starters
  MenuItem(
    name: 'Paneer Tikka',
    price: 180,
    description: 'Marinated cottage cheese grilled with bell peppers and onions',
    tags: ['Veg', 'Spicy'],
    category: 'Starters',
  ),
  MenuItem(
    name: 'Hara Bhara Kabab',
    price: 150,
    description: 'Spinach and green peas patties with aromatic spices',
    tags: ['Veg'],
    category: 'Starters',
  ),
  MenuItem(
    name: 'Chicken 65',
    price: 220,
    description: 'Crispy fried chicken bites tossed with curry leaves & spices',
    tags: ['Non-Veg', 'Spicy'],
    category: 'Starters',
  ),
  MenuItem(
    name: 'Veg Manchurian',
    price: 160,
    description: 'Deep-fried veggie dumplings in tangy Indo-Chinese sauce',
    tags: ['Veg'],
    category: 'Starters',
  ),

  // 🍛 Main Course
  MenuItem(
    name: 'Butter Chicken',
    price: 320,
    description: 'Tender chicken in rich, buttery tomato gravy',
    tags: ['Non-Veg'],
    category: 'Main Course',
  ),
  MenuItem(
    name: 'Paneer Butter Masala',
    price: 280,
    description: 'Cottage cheese in creamy, mildly spiced tomato gravy',
    tags: ['Veg'],
    category: 'Main Course',
  ),
  MenuItem(
    name: 'Mutton Rogan Josh',
    price: 380,
    description: 'Slow-cooked mutton curry with Kashmiri spices',
    tags: ['Non-Veg'],
    category: 'Main Course',
  ),
  MenuItem(
    name: 'Chole Bhature',
    price: 200,
    description: 'Spiced chickpeas served with fluffy fried bread',
    tags: ['Veg'],
    category: 'Main Course',
  ),

  // 🍚 Rice & Bread
  MenuItem(
    name: 'Hyderabadi Biryani',
    price: 300,
    description: 'Fragrant basmati rice layered with spiced chicken and herbs',
    tags: ['Non-Veg'],
    category: 'Rice & Bread',
  ),
  MenuItem(
    name: 'Veg Pulao',
    price: 180,
    description: 'Aromatic rice cooked with seasonal vegetables',
    tags: ['Veg'],
    category: 'Rice & Bread',
  ),
  MenuItem(
    name: 'Butter Naan',
    price: 60,
    description: 'Soft, fluffy naan brushed with butter',
    tags: ['Veg'],
    category: 'Rice & Bread',
  ),
  MenuItem(
    name: 'Tandoori Roti',
    price: 40,
    description: 'Whole wheat flatbread baked in clay oven',
    tags: ['Veg'],
    category: 'Rice & Bread',
  ),

  // 🍹 Beverages
  MenuItem(
    name: 'Mango Lassi',
    price: 90,
    description: 'Refreshing yogurt drink blended with mango pulp',
    tags: ['Veg'],
    category: 'Beverages',
  ),
  MenuItem(
    name: 'Masala Chai',
    price: 40,
    description: 'Traditional tea brewed with milk and aromatic spices',
    tags: ['Veg'],
    category: 'Beverages',
  ),
  MenuItem(
    name: 'Cold Coffee',
    price: 120,
    description: 'Chilled coffee blended with milk & ice cream',
    tags: ['Veg'],
    category: 'Beverages',
  ),
  MenuItem(
    name: 'Virgin Mojito',
    price: 150,
    description: 'Lime, mint, and soda – the perfect cooler',
    tags: ['Veg'],
    category: 'Beverages',
  ),

  // 🍨 Desserts
  MenuItem(
    name: 'Gulab Jamun',
    price: 90,
    description: 'Soft dumplings soaked in sugar syrup',
    tags: ['Veg'],
    category: 'Desserts',
  ),
  MenuItem(
    name: 'Rasmalai',
    price: 110,
    description: 'Cottage cheese patties soaked in sweetened milk',
    tags: ['Veg'],
    category: 'Desserts',
  ),
  MenuItem(
    name: 'Brownie with Ice Cream',
    price: 150,
    description: 'Warm chocolate brownie served with vanilla ice cream',
    tags: ['Veg'],
    category: 'Desserts',
  ),
  MenuItem(
    name: 'Matka Kulfi',
    price: 100,
    description: 'Traditional Indian kulfi served in a clay pot',
    tags: ['Veg'],
    category: 'Desserts',
  ),
];


  List<String> get categories {
    final cats = menuItems.map((item) => item.category).toSet().toList();
    cats.insert(0, 'All');
    return cats;
  }

  List<MenuItem> get filteredItems {
    List<MenuItem> filtered = menuItems;

    // Filter by category
    if (selectedCategory != 'All') {
      filtered = filtered
          .where((item) => item.category == selectedCategory)
          .toList();
    }

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((item) {
        return item.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
            item.description.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/restaurant_banner.jpeg', // replace with your image path
                    fit: BoxFit.fill,
                  )
                ],
              ),
            ),
          ),

          // Search Bar
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.grey[50],
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search for dishes...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            searchController.clear();
                            setState(() {
                              searchQuery = '';
                            });
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
          ),

          // Category Tabs
          SliverToBoxAdapter(
            child: Container(
              height: 50,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = category == selectedCategory;

                  return Container(
                    margin: const EdgeInsets.only(right: 12),
                    child: FilterChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      backgroundColor: Colors.grey[200],
                      selectedColor: Theme.of(context).primaryColor,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Menu Items
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final item = filteredItems[index];
              return MenuItemCard(item: item);
            }, childCount: filteredItems.length),
          ),

          // Footer
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.only(top: 20),
              color: Colors.grey[800],
              child: const Column(
                children: [
                  Text(
                    '📞 +91 7000391986',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '© 2024 Gopal Restaurant',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItemCard extends StatelessWidget {
  final MenuItem item;

  const MenuItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item name and price
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Text(
                  '₹${item.price.toInt()}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Description
            Text(
              item.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),

            const SizedBox(height: 12),

            // Tags
            Wrap(
              spacing: 8,
              children: item.tags.map((tag) {
                Color tagColor;
                Color textColor;

                switch (tag.toLowerCase()) {
                  case 'veg':
                    tagColor = Colors.green[100]!;
                    textColor = Colors.green[800]!;
                    break;
                  case 'non-veg':
                    tagColor = Colors.red[100]!;
                    textColor = Colors.red[800]!;
                    break;
                  case 'spicy':
                    tagColor = Colors.orange[100]!;
                    textColor = Colors.orange[800]!;
                    break;
                  default:
                    tagColor = Colors.blue[100]!;
                    textColor = Colors.blue[800]!;
                }

                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: tagColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
