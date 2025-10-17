import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import necessário para traduções

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LatLng coimbraLocation = LatLng(40.1926667, -8.4116111); // Localização inicial no mapa (Coimbra)

    return Scaffold(
      body: Stack(
        children: [
          // Fundo com a imagem
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/img_2.png'), // Caminho da imagem de fundo
                fit: BoxFit.cover, // Ajuste para cobrir toda a tela
              ),
            ),
          ),
          Column(
            children: [
              // Cabeçalho
              Container(
                margin: EdgeInsets.only(top: 40), // Ajuste do espaçamento superior
                padding: EdgeInsets.symmetric(vertical: 20),
                color: Colors.white.withOpacity(0.8), // Fundo branco translúcido para o cabeçalho
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context)!.about, // Tradução dinâmica para "Sobre"
                  style: TextStyle(
                    fontSize: 24, // Tamanho da fonte
                    fontWeight: FontWeight.bold, // Negrito
                    color: Colors.black, // Cor do texto
                  ),
                ),
              ),
              SizedBox(height: 100), // Espaçamento entre o cabeçalho e a frase motivacional
              // Frase motivacional
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  color: Colors.white.withOpacity(0.9), // Fundo translúcido da frase
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Bordas arredondadas do card
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      AppLocalizations.of(context)!.quote, // Tradução dinâmica para a frase
                      style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic), // Estilo do texto
                      textAlign: TextAlign.center, // Centraliza o texto
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Mapa com localização
              Container(
                height: 200, // Altura do mapa
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Bordas arredondadas do mapa
                  ),
                  clipBehavior: Clip.antiAlias, // Garante que o conteúdo seja cortado nas bordas arredondadas
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: coimbraLocation, // Centro inicial do mapa
                      initialZoom: 15.0, // Zoom inicial
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', // Fonte dos tiles do mapa
                        subdomains: ['a', 'b', 'c'], // Subdomínios do OpenStreetMap
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            width: 40.0,
                            height: 40.0,
                            point: coimbraLocation, // Localização do marcador
                            child: Icon(
                              Icons.location_pin, // Ícone do marcador
                              color: Colors.red, // Cor do marcador
                              size: 40, // Tamanho do marcador
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Informações dos autores
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  color: Colors.white.withOpacity(0.9), // Fundo translúcido da seção
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Bordas arredondadas do card
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center, // Centraliza os textos
                      children: [
                        // Última atualização
                        Text(
                          '${AppLocalizations.of(context)!.last_updated}: January 6, 2025', // Tradução dinâmica
                          style: TextStyle(fontSize: 16), // Estilo do texto
                        ),
                        SizedBox(height: 10),
                        // Desenvolvedores
                        Text(
                          '${AppLocalizations.of(context)!.developed_by}: Andreia Fernandes and Rita Quaresma', // Tradução dinâmica
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Estilo do texto
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
