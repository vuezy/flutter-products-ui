import 'package:flutter/material.dart';
import 'package:flutter_products_ui/models/product_model.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  const ProductDetail({super.key, required this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int _imageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          child: Stack(
            children: [
              _buildImages(size.width, size.height),
              Positioned(
                bottom: 0.0,
                child: Container(
                  width: size.width,
                  height: 0.6 * size.height,
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      colors: [Colors.green.shade100, Colors.green.shade300]
                    ),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, offset: Offset(0.0, -2.0), blurRadius: 10.0)
                    ],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0)
                    )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.product.title, style: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold
                      )),
                      const Divider(color: Colors.black),
                      Expanded(
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: _buildDetailText('Rating: ', '${widget.product.rating}')
                            ),
                            _buildDetailText('Brand: ', widget.product.brand),
                            _buildDetailText('Category: ', widget.product.category),
                            const SizedBox(height: 8.0,),
                            _buildDetailText(
                              'Description:\n',
                              widget.product.description,
                              valueSize: 17.0
                            ),
                            const SizedBox(height: 10.0,),
                            _buildDetailText('Stock: ', '${widget.product.stock}'),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal.shade800
                                ),
                                children: [
                                  TextSpan(text: 'Price: ', style: TextStyle(
                                    color: Colors.blueGrey.shade900
                                  )),
                                  TextSpan(text: ' \$${widget.product.price} ', style: TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.blueGrey.shade800,
                                    decoration: TextDecoration.lineThrough
                                  )),
                                  TextSpan(
                                    text: '\$${widget.product.discountPrice} ',
                                    style: TextStyle(
                                      fontSize: 23.0,
                                      color: Colors.teal.shade900,
                                    )
                                  ),
                                  TextSpan(text: '(${widget.product.discount}% off)')
                                ]
                              )
                            ),
                            const SizedBox(height: 10.0,),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 5.0,
                                backgroundColor: Colors.green.shade900.withOpacity(0.6),
                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0)
                              ),
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.shopping_cart_outlined),
                                  SizedBox(width: 15.0,),
                                  Text('Add To Cart', style: TextStyle(fontSize: 20.0))
                                ],
                              )
                            )
                          ]
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImages(double width, double height) {
    return Stack(
      children: [
        SizedBox(
          height: 0.4 * height,
          width: width,
          child: Image.network(
            widget.product.images[_imageIndex],
            fit: BoxFit.fill,
          )
        ),
        Positioned(
          right: 0.0,
          top: 0.0,
          bottom: 0.0,
          child: _buildCircularButton(
            Icons.chevron_right,
            onTap: () {
              setState(() {
                if (_imageIndex == widget.product.images.length - 1) {
                  _imageIndex = 0;
                }
                else {
                  _imageIndex += 1;
                }
              });
            }
          )
        ),
        Positioned(
          left: 0.0,
          top: 0.0,
          bottom: 0.0,
          child: _buildCircularButton(
            Icons.chevron_left,
            onTap: () {
              setState(() {
                if (_imageIndex == 0) {
                  _imageIndex = widget.product.images.length - 1;
                }
                else {
                  _imageIndex -= 1;
                }
              });
            }
          )
        ),
        Positioned(
          top: 5.0,
          left: 5.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade900.withOpacity(0.6)
            ),
            onPressed: () { Navigator.of(context).pop(); },
            child: const Icon(Icons.arrow_back, size: 30.0,)
          )
        )
      ],
    );
  }

  Widget _buildCircularButton(
    IconData icon,
    {required void Function() onTap, double radius = 15.0}
  ) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: Colors.black54,
        radius: radius,
        child: Icon(icon, size: 30.0)
      ),
    );
  }

  Widget _buildDetailText(String label, String value, {double valueSize = 20.0}) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
        children: [
          TextSpan(text: label, style: TextStyle(
            color: Colors.blueGrey.shade900
          )),
          TextSpan(text: value, style: TextStyle(
            fontSize: valueSize,
            color: Colors.teal.shade900
          ))
        ]
      )
    );
  }
} 