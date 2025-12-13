import 'package:flutter/material.dart';

class RectanglePage extends StatefulWidget {
  const RectanglePage({super.key});

  @override
  State<RectanglePage> createState() => RectanglePageState();
}

class RectanglePageState extends State<RectanglePage> {
  //พท.สี่เหลี่ยม = กว้าง* ยาว
  //Output = input * input
//_textFieldStyle คือ อินสเตรน เป็นการสร้างตัวแปรมาเก็บสไตล์
//ประกาศตัวแปรเก็บข้อมูล 3 ตัว

  int _width = 0;
  int _length = 0;
  int _area = 0;

  TextEditingController _widthCtrl = TextEditingController();
  TextEditingController _lengthCtrl = TextEditingController();

  final InputDecoration _textFieldStyle = InputDecoration(
  filled: true,
  fillColor: Colors.blue[50],
  border: OutlineInputBorder()
      );

  //void ฟังชั่นที่ไม่คืนค่า
  // ?? แปลงไม่ได้ให้ใส่เป็นเลข0แทน
  void _calRectangle(){
  _width = int.tryParse(_widthCtrl.text) ?? 0;
  _length = int.tryParse(_lengthCtrl.text) ?? 0;

  setState(() {
      _area = _width * _length;
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('คำนวณพื้นที่สี่เหลี่ยม'), centerTitle: true),
      body: Column(children: [
        SizedBox(height: 30,),
        Text('กว้าง $_width ม. ยาว $_length ม. พื้นที่คือ $_area ตร.ม.'),
        SizedBox(height:  20,),
        TextField(
          controller: _widthCtrl,
          decoration:_textFieldStyle.copyWith(label: Text('ความกว้าง'),hint: Text('กรอกความกว้าง'))
          
        ), 
        SizedBox(height: 20,),
        TextField(
        controller: _lengthCtrl,
          decoration:_textFieldStyle.copyWith(label: Text('ความยาว'),hint: Text('กรอกความยาว'))
        ),
        SizedBox(height: 30,),
        ElevatedButton(onPressed: () => _calRectangle(), child: Text("คำนวณ"))
      ],),
    );
  }
}
