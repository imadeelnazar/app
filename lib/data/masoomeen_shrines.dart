class MasoomeenShrine {
  final String id;
  final String title;
  final String location;
  final String assetPath;
  final String imageUrl;
  final String sourceUrl;

  const MasoomeenShrine({
    required this.id,
    required this.title,
    required this.location,
    required this.assetPath,
    required this.imageUrl,
    required this.sourceUrl,
  });
}

const String _commonsFile =
    'https://commons.wikimedia.org/wiki/Special:FilePath/';
const String _commonsPage = 'https://commons.wikimedia.org/wiki/File:';

const String _nabawiFile = 'Green%20Dome%2C%20Masjid%20Al%20Nabawi.jpg';
const String _baqiFile =
    'Grave%20of%20Ibrahim%20at%20Jannat-ul-Baqi%2C%20Medina.JPG';
const String _najafFile = 'Imam%20Ali%20Shrine%20%281%29.jpg';
const String _karbalaFile = 'Imam%20Husayn%20Shrine%202.jpg';
const String _mashhadFile = 'Imam%20Reza%20shrine.jpg';
const String _kadhimiyaFile =
    '%D8%AD%D8%B1%D9%85%20%DA%A9%D8%A7%D8%B8%D9%85%DB%8C%D9%86.jpg';
const String _samarraFile = 'Al-Askari%20Shrine%20-%20Nov%2015%2C%202018.jpg';

String _image(String fileName) => '$_commonsFile$fileName?width=2400';
String _source(String fileName) => '$_commonsPage$fileName';
String _asset(String fileName) => 'assets/images/masoomeen/$fileName';

final List<MasoomeenShrine> masoomeenShrines = [
  MasoomeenShrine(
    id: 'prophet_muhammad',
    title: 'Prophet Muhammad (S.A.W.W)',
    location: 'Masjid al-Nabawi, Madinah',
    assetPath: _asset('masjid_al_nabawi.jpg'),
    imageUrl: _image(_nabawiFile),
    sourceUrl: _source(_nabawiFile),
  ),
  MasoomeenShrine(
    id: 'fatima_zahra',
    title: 'Janab-e-Fatima Zahra (S.A)',
    location: 'Madinah / Jannat al-Baqi area',
    assetPath: _asset('jannat_al_baqi.jpg'),
    imageUrl: _image(_baqiFile),
    sourceUrl: _source(_baqiFile),
  ),
  MasoomeenShrine(
    id: 'imam_ali',
    title: 'Imam Ali (A.S)',
    location: 'Najaf al-Ashraf',
    assetPath: _asset('najaf_imam_ali.jpg'),
    imageUrl: _image(_najafFile),
    sourceUrl: _source(_najafFile),
  ),
  MasoomeenShrine(
    id: 'imam_hasan',
    title: 'Imam Hasan (A.S)',
    location: 'Jannat al-Baqi, Madinah',
    assetPath: _asset('jannat_al_baqi.jpg'),
    imageUrl: _image(_baqiFile),
    sourceUrl: _source(_baqiFile),
  ),
  MasoomeenShrine(
    id: 'imam_hussain',
    title: 'Imam Hussain (A.S)',
    location: 'Karbala al-Mualla',
    assetPath: _asset('karbala_imam_hussain.jpg'),
    imageUrl: _image(_karbalaFile),
    sourceUrl: _source(_karbalaFile),
  ),
  MasoomeenShrine(
    id: 'imam_sajjad',
    title: 'Imam Sajjad (A.S)',
    location: 'Jannat al-Baqi, Madinah',
    assetPath: _asset('jannat_al_baqi.jpg'),
    imageUrl: _image(_baqiFile),
    sourceUrl: _source(_baqiFile),
  ),
  MasoomeenShrine(
    id: 'imam_baqir',
    title: 'Imam Baqir (A.S)',
    location: 'Jannat al-Baqi, Madinah',
    assetPath: _asset('jannat_al_baqi.jpg'),
    imageUrl: _image(_baqiFile),
    sourceUrl: _source(_baqiFile),
  ),
  MasoomeenShrine(
    id: 'imam_sadiq',
    title: 'Imam Sadiq (A.S)',
    location: 'Jannat al-Baqi, Madinah',
    assetPath: _asset('jannat_al_baqi.jpg'),
    imageUrl: _image(_baqiFile),
    sourceUrl: _source(_baqiFile),
  ),
  MasoomeenShrine(
    id: 'imam_kazim',
    title: 'Imam Kazim (A.S)',
    location: 'Kadhimiya, Baghdad',
    assetPath: _asset('kadhimiya_shrine.jpg'),
    imageUrl: _image(_kadhimiyaFile),
    sourceUrl: _source(_kadhimiyaFile),
  ),
  MasoomeenShrine(
    id: 'imam_reza',
    title: 'Imam Reza (A.S)',
    location: 'Mashhad, Iran',
    assetPath: _asset('mashhad_imam_reza.jpg'),
    imageUrl: _image(_mashhadFile),
    sourceUrl: _source(_mashhadFile),
  ),
  MasoomeenShrine(
    id: 'imam_taqi',
    title: 'Imam Taqi (A.S)',
    location: 'Kadhimiya, Baghdad',
    assetPath: _asset('kadhimiya_shrine.jpg'),
    imageUrl: _image(_kadhimiyaFile),
    sourceUrl: _source(_kadhimiyaFile),
  ),
  MasoomeenShrine(
    id: 'imam_naqi',
    title: 'Imam Naqi (A.S)',
    location: 'Samarra, Iraq',
    assetPath: _asset('samarra_askari_shrine.jpg'),
    imageUrl: _image(_samarraFile),
    sourceUrl: _source(_samarraFile),
  ),
  MasoomeenShrine(
    id: 'imam_hasan_askari',
    title: 'Imam Hasan Askari (A.S)',
    location: 'Samarra, Iraq',
    assetPath: _asset('samarra_askari_shrine.jpg'),
    imageUrl: _image(_samarraFile),
    sourceUrl: _source(_samarraFile),
  ),
  MasoomeenShrine(
    id: 'imam_mahdi',
    title: 'Imam Mahdi (A.S)',
    location: 'Associated holy sites in Samarra',
    assetPath: _asset('samarra_askari_shrine.jpg'),
    imageUrl: _image(_samarraFile),
    sourceUrl: _source(_samarraFile),
  ),
];

MasoomeenShrine shrineById(String id) {
  return masoomeenShrines.firstWhere(
    (shrine) => shrine.id == id,
    orElse: () => masoomeenShrines.first,
  );
}

int shrineIndexById(String id) {
  final index = masoomeenShrines.indexWhere((shrine) => shrine.id == id);
  return index < 0 ? 0 : index;
}
