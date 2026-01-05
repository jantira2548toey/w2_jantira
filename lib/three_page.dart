import 'package:flutter/material.dart';
import 'dart:math' as math;

class Threepage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ThreePage();
}

class ThreePage extends State<Threepage> with TickerProviderStateMixin {
  double pie = 3.14; // ใช้ค่า pi ที่แม่นยำขึ้น
  double radius = 0;
  double height = 0;
  double area = 0;

  TextEditingController radiusCtrl = TextEditingController();
  TextEditingController heightCtrl = TextEditingController();

  late AnimationController _animationController;
  late AnimationController _rotationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );
    _rotationController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    _rotationAnimation = Tween<double>(begin: 0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.linear),
    );
    _rotationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  // สไตล์ TextField ที่สวยงาม
  InputDecoration _getTextFieldStyle(String label, String hint, IconData icon) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.orange.shade400),
      filled: true,
      fillColor: Colors.white.withOpacity(0.9),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.orange.shade200, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.orange.shade400, width: 2),
      ),
      labelStyle: TextStyle(color: Colors.orange.shade700),
      hintStyle: TextStyle(color: Colors.grey.shade500),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    );
  }

  // ฟังก์ชันคำนวณ
  void _calculateArea() {
    radius = double.tryParse(radiusCtrl.text) ?? 0;
    height = double.tryParse(heightCtrl.text) ?? 0;

    setState(() {
      // สูตรพื้นที่ผิวทรงกรวย = π × r × (r + s) โดย s = √(r² + h²)
      area = pie * radius * (radius + height);
    });

    // เล่นแอนิเมชัน
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationAnimation.value,
                  child: Icon(Icons.change_history, color: Colors.white),
                );
              },
            ),
            SizedBox(width: 8),
            Text(
              '🔺 คำนวณทรงกรวย 🔺',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange.shade400, Colors.red.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.orange.shade50,
              Colors.red.shade50,
              Colors.pink.shade50,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  SizedBox(height: 20),

                  // การ์ดแสดงผลลัพธ์
                  AnimatedBuilder(
                    animation: _scaleAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Container(
                          padding: EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.white, Colors.orange.shade50],
                            ),
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.orange.withOpacity(0.3),
                                spreadRadius: 3,
                                blurRadius: 15,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // ไอคอนทรงกรวยแบบ animated
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.orange.shade300, Colors.red.shade300],
                                  ),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.orange.withOpacity(0.4),
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.change_history,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),

                              SizedBox(height: 20),

                              Text(
                                '🎯 ผลลัพธ์การคำนวณ 🎯',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange.shade800,
                                ),
                              ),

                              SizedBox(height: 15),

                              Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.orange.shade100,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.orange.shade300, width: 2),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('π = ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                        Text('${pie.toStringAsFixed(2)}', style: TextStyle(fontSize: 16, color: Colors.orange.shade700)),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            Icon(Icons.radio_button_unchecked, color: Colors.orange.shade600),
                                            Text('รัศมี', style: TextStyle(fontSize: 12)),
                                            Text('${radius.toStringAsFixed(1)} ม.',
                                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange.shade700)),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Icon(Icons.height, color: Colors.orange.shade600),
                                            Text('ความสูง', style: TextStyle(fontSize: 12)),
                                            Text('${height.toStringAsFixed(1)} ม.',
                                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange.shade700)),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Divider(color: Colors.orange.shade300, thickness: 2),
                                    Text(
                                      'พื้นที่ผิว = ${area.toStringAsFixed(1)} ตร.ม.',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 30),

                  // การ์ดป้อนข้อมูล
                  Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.edit, color: Colors.orange.shade600),
                            SizedBox(width: 8),
                            Text(
                              '📝 ป้อนข้อมูล',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange.shade700,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 25),

                        // TextField รัศมี
                        TextField(
                          controller: radiusCtrl,
                          keyboardType: TextInputType.number,
                          decoration: _getTextFieldStyle(
                            'รัศมี (Radius)',
                            'กรอกรัศมีในหน่วยเมตร',
                            Icons.radio_button_unchecked,
                          ),
                        ),

                        SizedBox(height: 20),

                        // TextField ความสูง
                        TextField(
                          controller: heightCtrl,
                          keyboardType: TextInputType.number,
                          decoration: _getTextFieldStyle(
                            'ความสูง (Height)',
                            'กรอกความสูงในหน่วยเมตร',
                            Icons.height,
                          ),
                        ),

                        SizedBox(height: 30),

                        // ปุ่มคำนวณ
                        Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.orange.shade400, Colors.red.shade400],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.orange.withOpacity(0.4),
                                spreadRadius: 2,
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: _calculateArea,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.calculate, size: 24, color: Colors.white),
                                SizedBox(width: 10),
                                Text(
                                  '🧮 คำนวณพื้นที่ผิว 🧮',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30),

                  // ข้อมูลสูตร
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade50,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.amber.shade300, width: 2),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.lightbulb, color: Colors.amber.shade700),
                            SizedBox(width: 10),
                            Text(
                              '💡 สูตรการคำนวณ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber.shade800,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          'พื้นที่ผิวทรงกรวย = π × r × (r + s)\nโดย s = √(r² + h²)',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.amber.shade800,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
