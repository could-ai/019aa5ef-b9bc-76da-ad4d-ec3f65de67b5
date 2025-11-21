import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard Admin',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        fontFamily: 'Roboto', // Standard web font feel
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 1. Navigation Bar
          const AdminNavBar(),
          
          // 2. Main Content Area
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 3. Alert Message
                    const AlertBanner(),
                    
                    const SizedBox(height: 30),
                    
                    // 4. Title
                    const Text(
                      'Liste des utilisateurs',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w400, // Slightly lighter than bold as per screenshot
                        color: Colors.black87,
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // 5. Users Table
                    const UsersTable(),
                    
                    const SizedBox(height: 20),
                    
                    // 6. Pagination
                    const PaginationControls(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Components ---

class AdminNavBar extends StatelessWidget {
  const AdminNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF343A40), // Bootstrap dark bg
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          const Text(
            'Admin Panel',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 30),
          _NavBarItem(title: 'Tableau de bord', isActive: false),
          const SizedBox(width: 20),
          _NavBarItem(title: 'Utilisateurs', isActive: true, hasDropdown: true),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final bool hasDropdown;

  const _NavBarItem({
    required this.title,
    this.isActive = false,
    this.hasDropdown = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white70 : Colors.grey,
            fontSize: 16,
          ),
        ),
        if (hasDropdown) ...[
          const SizedBox(width: 4),
          Icon(
            Icons.arrow_drop_down,
            color: isActive ? Colors.white70 : Colors.grey,
            size: 18,
          ),
        ],
      ],
    );
  }
}

class AlertBanner extends StatelessWidget {
  const AlertBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFF8D7DA), // Bootstrap danger bg
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xFFF5C6CB)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Une erreur s'est produite lors du chargement des données !",
            style: TextStyle(
              color: Color(0xFF721C24), // Bootstrap danger text
              fontSize: 16,
            ),
          ),
          Icon(
            Icons.close,
            color: const Color(0xFF721C24).withOpacity(0.5),
            size: 20,
          ),
        ],
      ),
    );
  }
}

class UsersTable extends StatelessWidget {
  const UsersTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DataTable(
        headingRowColor: MaterialStateProperty.all(Colors.white),
        dataRowColor: MaterialStateProperty.all(Colors.white),
        columnSpacing: 20,
        horizontalMargin: 20,
        columns: const [
          DataColumn(
            label: Text(
              'Nom',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          DataColumn(
            label: Text(
              'Email',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          DataColumn(
            label: Text(
              'Statut',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
        rows: [
          _buildDataRow('Omar', 'omar@example.com', true),
          _buildDataRow('Kaoutar', 'kaoutar@example.com', false),
        ],
      ),
    );
  }

  DataRow _buildDataRow(String name, String email, bool isActive) {
    return DataRow(
      cells: [
        DataCell(Text(name, style: const TextStyle(fontSize: 15))),
        DataCell(Text(email, style: const TextStyle(fontSize: 15, color: Colors.black54))),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFF28A745) : const Color(0xFFDC3545), // Bootstrap success/danger
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              isActive ? 'Actif' : 'Inactif',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PaginationControls extends StatelessWidget {
  const PaginationControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _PageButton(text: 'Précédent', isDisabled: true),
        _PageButton(text: '1', isActive: true),
        _PageButton(text: '2'),
        _PageButton(text: 'Suivant'),
      ],
    );
  }
}

class _PageButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final bool isDisabled;

  const _PageButton({
    required this.text,
    this.isActive = false,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    // Colors
    final Color bgColor = isActive 
        ? const Color(0xFF007BFF) // Active Blue
        : isDisabled 
            ? const Color(0xFFE9ECEF) // Disabled Grey
            : Colors.white;
            
    final Color textColor = isActive 
        ? Colors.white 
        : isDisabled 
            ? const Color(0xFF6C757D) // Disabled Text
            : const Color(0xFF007BFF); // Link Blue
            
    final Color borderColor = isActive 
        ? const Color(0xFF007BFF) 
        : const Color(0xFFDEE2E6);

    // Radius logic for group look (simplified here to all rounded or specific)
    // In bootstrap, left is rounded-left, right is rounded-right.
    // For simplicity, we'll just use a small margin or connect them.
    
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 14,
        ),
      ),
    );
  }
}
