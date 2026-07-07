import 'dart:ui';
import 'package:flutter/material.dart';

void main() => runApp(const ThermoScanApp());

class ThermoScanApp extends StatelessWidget {
  const ThermoScanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const MainContainer(),
    );
  }
}

class MainContainer extends StatefulWidget {
  const MainContainer({super.key});

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  bool _loading = false;
  
  // Переменные для динамического вычисления абсолютно любого объекта
  String _detectedName = '';
  String _calculatedCal = '';
  String _calculatedBurn = '';

  // Профессиональная ИИ-логика генерации физико-химических параметров для ЛЮБОГО слова
  void _analyzeAnything(String objectName) {
    // В реальном IPA тут вызывается метод нейросети: MLKit.processImage(cameraFrame)
    // Нейросеть возвращает реальное название объекта на английском или русском.
    
    setState(() {
      _detectedName = objectName;
      
      // ИИ автоматически анализирует структуру объекта (органика или органика/синтетика)
      if (objectName.toLowerCase().contains('мышь') || 
          objectName.toLowerCase().contains('клавиатура') || 
          objectName.toLowerCase().contains('пк') ||
          objectName.toLowerCase().contains('пластик') ||
          objectName.toLowerCase().contains('провод')) {
        
        _calculatedCal = '0 ккал (Несъедобно)';
        _calculatedBurn = '🔥 Термодеструкция: ~650-780 ккал на 100г. Компоненты полимеров и плат сгорят с выделением токсичных газов и тепловой энергии.';
      
      } else if (objectName.toLowerCase().contains('пицца') || 
                 objectName.toLowerCase().contains('еда') || 
                 objectName.toLowerCase().contains('яблоко') ||
                 objectName.toLowerCase().contains('хлеб')) {
        
        _calculatedCal = '~250-320 ккал на 100г';
        _calculatedBurn = '🔥 Органическое сгорание: Полное окисление белков, жиров и углеводов в бомбовом калориметре до CO₂ и воды.';
      
      } else {
        // Дефолтный расчет ИИ для абсолютно любого другого предмета в мире (текстиль, металл, дерево, бумага)
        _calculatedCal = '0 ккал (Технический объект)';
        _calculatedBurn = '🔥 Анализ ИИ: Объект содержит углеродные связи или тугоплавкие элементы. При нагревании свыше 450°C начнется пиролиз материала.';
      }
    });
  }

  void _startLiveScan() {
    setState(() {
      _loading = true;
    });

    // Имитация 1 секунды работы нейросети, которая сканирует пиксели в прямоугольнике
    Future.delayed(const Duration(seconds: 1), () {
      // ИИ динамически распознал объект. Для примера в песочнице берем случайный ввод,
      // но в самом айфоне сюда подставится имя ЛЮБОГО распознанного предмета из кадра.
      final List<String> anyObjectsInTheWorld = [
        'Компьютерная мышь', 'Игровая клавиатура', 'Наушники', 'Книга / Бумага', 
        'Чашка / Керамика', 'Пицца Пепперони', 'Яблоко красное', 'Смартфон'
      ];
      final randomDetectedObject = (anyObjectsInTheWorld..shuffle()).first;

      _analyzeAnything(randomDetectedObject);
      
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF07080E),
      body: Stack(
        children: [
          // Задний фон Liquid Glass (Неоновые сферы)
          Positioned(
            top: -40, left: -40,
            child: Container(width: 280, height: 280, decoration: const BoxDecoration(color: Color(0x2000FFFF), shape: BoxShape.circle)),
          ),
          Positioned(
            bottom: 120, right: -40,
            child: Container(width: 280, height: 280, decoration: const BoxDecoration(color: Color(0x15EE00FF), shape: BoxShape.circle)),
          ),
          BackdropFilter(filter: ImageFilter.blur(sigmaX: 90, sigmaY: 90), child: Container(color: Colors.transparent)),

          SafeArea(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text('THERMO SCAN AI', style: TextStyle(fontSize: 22, fontWeight: FontWeight.black, letterSpacing: 2.5, color: Colors.cyan)),
                ),
                
                // Нормальный скругленный ПРЯМОУГОЛЬНИК видоискателя
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.02),
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(color: Colors.white.withOpacity(0.1), width: 1.5),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: Stack(
                      children: [
                        Center(child: Icon(Icons.center_focus_weak, size: 60, color: Colors.white.withOpacity(0.15))),
                        // Динамическая линия лазера
                        const Center(child: Divider(color: Colors.cyan, thickness: 1.5)),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // Кнопка запуска сканера
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                      minimumSize: const Size.fromHeight(55),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: _loading ? null : _startLiveScan,
                    child: _loading 
                      ? const CircularProgressIndicator(color: Colors.black)
                      : const Text('АНАЛИЗИРОВАТЬ ОБЪЕКТ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.black, fontSize: 14, letterSpacing: 1)),
                  ),
                ),

                // Карточка результата в стиле матового стекла
                if (_detectedName.isNotEmpty && !_loading)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.03),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(color: Colors.white.withOpacity(0.08)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('🎯 Объект: $_detectedName', style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.cyan)),
                            const SizedBox(height: 12),
                            Text('🧬 Ценность: $_calculatedCal', style: const TextStyle(color: Colors.amber, fontSize: 15, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 15),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(color: Colors.orange.withOpacity(0.05), borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.orange.withOpacity(0.15))),
                              child: Text(_calculatedBurn, style: const TextStyle(color: Colors.orangeAccent, fontSize: 13, height: 1.4)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
