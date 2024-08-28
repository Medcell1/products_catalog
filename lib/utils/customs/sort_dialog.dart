import 'package:product_catalog/view/view.dart';

import 'custom_slider_thumb_circle.dart';

class SortDialog extends StatefulWidget {
  const SortDialog({super.key});

  @override
  _SortDialogState createState() => _SortDialogState();
}

class _SortDialogState extends State<SortDialog> {
  @override
  Widget build(BuildContext context) {
    Color? mixedColor = Color.lerp(
      Colors.white,
      primaryColor,
      0.4,
    );
    Color? sliderMixedColor = Color.lerp(
      Colors.white,
      const Color(0xffFFAA0F),
      0.4,
    );
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Consumer<ProductViewModel>(
            builder: (context, productViewModel, _) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Globals.loadSvgImage(
                            filterIcon,
                            30,
                            30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Filters',
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  16.0.spaceHeight(),
                  const StyledText(
                    text: "Name",
                    fontSize: 16,
                    fontName: "Open Sans",
                  ),
                  8.0.spaceHeight(),
                  TextField(
                    controller: productViewModel.sortNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  16.0.spaceHeight(),
                  const StyledText(
                    text: "Category",
                    fontSize: 16,
                    fontName: "Open Sans",
                  ),
                  8.0.spaceHeight(),
                  DropdownButtonFormField<String>(
                    value: productViewModel.selectedSortCategory,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        productViewModel.selectedSortCategory = value!;
                      });
                    },
                    items: productViewModel.sortCategories
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  16.0.spaceHeight(),
                  const StyledText(
                    text: "Price",
                    fontSize: 16,
                    fontName: "Open Sans",
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 6,
                      thumbShape: CustomSliderThumbCircle(
                        thumbRadius: 8,
                        outerColor: Colors.white,
                        innerColor: Colors.orange,
                      ),
                    ),
                    child: Slider(
                      value: productViewModel.currentPrice,
                      min: 0,
                      max: 1000,
                      divisions: 100,
                      label: productViewModel.currentPrice.round().toString(),
                      onChanged: (value) {
                        setState(() {
                          productViewModel.currentPrice = value;
                        });
                      },
                      thumbColor: const Color(0xffFFB30D),
                      activeColor: const Color(0xffFFB30D),
                      inactiveColor: sliderMixedColor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            color: mixedColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {

                          productViewModel.sortOffers();
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Apply',
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
