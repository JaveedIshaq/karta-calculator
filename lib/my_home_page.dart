import 'package:flutter/material.dart';
import 'package:kartacalculator/core/string_values.dart';
import 'package:kartacalculator/widgets/common_text_field_view.dart';
import 'package:kartacalculator/widgets/urdu_rtl_text.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _errorKaatKg = '';
  late TextEditingController _kaatKgController;
  String _errorKaatGram = '';
  late TextEditingController _kaatGramController;

  String _errorWeightGram = '';
  late TextEditingController _weightGramController;
  String _errorWeightKg = '';
  late TextEditingController _weightKgController;
  String _errorWeightMan = '';
  late TextEditingController _weightManController;

  int _resultValue = 0;

  @override
  void initState() {
    _kaatKgController = TextEditingController();
    _kaatGramController = TextEditingController();
    _weightGramController = TextEditingController();
    _weightKgController = TextEditingController();
    _weightManController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _kaatKgController.dispose();
    _kaatGramController.dispose();
    _weightGramController.dispose();
    _weightKgController.dispose();
    _weightManController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inputWidth = MediaQuery.of(context).size.width * 0.3;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: SizedBox.expand(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    UrduRTLText(text: StringValues.title, fontSize: 50),
                    UrduRTLText(text: StringValues.subTitle),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: inputWidth,
                          child: CommonTextFieldView(
                            controller: _kaatGramController,
                            errorText: _errorKaatGram,
                            labelText: 'گرام',
                            hintText: "0",
                            keyboardType: TextInputType.number,
                            onChanged: (String txt) {},
                          ),
                        ),
                        SizedBox(
                          width: inputWidth,
                          child: CommonTextFieldView(
                            controller: _kaatKgController,
                            errorText: _errorKaatKg,
                            labelText: 'کلو',
                            hintText: "0",
                            keyboardType: TextInputType.number,
                            onChanged: (String txt) {
                              try {
                                int.parse(txt);
                                _errorKaatKg = "";
                              } catch (e) {
                                _errorKaatKg = StringValues.errorMessage;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    UrduRTLText(text: StringValues.enterWeightTitle),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: inputWidth,
                          child: CommonTextFieldView(
                            controller: _weightGramController,
                            errorText: _errorWeightGram,
                            labelText: 'گرام',
                            hintText: "0",
                            keyboardType: TextInputType.number,
                            onChanged: (String value) {},
                          ),
                        ),
                        SizedBox(
                          width: inputWidth,
                          child: CommonTextFieldView(
                            controller: _weightKgController,
                            errorText: _errorWeightKg,
                            labelText: 'کلو',
                            hintText: "0",
                            keyboardType: TextInputType.number,
                            onChanged: (String txt) {},
                          ),
                        ),
                        SizedBox(
                          width: inputWidth,
                          child: CommonTextFieldView(
                            controller: _weightManController,
                            errorText: _errorWeightMan,
                            labelText: 'من',
                            hintText: "0",
                            keyboardType: TextInputType.number,
                            onChanged: (String txt) {},
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        (_resultValue < 1000)
                            ? UrduRTLText(
                                text: '$_resultValue گرام ', fontSize: 60)
                            : convertGramsToKgGrams(_resultValue),
                        const SizedBox(width: 30),
                        UrduRTLText(text: StringValues.resultTitle),
                      ],
                    ),
                    SizedBox(
                      width: inputWidth,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_allValidation()) {
                            int totalKaatRatioInGrams = getTotalKaatGrams();
                            int totalWeight = getTotalWeightGrams();

                            double kaatPerGram = totalKaatRatioInGrams / 40000;

                            final totalKaat = totalWeight * kaatPerGram;
                            // if against (40*1000) Grams deduction is totalKaatGramsPer40Kg
                            // what will be deduction against totalWeight

                            setState(() {
                              _resultValue = totalKaat.toInt();
                            });
                          }
                        },
                        child:
                            const UrduRTLText(text: 'حساب کریں', fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget convertGramsToKgGrams(int grams) {
    int kilograms = grams ~/ 1000;
    int remainingGrams = grams % 1000;

    if (kilograms == 0) {
      return UrduRTLText(text: '$remainingGrams گرام', fontSize: 60);
    } else {
      return (remainingGrams != 0)
          ? UrduRTLText(
              text: '$kilograms کلو $remainingGrams گرام', fontSize: 60)
          : UrduRTLText(text: '$kilograms کلو', fontSize: 60);
    }
  }

  int getTotalKaatGrams() {
    // == Kaat Conversion into Grams
    int kaatGrams = (_kaatGramController.text.trim() == "")
        ? 0
        : int.parse(_kaatGramController.text.trim());

    int kaatKGintoGrams = (_kaatKgController.text.trim() == "")
        ? 0
        : int.parse(_kaatKgController.text.trim()) * 1000;

    return kaatGrams + kaatKGintoGrams;
  }

  int getTotalWeightGrams() {
    final weightGramsInput = _weightGramController.text.trim();
    int weightGrams =
        (weightGramsInput == "") ? 0 : int.parse(weightGramsInput);

    final weightKgInput = _weightKgController.text.trim();
    int weightKGintoGrams =
        (weightKgInput == "") ? 0 : int.parse(weightKgInput) * 1000;

    final weightManInput = _weightManController.text.trim();
    int weightManIntoGrams =
        (weightManInput == "") ? 0 : int.parse(weightManInput) * 40 * 1000;

    return weightGrams + weightKGintoGrams + weightManIntoGrams;
  }

  bool _allValidation() {
    bool isValid = true;

    // String _errorKaatKg = '';
    // late TextEditingController _kaatKgController;

    if (_kaatKgController.text.trim().isNotEmpty) {
      try {
        int.parse(_kaatKgController.text.trim());
        _errorKaatKg = '';
      } catch (e) {
        _errorKaatKg = StringValues.errorMessage;
        isValid = false;
      }
    } else {
      _kaatKgController.text = "0";
    }

    //  String _errorKaatGram = '';
    //late TextEditingController _kaatGramController;
    if (_kaatGramController.text.trim().isNotEmpty) {
      try {
        int.parse(_kaatGramController.text.trim());
        _errorKaatGram = '';
      } catch (e) {
        _errorKaatGram = StringValues.errorMessage;
        isValid = false;
      }
    } else {
      _kaatGramController.text = "0";
    }

    // String _errorWeightGram = '';
    // late TextEditingController _weightGramController;
    if (_weightGramController.text.trim().isNotEmpty) {
      try {
        int.parse(_weightGramController.text.trim());
        _errorWeightGram = '';
      } catch (e) {
        _errorWeightGram = StringValues.errorMessage;
        isValid = false;
      }
    } else {
      _weightGramController.text = "0";
    }

    //  String _errorWeightKg = '';
    // late TextEditingController _weightKgController;
    if (_weightKgController.text.trim().isNotEmpty) {
      try {
        int.parse(_weightKgController.text.trim());
        _errorWeightKg = '';
      } catch (e) {
        _errorWeightKg = StringValues.errorMessage;
        isValid = false;
      }
    } else {
      _weightKgController.text = "0";
    }
    //  String _errorWeightMan = '';
    // late TextEditingController _weightManController;
    if (_weightManController.text.trim().isNotEmpty) {
      try {
        int.parse(_weightManController.text.trim());
        _errorWeightMan = '';
      } catch (e) {
        _errorWeightMan = StringValues.errorMessage;
        isValid = false;
      }
    } else {
      _weightManController.text = "0";
    }

    setState(() {});

    return isValid;
  }
}
