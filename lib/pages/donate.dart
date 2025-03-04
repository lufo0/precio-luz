import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData;
import 'package:url_launcher/url_launcher.dart';
import '../utils/constantes.dart';
import '../widgets/head.dart';

class DonationPage extends StatelessWidget {
  const DonationPage();

  @override
  Widget build(BuildContext context) {
    const String btcAddress = '15ZpNzqbYFx9P7wg4U438JMwZr2q3W6fkS';
    const String urlPayPal = 'https://www.paypal.com/donate?hosted_button_id=986PSAHLH6N4L';
    const String urlGitHub = 'https://github.com/Webierta/precio-luz/issues';

    void _launchURL(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Could not launch PayPal payment website.'),
        ));
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Buy Me a Coffee')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 40),
        child: Column(
          children: [
            const Head(),
            const Icon(Icons.favorite_border, size: 60, color: Color(0xFF1565C0)),
            const Divider(),
            const SizedBox(height: 10.0),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                  'Esta App es Software libre y de Código Abierto. Por favor considera colaborar '
                  'para mantener activo el desarrollo de esta App.',
                  style: sizeText20),
            ),
            const SizedBox(height: 10.0),
            Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        //style: TextStyle(color: Colors.black, fontSize: 22),
                        style: size22Black,
                        text:
                            '¿Crees que has encontrado un problema? Identificar y corregir errores hace que '
                            'esta App sea mejor para todos. Informa de un error aquí: '),
                    TextSpan(
                      style: const TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 22,
                        decoration: TextDecoration.underline,
                      ),
                      text: 'GitHub issues.',
                      recognizer: TapGestureRecognizer()..onTap = () => _launchURL(urlGitHub),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                  'Puedes colaborar con el desarrollo de ésta y otras aplicaciones con una pequeña '
                  'aportación a mi monedero de Bitcoins o vía PayPal.',
                  style: sizeText20),
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text('Scan this QR code with your wallet application:', style: sizeText20),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.5,
              child: Image.asset('assets/images/Bitcoin_QR.png'),
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text('Or copy the BTC Wallet Address:', style: sizeText20),
              ),
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    border: Border.all(
                      color: Colors.black12,
                      style: BorderStyle.solid,
                    )),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      padding: EdgeInsets.all(8.0),
                      decoration: ShapeDecoration(
                        color: Colors.grey[100],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            topLeft: Radius.circular(8),
                            bottomRight: Radius.zero,
                            topRight: Radius.zero,
                          ),
                        ),
                      ),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(btcAddress),
                      ),
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(color: Colors.black12, style: BorderStyle.solid)),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.copy),
                        onPressed: () async {
                          await Clipboard.setData(ClipboardData(text: btcAddress));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('BTC Address copied to Clipboard.'),
                          ));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: const Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                child:
                    Text('Donate via Paypal (open the PayPal payment website):', style: sizeText20),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.4,
              child: ElevatedButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 10.0,
                  padding: EdgeInsets.all(10),
                ),
                onPressed: () => _launchURL(urlPayPal),
                child: Image.asset('assets/images/paypal_logo.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
