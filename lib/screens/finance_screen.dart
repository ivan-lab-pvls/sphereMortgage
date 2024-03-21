import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mortgage_calc/const/app_styles.dart';
import 'package:mortgage_calc/const/enum.dart';

class FinanceWidget extends StatelessWidget {
  const FinanceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<List<Pars>> pairedPars = _generatePairedPars();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 45),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'FINANCE',
            style: boldstyle.copyWith(fontSize: 18),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: pairedPars.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 16);
            },
            itemBuilder: (BuildContext context, int index) {
              final List<Pars> pars = pairedPars[index];

              return CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FinanceInfoWidget(
                        pairsForView: pars,
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Expanded(child: ContWithInfo(pars: pars[0])),
                    SizedBox(width: 8),
                    Expanded(child: ContWithInfo(pars: pars[1])),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Генерация пар заранее
  List<List<Pars>> _generatePairedPars() {
    final List<Pars> shuffledPars = List.from(Pars.values)..shuffle();
    final List<List<Pars>> pairedPars = [];

    for (int i = 0; i < shuffledPars.length; i += 2) {
      if (i + 1 < shuffledPars.length) {
        pairedPars.add([shuffledPars[i], shuffledPars[i + 1]]);
      } else {
        pairedPars.add([shuffledPars[i]]);
      }
    }

    return pairedPars;
  }
}

class ContWithInfo extends StatelessWidget {
  const ContWithInfo({
    Key? key,
    required this.pars,
  }) : super(key: key);

  final Pars pars;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Color(0xffF1F1F1)),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            height: 35,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    height: 35,
                    width: 35,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.network(
                      "https://s3-symbol-logo.tradingview.com/country/${pars.name[3]}${pars.name[4]}.svg",
                    ),
                  ),
                ),
                Container(
                  clipBehavior: Clip.hardEdge,
                  height: 35,
                  width: 35,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.network(
                    "https://s3-symbol-logo.tradingview.com/country/${pars.name[0]}${pars.name[1]}.svg",
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              child: Text(pars.name,
                  style: btntext.copyWith(color: Colors.black, fontSize: 15)),
            ),
          ),
        ],
      ),
    );
  }
}

class FinanceInfoWidget extends StatelessWidget {
  final List<Pars> pairsForView;

  const FinanceInfoWidget({Key? key, required this.pairsForView})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Pars> filledPairs = List<Pars>.filled(4, Pars.GBPAUD);
    for (int i = 0; i < pairsForView.length; i++) {
      filledPairs[i] = pairsForView[i];
    }

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 45),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.chevron_left),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Spacer(),
              Text(
                'FINANCE INFO',
                style: btntext.copyWith(
                    color: Colors.black, fontWeight: FontWeight.w800),
              ),
              Spacer(),
              Container(
                width: 40,
              )
            ],
          ),
          SizedBox(height: 25),
          SizedBox(
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
            child: InAppWebView(
              initialData: InAppWebViewInitialData(
                data: """<!-- TradingView Widget BEGIN -->
                <div class="tradingview-widget-container">
                  <div id="tradingview_e8211"></div>
                  <div class="tradingview-widget-copyright">
                    <a href="https://www.tradingview.com/" rel="noopener nofollow" target="_blank">
                      <span class="blue-text">Track all markets on TradingView</span>
                    </a>
                  </div>
                  <script type="text/javascript" src="https://s3.tradingview.com/tv.js"></script>
                  <script type="text/javascript">
                    new TradingView.widget(
                      {
                        "autosize": true,
                        "symbol": "FX:${filledPairs[0].name}",
                        "interval": "D",
                        "timezone": "Etc/UTC",
                        "theme": "light",
                        "style": "1",
                        "locale": "en",
                        "enable_publishing": false,
                        "allow_symbol_change": true,
                        "container_id": "tradingview_e8211"
                      }
                    );
                  </script>
                </div>
                <!-- TradingView Widget END -->""",
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: ContWithInfo(pars: filledPairs[0])),
                Expanded(child: ContWithInfo(pars: filledPairs[1])),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: ContWithInfo(pars: filledPairs[2])),
                Expanded(child: ContWithInfo(pars: filledPairs[3])),
              ],
            ),
          )
        ],
      ),
    );
  }
}
