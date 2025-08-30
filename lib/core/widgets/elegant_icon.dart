import 'package:flutter/material.dart';
import 'package:sip_fit/core/constants/app_colors.dart';

class ElegantIcon extends StatelessWidget {
  final String type;
  final double size;
  final Color? color;

  const ElegantIcon({
    super.key,
    required this.type,
    this.size = 48,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 4),
        gradient: LinearGradient(
          colors: _getGradientColors(),
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // 背景装饰
          Positioned.fill(
            child: CustomPaint(
              painter: _IconDecorationPainter(
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          // 主图标
          Center(
            child: _buildMainIcon(),
          ),
          // 装饰图标
          ..._buildDecorativeIcons(),
        ],
      ),
    );
  }

  List<Color> _getGradientColors() {
    switch (type) {
      case 'botanical':
        return [
          const Color(0xFF7CB342),
          const Color(0xFF558B2F),
        ];
      case 'fruity':
        return [
          const Color(0xFFFFB74D),
          const Color(0xFFF57C00),
        ];
      case 'floral':
        return [
          const Color(0xFFE57373),
          const Color(0xFFD32F2F),
        ];
      case 'spicy':
        return [
          const Color(0xFFFF7043),
          const Color(0xFFE64A19),
        ];
      case 'creamy':
        return [
          const Color(0xFFFFE082),
          const Color(0xFFFFA000),
        ];
      case 'citrus':
        return [
          const Color(0xFFFFEE58),
          const Color(0xFFFBC02D),
        ];
      case 'herbal':
        return [
          const Color(0xFF81C784),
          const Color(0xFF388E3C),
        ];
      case 'bar_elegant':
        return [
          const Color(0xFF9575CD),
          const Color(0xFF512DA8),
        ];
      case 'bar_modern':
        return [
          const Color(0xFF4FC3F7),
          const Color(0xFF0288D1),
        ];
      case 'bar_cozy':
        return [
          const Color(0xFFFF8A65),
          const Color(0xFFD84315),
        ];
      default:
        return [
          AppColors.primaryPurple,
          AppColors.primaryPink,
        ];
    }
  }

  Widget _buildMainIcon() {
    IconData mainIcon;
    double iconSize = size * 0.5;

    switch (type) {
      case 'botanical':
        mainIcon = Icons.eco;
        break;
      case 'fruity':
        mainIcon = Icons.spa;
        break;
      case 'floral':
        mainIcon = Icons.local_florist;
        break;
      case 'spicy':
        mainIcon = Icons.whatshot;
        break;
      case 'creamy':
        mainIcon = Icons.opacity;
        break;
      case 'citrus':
        mainIcon = Icons.brightness_5;
        break;
      case 'herbal':
        mainIcon = Icons.grass;
        break;
      case 'bar_elegant':
        mainIcon = Icons.wine_bar;
        break;
      case 'bar_modern':
        mainIcon = Icons.nightlife;
        break;
      case 'bar_cozy':
        mainIcon = Icons.weekend;
        break;
      default:
        mainIcon = Icons.local_bar;
    }

    return Icon(
      mainIcon,
      size: iconSize,
      color: Colors.white.withOpacity(0.9),
    );
  }

  List<Widget> _buildDecorativeIcons() {
    final decorSize = size * 0.25;
    final List<Widget> decorations = [];

    switch (type) {
      case 'botanical':
        decorations.addAll([
          Positioned(
            top: 4,
            right: 4,
            child: Icon(
              Icons.grass,
              size: decorSize,
              color: Colors.white.withOpacity(0.3),
            ),
          ),
          Positioned(
            bottom: 4,
            left: 4,
            child: Icon(
              Icons.water_drop,
              size: decorSize,
              color: Colors.white.withOpacity(0.3),
            ),
          ),
        ]);
        break;
      case 'fruity':
        decorations.addAll([
          Positioned(
            top: 4,
            left: 4,
            child: Icon(
              Icons.bubble_chart,
              size: decorSize,
              color: Colors.white.withOpacity(0.3),
            ),
          ),
        ]);
        break;
      case 'floral':
        decorations.addAll([
          Positioned(
            bottom: 4,
            right: 4,
            child: Icon(
              Icons.air,
              size: decorSize,
              color: Colors.white.withOpacity(0.3),
            ),
          ),
        ]);
        break;
      // 添加更多装饰图案...
    }

    return decorations;
  }
}

class _IconDecorationPainter extends CustomPainter {
  final Color color;

  _IconDecorationPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // 绘制装饰性图案
    final path = Path();
    
    // 绘制圆点网格
    const spacing = 8.0;
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        if ((x + y) % (spacing * 2) == 0) {
          path.addOval(
            Rect.fromCircle(
              center: Offset(x, y),
              radius: 1,
            ),
          );
        }
      }
    }

    // 绘制装饰性曲线
    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.8,
      size.width,
      size.height * 0.6,
    );

    path.moveTo(size.width * 0.2, 0);
    path.quadraticBezierTo(
      size.width * 0.3,
      size.height * 0.5,
      size.width * 0.1,
      size.height,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
