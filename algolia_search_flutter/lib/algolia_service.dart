import 'package:algolia/algolia.dart';

import 'hospital.dart';

class AlgoliaService {
  AlgoliaService._privateConstructor();

  static final AlgoliaService instance = AlgoliaService._privateConstructor();

  final Algolia _algolia = Algolia.init(
    applicationId: 'XTNRG1Z6L2',
    apiKey: '7ade836544328633bcec3c8be81244a7',
  );

  AlgoliaIndexReference get _moviesIndex =>
      _algolia.instance.index('prod_covid_bed_application');

  Future<List<Hospital>> performMovieQuery({text: String}) async {
    final query = _moviesIndex.search(text);
    final snap = await query.getObjects();
    final movies = snap.hits.map((f) => Hospital.fromJSON(f.data)).toList();
    return movies;
  }
}
