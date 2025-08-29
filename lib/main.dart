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

  // Sample menu data - easily customizable
  final List<MenuItem> menuItems = [
    // Starters
    MenuItem(
      name: 'Paneer Tikka',
      price: 180,
      description: 'Marinated cottage cheese grilled to perfection with bell peppers and onions',
      tags: ['Veg'],
      category: 'Starters',
    ),

    MenuItem(
      name: 'Samosa Chat',
      price: 120,
      description: 'Crispy samosas topped with yogurt, chutneys, and fresh herbs',
      tags: ['Veg'],
      category: 'Starters',
    ),
    
    // Main Course

    MenuItem(
      name: 'Paneer Makhani',
      price: 280,
      description: 'Cottage cheese cubes in creamy tomato and cashew gravy',
      tags: ['Veg'],
      category: 'Main Course',
    ),

    MenuItem(
      name: 'Dal Tadka',
      price: 160,
      description: 'Yellow lentils tempered with cumin, garlic, and fresh herbs',
      tags: ['Veg'],
      category: 'Main Course',
    ),
    
    // Rice & Bread


    MenuItem(
      name: 'Vegetable Biryani',
      price: 220,
      description: 'Aromatic rice with mixed vegetables and traditional spices',
      tags: ['Veg'],
      category: 'Rice & Bread',
    ),
    MenuItem(
      name: 'Butter Naan',
      price: 60,
      description: 'Soft, fluffy bread brushed with butter, baked in tandoor',
      tags: ['Veg'],
      category: 'Rice & Bread',
    ),
    MenuItem(
      name: 'Garlic Naan',
      price: 80,
      description: 'Naan bread topped with fresh garlic and cilantro',
      tags: ['Veg'],
      category: 'Rice & Bread',
    ),
    
    // Beverages
    MenuItem(
      name: 'Mango Lassi',
      price: 80,
      description: 'Creamy yogurt drink blended with fresh mango pulp',
      tags: ['Veg'],
      category: 'Beverages',
    ),
    MenuItem(
      name: 'Masala Chai',
      price: 40,
      description: 'Traditional Indian tea brewed with aromatic spices',
      tags: ['Veg'],
      category: 'Beverages',
    ),
    MenuItem(
      name: 'Fresh Lime Soda',
      price: 60,
      description: 'Refreshing lime juice with soda and a hint of black salt',
      tags: ['Veg'],
      category: 'Beverages',
    ),
    
    // Desserts
    MenuItem(
      name: 'Gulab Jamun',
      price: 80,
      description: 'Soft milk dumplings soaked in cardamom-flavored sugar syrup',
      tags: ['Veg'],
      category: 'Desserts',
    ),
    MenuItem(
      name: 'Kulfi',
      price: 70,
      description: 'Traditional Indian ice cream with cardamom and pistachios',
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
      filtered = filtered.where((item) => item.category == selectedCategory).toList();
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
          // App Bar with restaurant info
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Gopal Restaurant',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(blurRadius: 2, color: Colors.black26)],
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFFF6B6B),
                      Color(0xFFEE5A24),
                    ],
                  ),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.restaurant,
                        size: 50,
                        color: Colors.white70,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Authentic Indian Cuisine',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
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
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          
          // Menu Items
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = filteredItems[index];
                return MenuItemCard(item: item);
              },
              childCount: filteredItems.length,
            ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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