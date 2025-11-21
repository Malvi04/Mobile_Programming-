import 'package:flutter/material.dart';
import 'category_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLogin = true;
  
  // Login Controllers
  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();
  
  // Register Controllers
  final _registerNameController = TextEditingController();
  final _registerEmailController = TextEditingController();
  final _registerPasswordController = TextEditingController();
  final _registerConfirmPasswordController = TextEditingController();
  
  bool _isLoading = false;

  void _submitForm(BuildContext context) {
    if (_isLogin) {
      _login(context);
    } else {
      _register(context);
    }
  }

  void _login(BuildContext context) {
    if (_loginEmailController.text.isEmpty || _loginPasswordController.text.isEmpty) {
      _showErrorDialog(context, 'Harap isi email dan password');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
      
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const CategoryPage()),
      );
    });
  }

  void _register(BuildContext context) {
    if (_registerNameController.text.isEmpty || 
        _registerEmailController.text.isEmpty || 
        _registerPasswordController.text.isEmpty ||
        _registerConfirmPasswordController.text.isEmpty) {
      _showErrorDialog(context, 'Harap isi semua field');
      return;
    }

    if (_registerPasswordController.text != _registerConfirmPasswordController.text) {
      _showErrorDialog(context, 'Password dan konfirmasi password tidak sama');
      return;
    }

    if (_registerPasswordController.text.length < 6) {
      _showErrorDialog(context, 'Password minimal 6 karakter');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
      
      // Auto switch to login after successful registration
      setState(() {
        _isLogin = true;
      });
      
      // ignore: use_build_context_synchronously
      _showSuccessDialog(context, 'Registrasi berhasil! Silakan login.');
    });
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Warning',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF667EEA),
          ),
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'OK',
              style: TextStyle(color: Color(0xFF667EEA)),
            ),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Sukses',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF10B981),
          ),
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'OK',
              style: TextStyle(color: Color(0xFF10B981)),
            ),
          ),
        ],
      ),
    );
  }

  void _switchMode() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

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
          child: Column(
            children: [
              // Back Button
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
              ),

              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    Text(
                      _isLogin ? 'Masuk ke Akun' : 'Buat Akun Baru',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _isLogin 
                        ? 'Silakan masuk untuk mengakses perpustakaan digital'
                        : 'Daftar untuk mulai menggunakan perpustakaan digital',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withAlpha(200),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Form Container - Ini yang kita bikin expandable
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        // Register Name Field (only show when registering)
                        if (!_isLogin) ...[
                          TextField(
                            controller: _registerNameController,
                            decoration: const InputDecoration(
                              labelText: 'Nama Lengkap',
                              prefixIcon: Icon(Icons.person_rounded),
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF667EEA)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],

                        // Email Field
                        TextField(
                          controller: _isLogin ? _loginEmailController : _registerEmailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email_rounded),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF667EEA)),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),

                        const SizedBox(height: 20),

                        // Password Field
                        TextField(
                          controller: _isLogin ? _loginPasswordController : _registerPasswordController,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock_rounded),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF667EEA)),
                            ),
                          ),
                          obscureText: true,
                        ),

                        const SizedBox(height: 20),

                        // Confirm Password Field (only show when registering)
                        if (!_isLogin) ...[
                          TextField(
                            controller: _registerConfirmPasswordController,
                            decoration: const InputDecoration(
                              labelText: 'Konfirmasi Password',
                              prefixIcon: Icon(Icons.lock_outline_rounded),
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF667EEA)),
                              ),
                            ),
                            obscureText: true,
                          ),
                          const SizedBox(height: 20),
                        ],

                        const SizedBox(height: 30),

                        // Submit Button
                        Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF4F46E5).withAlpha(100),
                                blurRadius: 15,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : () => _submitForm(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF667EEA),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              disabledBackgroundColor: Colors.grey,
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  )
                                : Text(
                                    _isLogin ? 'Masuk' : 'Daftar',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Switch Mode
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _isLogin ? 'Belum punya akun?' : 'Sudah punya akun?',
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: _isLoading ? null : _switchMode,
                              child: Text(
                                _isLogin ? 'Daftar di sini' : 'Masuk di sini',
                                style: const TextStyle(
                                  color: Color(0xFF667EEA),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 40),

                        // Footer
                        Text(
                          'Perpustakaan Digital v1.0',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _registerNameController.dispose();
    _registerEmailController.dispose();
    _registerPasswordController.dispose();
    _registerConfirmPasswordController.dispose();
    super.dispose();
  }
}