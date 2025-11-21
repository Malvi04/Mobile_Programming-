import 'package:flutter/material.dart';
import 'loan_form_page.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF667EEA),
              Color(0xFF764BA2),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                // Header dengan back button
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(51),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Pilih Layanan',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Header Content
                const Text(
                  'Apa yang ingin Anda lakukan?',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.3,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 8),

                Text(
                  'Pilih jenis layanan yang sesuai dengan kebutuhan Anda',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withAlpha(204),
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 50),

                // Pinjam Buku Card
                _buildServiceCard(
                  icon: Icons.book_rounded,
                  title: 'Pinjam Buku',
                  subtitle: 'Pinjam buku fisik untuk dibawa pulang',
                  color: Colors.white,
                  iconColor: const Color(0xFF667EEA),
                  onTap: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const LoanFormPage())
                    );
                  },
                ),

                const SizedBox(height: 20),

                // Baca di Tempat Card
                _buildServiceCard(
                  icon: Icons.menu_book_rounded,
                  title: 'Baca di Tempat',
                  subtitle: 'Baca buku digital di perpustakaan',
                  color: Colors.white,
                  iconColor: const Color(0xFF764BA2),
                  onTap: () {
                    _showComingSoon(context, 'Baca di Tempat');
                  },
                ),

                const SizedBox(height: 20),

                // Daftar Buku Card (Bonus)
                _buildServiceCard(
                  icon: Icons.list_alt_rounded,
                  title: 'Lihat Katalog',
                  subtitle: 'Jelajahi koleksi buku tersedia',
                  color: Colors.white,
                  iconColor: const Color(0xFF10B981),
                  onTap: () {
                    _showComingSoon(context, 'Lihat Katalog');
                  },
                ),

                const Spacer(),

                // Additional info
                Text(
                  'Pilih layanan untuk melanjutkan',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(153),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  void _showComingSoon(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Fitur Segera Hadir',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF667EEA),
          ),
        ),
        content: Text(
          'Fitur "$feature" sedang dalam pengembangan dan akan segera tersedia.',
          style: const TextStyle(color: Colors.black87),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Mengerti',
              style: TextStyle(color: Color(0xFF667EEA)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(51),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                // Icon Container
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        iconColor.withAlpha(25),
                        iconColor.withAlpha(51),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 32,
                  ),
                ),
                
                const SizedBox(width: 20),
                
                // Text Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3748),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Arrow
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFF667EEA).withAlpha(25),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    color: const Color(0xFF667EEA),
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}