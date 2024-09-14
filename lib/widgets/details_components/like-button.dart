import 'package:flutter/material.dart';
import 'package:frontend_oky_code/helpers/fetch_data.dart';

class LikeButton extends StatefulWidget {
  final bool isLiked;
  final ValueChanged<bool> changeLike;
  final String productId;

  const LikeButton({
    Key? key,
    required this.isLiked,
    required this.changeLike,
    required this.productId,
  }) : super(key: key);

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {

  void _toggleLike(String productId, isLiked) async {
    likeProduct(productId, isLiked);
    isLiked = !isLiked;
    if(isLiked){
        widget.changeLike(true);
    } else {
        widget.changeLike(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: (){
        _toggleLike(widget.productId, widget.isLiked);
      },
      child: ClipOval(
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
            widget.isLiked ? Colors.transparent : Color(0xFFE8E4F4),
            BlendMode.color,
          ),
          child: Image.asset(
            widget.isLiked
                ? 'lib/assets/me_gusta.png'
                : 'lib/assets/no_me_gusta.png',
            height: screenHeight * 0.04,
          ),
        ),
      ),
    );
  }
}
