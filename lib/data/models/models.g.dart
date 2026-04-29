// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetQuranCollection on Isar {
  IsarCollection<Quran> get qurans => this.collection();
}

const QuranSchema = CollectionSchema(
  name: r'Quran',
  id: -1460945959152248122,
  properties: {
    r'ayahCount': PropertySchema(
      id: 0,
      name: r'ayahCount',
      type: IsarType.long,
    ),
    r'bismillah': PropertySchema(
      id: 1,
      name: r'bismillah',
      type: IsarType.string,
    ),
    r'index': PropertySchema(
      id: 2,
      name: r'index',
      type: IsarType.long,
    ),
    r'meaning': PropertySchema(
      id: 3,
      name: r'meaning',
      type: IsarType.string,
    ),
    r'revelationType': PropertySchema(
      id: 4,
      name: r'revelationType',
      type: IsarType.string,
    ),
    r'surahName': PropertySchema(
      id: 5,
      name: r'surahName',
      type: IsarType.string,
    ),
    r'surahNameArabic': PropertySchema(
      id: 6,
      name: r'surahNameArabic',
      type: IsarType.string,
    ),
    r'surahNumber': PropertySchema(
      id: 7,
      name: r'surahNumber',
      type: IsarType.long,
    )
  },
  estimateSize: _quranEstimateSize,
  serialize: _quranSerialize,
  deserialize: _quranDeserialize,
  deserializeProp: _quranDeserializeProp,
  idName: r'id',
  indexes: {
    r'index': IndexSchema(
      id: -5425839060849557016,
      name: r'index',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'index',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _quranGetId,
  getLinks: _quranGetLinks,
  attach: _quranAttach,
  version: '3.1.0+1',
);

int _quranEstimateSize(
  Quran object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.bismillah.length * 3;
  bytesCount += 3 + object.meaning.length * 3;
  bytesCount += 3 + object.revelationType.length * 3;
  bytesCount += 3 + object.surahName.length * 3;
  bytesCount += 3 + object.surahNameArabic.length * 3;
  return bytesCount;
}

void _quranSerialize(
  Quran object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.ayahCount);
  writer.writeString(offsets[1], object.bismillah);
  writer.writeLong(offsets[2], object.index);
  writer.writeString(offsets[3], object.meaning);
  writer.writeString(offsets[4], object.revelationType);
  writer.writeString(offsets[5], object.surahName);
  writer.writeString(offsets[6], object.surahNameArabic);
  writer.writeLong(offsets[7], object.surahNumber);
}

Quran _quranDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Quran();
  object.ayahCount = reader.readLong(offsets[0]);
  object.bismillah = reader.readString(offsets[1]);
  object.id = id;
  object.index = reader.readLong(offsets[2]);
  object.meaning = reader.readString(offsets[3]);
  object.revelationType = reader.readString(offsets[4]);
  object.surahName = reader.readString(offsets[5]);
  object.surahNameArabic = reader.readString(offsets[6]);
  object.surahNumber = reader.readLong(offsets[7]);
  return object;
}

P _quranDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _quranGetId(Quran object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _quranGetLinks(Quran object) {
  return [];
}

void _quranAttach(IsarCollection<dynamic> col, Id id, Quran object) {
  object.id = id;
}

extension QuranQueryWhereSort on QueryBuilder<Quran, Quran, QWhere> {
  QueryBuilder<Quran, Quran, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Quran, Quran, QAfterWhere> anyIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'index'),
      );
    });
  }
}

extension QuranQueryWhere on QueryBuilder<Quran, Quran, QWhereClause> {
  QueryBuilder<Quran, Quran, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Quran, Quran, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Quran, Quran, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Quran, Quran, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterWhereClause> indexEqualTo(int index) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'index',
        value: [index],
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterWhereClause> indexNotEqualTo(int index) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'index',
              lower: [],
              upper: [index],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'index',
              lower: [index],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'index',
              lower: [index],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'index',
              lower: [],
              upper: [index],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Quran, Quran, QAfterWhereClause> indexGreaterThan(
    int index, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'index',
        lower: [index],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterWhereClause> indexLessThan(
    int index, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'index',
        lower: [],
        upper: [index],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterWhereClause> indexBetween(
    int lowerIndex,
    int upperIndex, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'index',
        lower: [lowerIndex],
        includeLower: includeLower,
        upper: [upperIndex],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension QuranQueryFilter on QueryBuilder<Quran, Quran, QFilterCondition> {
  QueryBuilder<Quran, Quran, QAfterFilterCondition> ayahCountEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ayahCount',
        value: value,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> ayahCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ayahCount',
        value: value,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> ayahCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ayahCount',
        value: value,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> ayahCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ayahCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> bismillahEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bismillah',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> bismillahGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bismillah',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> bismillahLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bismillah',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> bismillahBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bismillah',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> bismillahStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bismillah',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> bismillahEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bismillah',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> bismillahContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bismillah',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> bismillahMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bismillah',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> bismillahIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bismillah',
        value: '',
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> bismillahIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bismillah',
        value: '',
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> indexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'index',
        value: value,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> indexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'index',
        value: value,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> indexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'index',
        value: value,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> indexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'index',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> meaningEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'meaning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> meaningGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'meaning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> meaningLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'meaning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> meaningBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'meaning',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> meaningStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'meaning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> meaningEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'meaning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> meaningContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'meaning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> meaningMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'meaning',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> meaningIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'meaning',
        value: '',
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> meaningIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'meaning',
        value: '',
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> revelationTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'revelationType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> revelationTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'revelationType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> revelationTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'revelationType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> revelationTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'revelationType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> revelationTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'revelationType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> revelationTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'revelationType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> revelationTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'revelationType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> revelationTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'revelationType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> revelationTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'revelationType',
        value: '',
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> revelationTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'revelationType',
        value: '',
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> surahNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'surahName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> surahNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'surahName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> surahNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'surahName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> surahNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'surahName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> surahNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'surahName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> surahNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'surahName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> surahNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'surahName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> surahNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'surahName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> surahNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'surahName',
        value: '',
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> surahNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'surahName',
        value: '',
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> surahNameArabicEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'surahNameArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> surahNameArabicGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'surahNameArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> surahNameArabicLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'surahNameArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> surahNameArabicBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'surahNameArabic',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> surahNameArabicStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'surahNameArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> surahNameArabicEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'surahNameArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> surahNameArabicContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'surahNameArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> surahNameArabicMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'surahNameArabic',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> surahNameArabicIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'surahNameArabic',
        value: '',
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition>
      surahNameArabicIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'surahNameArabic',
        value: '',
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> surahNumberEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'surahNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> surahNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'surahNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> surahNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'surahNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<Quran, Quran, QAfterFilterCondition> surahNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'surahNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension QuranQueryObject on QueryBuilder<Quran, Quran, QFilterCondition> {}

extension QuranQueryLinks on QueryBuilder<Quran, Quran, QFilterCondition> {}

extension QuranQuerySortBy on QueryBuilder<Quran, Quran, QSortBy> {
  QueryBuilder<Quran, Quran, QAfterSortBy> sortByAyahCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ayahCount', Sort.asc);
    });
  }

  QueryBuilder<Quran, Quran, QAfterSortBy> sortByAyahCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ayahCount', Sort.desc);
    });
  }

  QueryBuilder<Quran, Quran, QAfterSortBy> sortByBismillah() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bismillah', Sort.asc);
    });
  }

  QueryBuilder<Quran, Quran, QAfterSortBy> sortByBismillahDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bismillah', Sort.desc);
    });
  }

  QueryBuilder<Quran, Quran, QAfterSortBy> sortByIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index', Sort.asc);
    });
  }

  QueryBuilder<Quran, Quran, QAfterSortBy> sortByIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index', Sort.desc);
    });
  }

  QueryBuilder<Quran, Quran, QAfterSortBy> sortByMeaning() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meaning', Sort.asc);
    });
  }

  QueryBuilder<Quran, Quran, QAfterSortBy> sortByMeaningDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meaning', Sort.desc);
    });
  }

  QueryBuilder<Quran, Quran, QAfterSortBy> sortByRevelationType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'revelationType', Sort.asc);
    });
  }

  QueryBuilder<Quran, Quran, QAfterSortBy> sortByRevelationTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'revelationType', Sort.desc);
    });
  }

  QueryBuilder<Quran, Quran, QAfterSortBy> sortBySurahName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surahName', Sort.asc);
    });
  }

  QueryBuilder<Quran, Quran, QAfterSortBy> sortBySurahNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surahName', Sort.desc);
    });
  }

  QueryBuilder<Quran, Quran, QAfterSortBy> sortBySurahNameArabic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surahNameArabic', Sort.asc);
    });
  }

  QueryBuilder<Quran, Quran, QAfterSortBy> sortBySurahNameArabicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surahNameArabic', Sort.desc);
    });
  }

  QueryBuilder<Quran, Quran, QAfterSortBy> sortBySurahNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surahNumber', Sort.asc);
    });
  }

  QueryBuilder<Quran, Quran, QAfterSortBy> sortBySurahNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surahNumber', Sort.desc);
    });
  }
}

extension QuranQuerySortThenBy on QueryBuilder<Quran, Quran, QSortThenBy> {
  QueryBuilder<Quran, Quran, QAfterSortBy> thenByAyahCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ayahCount', Sort.asc);
    });
  }

  QueryBuilder<Quran, Quran, QAfterSortBy> thenByAyahCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ayahCount', Sort.desc);
    });
  }

  QueryBuilder<Quran, Quran, QAfterSortBy> thenByBismillah() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bismillah', Sort.asc);
    });
  }

  QueryBuilder<Quran, Quran, QAfterSortBy> thenByBismillahDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bismillah', Sort.desc);
    });
  }

  QueryBuilder<Quran, Quran, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Quran, Quran, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Quran, Quran, QAfterSortBy> thenByIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index', Sort.asc);
    });
  }

  QueryBuilder<Quran, Quran, QAfterSortBy> thenByIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index', Sort.desc);
    });
  }

  QueryBuilder<Quran, Quran, QAfterSortBy> thenByMeaning() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meaning', Sort.asc);
    });
  }

  QueryBuilder<Quran, Quran, QAfterSortBy> thenByMeaningDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meaning', Sort.desc);
    });
  }

  QueryBuilder<Quran, Quran, QAfterSortBy> thenByRevelationType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'revelationType', Sort.asc);
    });
  }

  QueryBuilder<Quran, Quran, QAfterSortBy> thenByRevelationTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'revelationType', Sort.desc);
    });
  }

  QueryBuilder<Quran, Quran, QAfterSortBy> thenBySurahName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surahName', Sort.asc);
    });
  }

  QueryBuilder<Quran, Quran, QAfterSortBy> thenBySurahNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surahName', Sort.desc);
    });
  }

  QueryBuilder<Quran, Quran, QAfterSortBy> thenBySurahNameArabic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surahNameArabic', Sort.asc);
    });
  }

  QueryBuilder<Quran, Quran, QAfterSortBy> thenBySurahNameArabicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surahNameArabic', Sort.desc);
    });
  }

  QueryBuilder<Quran, Quran, QAfterSortBy> thenBySurahNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surahNumber', Sort.asc);
    });
  }

  QueryBuilder<Quran, Quran, QAfterSortBy> thenBySurahNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surahNumber', Sort.desc);
    });
  }
}

extension QuranQueryWhereDistinct on QueryBuilder<Quran, Quran, QDistinct> {
  QueryBuilder<Quran, Quran, QDistinct> distinctByAyahCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ayahCount');
    });
  }

  QueryBuilder<Quran, Quran, QDistinct> distinctByBismillah(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bismillah', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Quran, Quran, QDistinct> distinctByIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'index');
    });
  }

  QueryBuilder<Quran, Quran, QDistinct> distinctByMeaning(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'meaning', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Quran, Quran, QDistinct> distinctByRevelationType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'revelationType',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Quran, Quran, QDistinct> distinctBySurahName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'surahName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Quran, Quran, QDistinct> distinctBySurahNameArabic(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'surahNameArabic',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Quran, Quran, QDistinct> distinctBySurahNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'surahNumber');
    });
  }
}

extension QuranQueryProperty on QueryBuilder<Quran, Quran, QQueryProperty> {
  QueryBuilder<Quran, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Quran, int, QQueryOperations> ayahCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ayahCount');
    });
  }

  QueryBuilder<Quran, String, QQueryOperations> bismillahProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bismillah');
    });
  }

  QueryBuilder<Quran, int, QQueryOperations> indexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'index');
    });
  }

  QueryBuilder<Quran, String, QQueryOperations> meaningProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'meaning');
    });
  }

  QueryBuilder<Quran, String, QQueryOperations> revelationTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'revelationType');
    });
  }

  QueryBuilder<Quran, String, QQueryOperations> surahNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'surahName');
    });
  }

  QueryBuilder<Quran, String, QQueryOperations> surahNameArabicProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'surahNameArabic');
    });
  }

  QueryBuilder<Quran, int, QQueryOperations> surahNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'surahNumber');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetQuranAyahCollection on Isar {
  IsarCollection<QuranAyah> get quranAyahs => this.collection();
}

const QuranAyahSchema = CollectionSchema(
  name: r'QuranAyah',
  id: -5788100502552865987,
  properties: {
    r'audioUrls': PropertySchema(
      id: 0,
      name: r'audioUrls',
      type: IsarType.stringList,
    ),
    r'ayahNumber': PropertySchema(
      id: 1,
      name: r'ayahNumber',
      type: IsarType.long,
    ),
    r'surahNumber': PropertySchema(
      id: 2,
      name: r'surahNumber',
      type: IsarType.long,
    ),
    r'surahNumberIndex': PropertySchema(
      id: 3,
      name: r'surahNumberIndex',
      type: IsarType.long,
    ),
    r'textArabic': PropertySchema(
      id: 4,
      name: r'textArabic',
      type: IsarType.string,
    ),
    r'textEnglish': PropertySchema(
      id: 5,
      name: r'textEnglish',
      type: IsarType.string,
    ),
    r'textFarsi': PropertySchema(
      id: 6,
      name: r'textFarsi',
      type: IsarType.string,
    ),
    r'textUrdu': PropertySchema(
      id: 7,
      name: r'textUrdu',
      type: IsarType.string,
    ),
    r'transliteration': PropertySchema(
      id: 8,
      name: r'transliteration',
      type: IsarType.string,
    )
  },
  estimateSize: _quranAyahEstimateSize,
  serialize: _quranAyahSerialize,
  deserialize: _quranAyahDeserialize,
  deserializeProp: _quranAyahDeserializeProp,
  idName: r'id',
  indexes: {
    r'surahNumberIndex': IndexSchema(
      id: 4082785298524393147,
      name: r'surahNumberIndex',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'surahNumberIndex',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _quranAyahGetId,
  getLinks: _quranAyahGetLinks,
  attach: _quranAyahAttach,
  version: '3.1.0+1',
);

int _quranAyahEstimateSize(
  QuranAyah object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.audioUrls.length * 3;
  {
    for (var i = 0; i < object.audioUrls.length; i++) {
      final value = object.audioUrls[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.textArabic.length * 3;
  bytesCount += 3 + object.textEnglish.length * 3;
  bytesCount += 3 + object.textFarsi.length * 3;
  bytesCount += 3 + object.textUrdu.length * 3;
  bytesCount += 3 + object.transliteration.length * 3;
  return bytesCount;
}

void _quranAyahSerialize(
  QuranAyah object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.audioUrls);
  writer.writeLong(offsets[1], object.ayahNumber);
  writer.writeLong(offsets[2], object.surahNumber);
  writer.writeLong(offsets[3], object.surahNumberIndex);
  writer.writeString(offsets[4], object.textArabic);
  writer.writeString(offsets[5], object.textEnglish);
  writer.writeString(offsets[6], object.textFarsi);
  writer.writeString(offsets[7], object.textUrdu);
  writer.writeString(offsets[8], object.transliteration);
}

QuranAyah _quranAyahDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = QuranAyah();
  object.audioUrls = reader.readStringList(offsets[0]) ?? [];
  object.ayahNumber = reader.readLong(offsets[1]);
  object.id = id;
  object.surahNumber = reader.readLong(offsets[2]);
  object.surahNumberIndex = reader.readLong(offsets[3]);
  object.textArabic = reader.readString(offsets[4]);
  object.textEnglish = reader.readString(offsets[5]);
  object.textFarsi = reader.readString(offsets[6]);
  object.textUrdu = reader.readString(offsets[7]);
  object.transliteration = reader.readString(offsets[8]);
  return object;
}

P _quranAyahDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset) ?? []) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _quranAyahGetId(QuranAyah object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _quranAyahGetLinks(QuranAyah object) {
  return [];
}

void _quranAyahAttach(IsarCollection<dynamic> col, Id id, QuranAyah object) {
  object.id = id;
}

extension QuranAyahQueryWhereSort
    on QueryBuilder<QuranAyah, QuranAyah, QWhere> {
  QueryBuilder<QuranAyah, QuranAyah, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterWhere> anySurahNumberIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'surahNumberIndex'),
      );
    });
  }
}

extension QuranAyahQueryWhere
    on QueryBuilder<QuranAyah, QuranAyah, QWhereClause> {
  QueryBuilder<QuranAyah, QuranAyah, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterWhereClause> surahNumberIndexEqualTo(
      int surahNumberIndex) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'surahNumberIndex',
        value: [surahNumberIndex],
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterWhereClause>
      surahNumberIndexNotEqualTo(int surahNumberIndex) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'surahNumberIndex',
              lower: [],
              upper: [surahNumberIndex],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'surahNumberIndex',
              lower: [surahNumberIndex],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'surahNumberIndex',
              lower: [surahNumberIndex],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'surahNumberIndex',
              lower: [],
              upper: [surahNumberIndex],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterWhereClause>
      surahNumberIndexGreaterThan(
    int surahNumberIndex, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'surahNumberIndex',
        lower: [surahNumberIndex],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterWhereClause>
      surahNumberIndexLessThan(
    int surahNumberIndex, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'surahNumberIndex',
        lower: [],
        upper: [surahNumberIndex],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterWhereClause> surahNumberIndexBetween(
    int lowerSurahNumberIndex,
    int upperSurahNumberIndex, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'surahNumberIndex',
        lower: [lowerSurahNumberIndex],
        includeLower: includeLower,
        upper: [upperSurahNumberIndex],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension QuranAyahQueryFilter
    on QueryBuilder<QuranAyah, QuranAyah, QFilterCondition> {
  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      audioUrlsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audioUrls',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      audioUrlsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'audioUrls',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      audioUrlsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'audioUrls',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      audioUrlsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'audioUrls',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      audioUrlsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'audioUrls',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      audioUrlsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'audioUrls',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      audioUrlsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'audioUrls',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      audioUrlsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'audioUrls',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      audioUrlsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audioUrls',
        value: '',
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      audioUrlsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'audioUrls',
        value: '',
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      audioUrlsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'audioUrls',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> audioUrlsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'audioUrls',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      audioUrlsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'audioUrls',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      audioUrlsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'audioUrls',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      audioUrlsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'audioUrls',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      audioUrlsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'audioUrls',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> ayahNumberEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ayahNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      ayahNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ayahNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> ayahNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ayahNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> ayahNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ayahNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> surahNumberEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'surahNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      surahNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'surahNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> surahNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'surahNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> surahNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'surahNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      surahNumberIndexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'surahNumberIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      surahNumberIndexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'surahNumberIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      surahNumberIndexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'surahNumberIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      surahNumberIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'surahNumberIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textArabicEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      textArabicGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'textArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textArabicLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'textArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textArabicBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'textArabic',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      textArabicStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'textArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textArabicEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'textArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textArabicContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'textArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textArabicMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'textArabic',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      textArabicIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textArabic',
        value: '',
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      textArabicIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'textArabic',
        value: '',
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textEnglishEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textEnglish',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      textEnglishGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'textEnglish',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textEnglishLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'textEnglish',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textEnglishBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'textEnglish',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      textEnglishStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'textEnglish',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textEnglishEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'textEnglish',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textEnglishContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'textEnglish',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textEnglishMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'textEnglish',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      textEnglishIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textEnglish',
        value: '',
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      textEnglishIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'textEnglish',
        value: '',
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textFarsiEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textFarsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      textFarsiGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'textFarsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textFarsiLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'textFarsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textFarsiBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'textFarsi',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textFarsiStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'textFarsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textFarsiEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'textFarsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textFarsiContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'textFarsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textFarsiMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'textFarsi',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textFarsiIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textFarsi',
        value: '',
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      textFarsiIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'textFarsi',
        value: '',
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textUrduEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textUrdu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textUrduGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'textUrdu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textUrduLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'textUrdu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textUrduBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'textUrdu',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textUrduStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'textUrdu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textUrduEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'textUrdu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textUrduContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'textUrdu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textUrduMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'textUrdu',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textUrduIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textUrdu',
        value: '',
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      textUrduIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'textUrdu',
        value: '',
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      transliterationEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'transliteration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      transliterationGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'transliteration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      transliterationLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'transliteration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      transliterationBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'transliteration',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      transliterationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'transliteration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      transliterationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'transliteration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      transliterationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'transliteration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      transliterationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'transliteration',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      transliterationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'transliteration',
        value: '',
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      transliterationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'transliteration',
        value: '',
      ));
    });
  }
}

extension QuranAyahQueryObject
    on QueryBuilder<QuranAyah, QuranAyah, QFilterCondition> {}

extension QuranAyahQueryLinks
    on QueryBuilder<QuranAyah, QuranAyah, QFilterCondition> {}

extension QuranAyahQuerySortBy on QueryBuilder<QuranAyah, QuranAyah, QSortBy> {
  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> sortByAyahNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ayahNumber', Sort.asc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> sortByAyahNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ayahNumber', Sort.desc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> sortBySurahNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surahNumber', Sort.asc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> sortBySurahNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surahNumber', Sort.desc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> sortBySurahNumberIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surahNumberIndex', Sort.asc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy>
      sortBySurahNumberIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surahNumberIndex', Sort.desc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> sortByTextArabic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textArabic', Sort.asc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> sortByTextArabicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textArabic', Sort.desc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> sortByTextEnglish() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textEnglish', Sort.asc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> sortByTextEnglishDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textEnglish', Sort.desc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> sortByTextFarsi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textFarsi', Sort.asc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> sortByTextFarsiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textFarsi', Sort.desc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> sortByTextUrdu() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textUrdu', Sort.asc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> sortByTextUrduDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textUrdu', Sort.desc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> sortByTransliteration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transliteration', Sort.asc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> sortByTransliterationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transliteration', Sort.desc);
    });
  }
}

extension QuranAyahQuerySortThenBy
    on QueryBuilder<QuranAyah, QuranAyah, QSortThenBy> {
  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> thenByAyahNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ayahNumber', Sort.asc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> thenByAyahNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ayahNumber', Sort.desc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> thenBySurahNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surahNumber', Sort.asc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> thenBySurahNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surahNumber', Sort.desc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> thenBySurahNumberIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surahNumberIndex', Sort.asc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy>
      thenBySurahNumberIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surahNumberIndex', Sort.desc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> thenByTextArabic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textArabic', Sort.asc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> thenByTextArabicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textArabic', Sort.desc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> thenByTextEnglish() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textEnglish', Sort.asc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> thenByTextEnglishDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textEnglish', Sort.desc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> thenByTextFarsi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textFarsi', Sort.asc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> thenByTextFarsiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textFarsi', Sort.desc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> thenByTextUrdu() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textUrdu', Sort.asc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> thenByTextUrduDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textUrdu', Sort.desc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> thenByTransliteration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transliteration', Sort.asc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> thenByTransliterationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transliteration', Sort.desc);
    });
  }
}

extension QuranAyahQueryWhereDistinct
    on QueryBuilder<QuranAyah, QuranAyah, QDistinct> {
  QueryBuilder<QuranAyah, QuranAyah, QDistinct> distinctByAudioUrls() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'audioUrls');
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QDistinct> distinctByAyahNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ayahNumber');
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QDistinct> distinctBySurahNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'surahNumber');
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QDistinct> distinctBySurahNumberIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'surahNumberIndex');
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QDistinct> distinctByTextArabic(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'textArabic', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QDistinct> distinctByTextEnglish(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'textEnglish', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QDistinct> distinctByTextFarsi(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'textFarsi', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QDistinct> distinctByTextUrdu(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'textUrdu', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QDistinct> distinctByTransliteration(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'transliteration',
          caseSensitive: caseSensitive);
    });
  }
}

extension QuranAyahQueryProperty
    on QueryBuilder<QuranAyah, QuranAyah, QQueryProperty> {
  QueryBuilder<QuranAyah, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<QuranAyah, List<String>, QQueryOperations> audioUrlsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'audioUrls');
    });
  }

  QueryBuilder<QuranAyah, int, QQueryOperations> ayahNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ayahNumber');
    });
  }

  QueryBuilder<QuranAyah, int, QQueryOperations> surahNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'surahNumber');
    });
  }

  QueryBuilder<QuranAyah, int, QQueryOperations> surahNumberIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'surahNumberIndex');
    });
  }

  QueryBuilder<QuranAyah, String, QQueryOperations> textArabicProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'textArabic');
    });
  }

  QueryBuilder<QuranAyah, String, QQueryOperations> textEnglishProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'textEnglish');
    });
  }

  QueryBuilder<QuranAyah, String, QQueryOperations> textFarsiProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'textFarsi');
    });
  }

  QueryBuilder<QuranAyah, String, QQueryOperations> textUrduProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'textUrdu');
    });
  }

  QueryBuilder<QuranAyah, String, QQueryOperations> transliterationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'transliteration');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDuaCollection on Isar {
  IsarCollection<Dua> get duas => this.collection();
}

const DuaSchema = CollectionSchema(
  name: r'Dua',
  id: -1529649812736087549,
  properties: {
    r'audioUrl': PropertySchema(
      id: 0,
      name: r'audioUrl',
      type: IsarType.string,
    ),
    r'category': PropertySchema(
      id: 1,
      name: r'category',
      type: IsarType.string,
    ),
    r'description': PropertySchema(
      id: 2,
      name: r'description',
      type: IsarType.string,
    ),
    r'duaNumber': PropertySchema(
      id: 3,
      name: r'duaNumber',
      type: IsarType.long,
    ),
    r'index': PropertySchema(
      id: 4,
      name: r'index',
      type: IsarType.long,
    ),
    r'name': PropertySchema(
      id: 5,
      name: r'name',
      type: IsarType.string,
    ),
    r'nameArabic': PropertySchema(
      id: 6,
      name: r'nameArabic',
      type: IsarType.string,
    )
  },
  estimateSize: _duaEstimateSize,
  serialize: _duaSerialize,
  deserialize: _duaDeserialize,
  deserializeProp: _duaDeserializeProp,
  idName: r'id',
  indexes: {
    r'index': IndexSchema(
      id: -5425839060849557016,
      name: r'index',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'index',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _duaGetId,
  getLinks: _duaGetLinks,
  attach: _duaAttach,
  version: '3.1.0+1',
);

int _duaEstimateSize(
  Dua object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.audioUrl.length * 3;
  bytesCount += 3 + object.category.length * 3;
  bytesCount += 3 + object.description.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.nameArabic.length * 3;
  return bytesCount;
}

void _duaSerialize(
  Dua object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.audioUrl);
  writer.writeString(offsets[1], object.category);
  writer.writeString(offsets[2], object.description);
  writer.writeLong(offsets[3], object.duaNumber);
  writer.writeLong(offsets[4], object.index);
  writer.writeString(offsets[5], object.name);
  writer.writeString(offsets[6], object.nameArabic);
}

Dua _duaDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Dua();
  object.audioUrl = reader.readString(offsets[0]);
  object.category = reader.readString(offsets[1]);
  object.description = reader.readString(offsets[2]);
  object.duaNumber = reader.readLong(offsets[3]);
  object.id = id;
  object.index = reader.readLong(offsets[4]);
  object.name = reader.readString(offsets[5]);
  object.nameArabic = reader.readString(offsets[6]);
  return object;
}

P _duaDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _duaGetId(Dua object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _duaGetLinks(Dua object) {
  return [];
}

void _duaAttach(IsarCollection<dynamic> col, Id id, Dua object) {
  object.id = id;
}

extension DuaQueryWhereSort on QueryBuilder<Dua, Dua, QWhere> {
  QueryBuilder<Dua, Dua, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Dua, Dua, QAfterWhere> anyIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'index'),
      );
    });
  }
}

extension DuaQueryWhere on QueryBuilder<Dua, Dua, QWhereClause> {
  QueryBuilder<Dua, Dua, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Dua, Dua, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Dua, Dua, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Dua, Dua, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterWhereClause> indexEqualTo(int index) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'index',
        value: [index],
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterWhereClause> indexNotEqualTo(int index) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'index',
              lower: [],
              upper: [index],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'index',
              lower: [index],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'index',
              lower: [index],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'index',
              lower: [],
              upper: [index],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Dua, Dua, QAfterWhereClause> indexGreaterThan(
    int index, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'index',
        lower: [index],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterWhereClause> indexLessThan(
    int index, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'index',
        lower: [],
        upper: [index],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterWhereClause> indexBetween(
    int lowerIndex,
    int upperIndex, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'index',
        lower: [lowerIndex],
        includeLower: includeLower,
        upper: [upperIndex],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DuaQueryFilter on QueryBuilder<Dua, Dua, QFilterCondition> {
  QueryBuilder<Dua, Dua, QAfterFilterCondition> audioUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> audioUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> audioUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> audioUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'audioUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> audioUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> audioUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> audioUrlContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> audioUrlMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'audioUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> audioUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audioUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> audioUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'audioUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> categoryEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> categoryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> categoryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> categoryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> categoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> categoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> categoryContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> categoryMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> descriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> descriptionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> descriptionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> duaNumberEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'duaNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> duaNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'duaNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> duaNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'duaNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> duaNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'duaNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> indexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'index',
        value: value,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> indexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'index',
        value: value,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> indexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'index',
        value: value,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> indexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'index',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> nameArabicEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nameArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> nameArabicGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nameArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> nameArabicLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nameArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> nameArabicBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nameArabic',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> nameArabicStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nameArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> nameArabicEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nameArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> nameArabicContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nameArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> nameArabicMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nameArabic',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> nameArabicIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nameArabic',
        value: '',
      ));
    });
  }

  QueryBuilder<Dua, Dua, QAfterFilterCondition> nameArabicIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nameArabic',
        value: '',
      ));
    });
  }
}

extension DuaQueryObject on QueryBuilder<Dua, Dua, QFilterCondition> {}

extension DuaQueryLinks on QueryBuilder<Dua, Dua, QFilterCondition> {}

extension DuaQuerySortBy on QueryBuilder<Dua, Dua, QSortBy> {
  QueryBuilder<Dua, Dua, QAfterSortBy> sortByAudioUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioUrl', Sort.asc);
    });
  }

  QueryBuilder<Dua, Dua, QAfterSortBy> sortByAudioUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioUrl', Sort.desc);
    });
  }

  QueryBuilder<Dua, Dua, QAfterSortBy> sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<Dua, Dua, QAfterSortBy> sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<Dua, Dua, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Dua, Dua, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Dua, Dua, QAfterSortBy> sortByDuaNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duaNumber', Sort.asc);
    });
  }

  QueryBuilder<Dua, Dua, QAfterSortBy> sortByDuaNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duaNumber', Sort.desc);
    });
  }

  QueryBuilder<Dua, Dua, QAfterSortBy> sortByIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index', Sort.asc);
    });
  }

  QueryBuilder<Dua, Dua, QAfterSortBy> sortByIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index', Sort.desc);
    });
  }

  QueryBuilder<Dua, Dua, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Dua, Dua, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Dua, Dua, QAfterSortBy> sortByNameArabic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameArabic', Sort.asc);
    });
  }

  QueryBuilder<Dua, Dua, QAfterSortBy> sortByNameArabicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameArabic', Sort.desc);
    });
  }
}

extension DuaQuerySortThenBy on QueryBuilder<Dua, Dua, QSortThenBy> {
  QueryBuilder<Dua, Dua, QAfterSortBy> thenByAudioUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioUrl', Sort.asc);
    });
  }

  QueryBuilder<Dua, Dua, QAfterSortBy> thenByAudioUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioUrl', Sort.desc);
    });
  }

  QueryBuilder<Dua, Dua, QAfterSortBy> thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<Dua, Dua, QAfterSortBy> thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<Dua, Dua, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Dua, Dua, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Dua, Dua, QAfterSortBy> thenByDuaNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duaNumber', Sort.asc);
    });
  }

  QueryBuilder<Dua, Dua, QAfterSortBy> thenByDuaNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duaNumber', Sort.desc);
    });
  }

  QueryBuilder<Dua, Dua, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Dua, Dua, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Dua, Dua, QAfterSortBy> thenByIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index', Sort.asc);
    });
  }

  QueryBuilder<Dua, Dua, QAfterSortBy> thenByIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index', Sort.desc);
    });
  }

  QueryBuilder<Dua, Dua, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Dua, Dua, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Dua, Dua, QAfterSortBy> thenByNameArabic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameArabic', Sort.asc);
    });
  }

  QueryBuilder<Dua, Dua, QAfterSortBy> thenByNameArabicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameArabic', Sort.desc);
    });
  }
}

extension DuaQueryWhereDistinct on QueryBuilder<Dua, Dua, QDistinct> {
  QueryBuilder<Dua, Dua, QDistinct> distinctByAudioUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'audioUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Dua, Dua, QDistinct> distinctByCategory(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Dua, Dua, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Dua, Dua, QDistinct> distinctByDuaNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'duaNumber');
    });
  }

  QueryBuilder<Dua, Dua, QDistinct> distinctByIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'index');
    });
  }

  QueryBuilder<Dua, Dua, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Dua, Dua, QDistinct> distinctByNameArabic(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nameArabic', caseSensitive: caseSensitive);
    });
  }
}

extension DuaQueryProperty on QueryBuilder<Dua, Dua, QQueryProperty> {
  QueryBuilder<Dua, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Dua, String, QQueryOperations> audioUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'audioUrl');
    });
  }

  QueryBuilder<Dua, String, QQueryOperations> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<Dua, String, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<Dua, int, QQueryOperations> duaNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'duaNumber');
    });
  }

  QueryBuilder<Dua, int, QQueryOperations> indexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'index');
    });
  }

  QueryBuilder<Dua, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Dua, String, QQueryOperations> nameArabicProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nameArabic');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDuaLineCollection on Isar {
  IsarCollection<DuaLine> get duaLines => this.collection();
}

const DuaLineSchema = CollectionSchema(
  name: r'DuaLine',
  id: 1271067902168354141,
  properties: {
    r'audioEndTime': PropertySchema(
      id: 0,
      name: r'audioEndTime',
      type: IsarType.long,
    ),
    r'audioStartTime': PropertySchema(
      id: 1,
      name: r'audioStartTime',
      type: IsarType.long,
    ),
    r'audioUrl': PropertySchema(
      id: 2,
      name: r'audioUrl',
      type: IsarType.string,
    ),
    r'duaId': PropertySchema(
      id: 3,
      name: r'duaId',
      type: IsarType.long,
    ),
    r'duaIdIndex': PropertySchema(
      id: 4,
      name: r'duaIdIndex',
      type: IsarType.long,
    ),
    r'lineNumber': PropertySchema(
      id: 5,
      name: r'lineNumber',
      type: IsarType.long,
    ),
    r'textArabic': PropertySchema(
      id: 6,
      name: r'textArabic',
      type: IsarType.string,
    ),
    r'textEnglish': PropertySchema(
      id: 7,
      name: r'textEnglish',
      type: IsarType.string,
    ),
    r'textFarsi': PropertySchema(
      id: 8,
      name: r'textFarsi',
      type: IsarType.string,
    ),
    r'textUrdu': PropertySchema(
      id: 9,
      name: r'textUrdu',
      type: IsarType.string,
    ),
    r'transliteration': PropertySchema(
      id: 10,
      name: r'transliteration',
      type: IsarType.string,
    )
  },
  estimateSize: _duaLineEstimateSize,
  serialize: _duaLineSerialize,
  deserialize: _duaLineDeserialize,
  deserializeProp: _duaLineDeserializeProp,
  idName: r'id',
  indexes: {
    r'duaIdIndex': IndexSchema(
      id: -8405388787223209636,
      name: r'duaIdIndex',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'duaIdIndex',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _duaLineGetId,
  getLinks: _duaLineGetLinks,
  attach: _duaLineAttach,
  version: '3.1.0+1',
);

int _duaLineEstimateSize(
  DuaLine object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.audioUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.textArabic.length * 3;
  bytesCount += 3 + object.textEnglish.length * 3;
  bytesCount += 3 + object.textFarsi.length * 3;
  bytesCount += 3 + object.textUrdu.length * 3;
  bytesCount += 3 + object.transliteration.length * 3;
  return bytesCount;
}

void _duaLineSerialize(
  DuaLine object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.audioEndTime);
  writer.writeLong(offsets[1], object.audioStartTime);
  writer.writeString(offsets[2], object.audioUrl);
  writer.writeLong(offsets[3], object.duaId);
  writer.writeLong(offsets[4], object.duaIdIndex);
  writer.writeLong(offsets[5], object.lineNumber);
  writer.writeString(offsets[6], object.textArabic);
  writer.writeString(offsets[7], object.textEnglish);
  writer.writeString(offsets[8], object.textFarsi);
  writer.writeString(offsets[9], object.textUrdu);
  writer.writeString(offsets[10], object.transliteration);
}

DuaLine _duaLineDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DuaLine();
  object.audioEndTime = reader.readLongOrNull(offsets[0]);
  object.audioStartTime = reader.readLongOrNull(offsets[1]);
  object.audioUrl = reader.readStringOrNull(offsets[2]);
  object.duaId = reader.readLong(offsets[3]);
  object.duaIdIndex = reader.readLong(offsets[4]);
  object.id = id;
  object.lineNumber = reader.readLong(offsets[5]);
  object.textArabic = reader.readString(offsets[6]);
  object.textEnglish = reader.readString(offsets[7]);
  object.textFarsi = reader.readString(offsets[8]);
  object.textUrdu = reader.readString(offsets[9]);
  object.transliteration = reader.readString(offsets[10]);
  return object;
}

P _duaLineDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _duaLineGetId(DuaLine object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _duaLineGetLinks(DuaLine object) {
  return [];
}

void _duaLineAttach(IsarCollection<dynamic> col, Id id, DuaLine object) {
  object.id = id;
}

extension DuaLineQueryWhereSort on QueryBuilder<DuaLine, DuaLine, QWhere> {
  QueryBuilder<DuaLine, DuaLine, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterWhere> anyDuaIdIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'duaIdIndex'),
      );
    });
  }
}

extension DuaLineQueryWhere on QueryBuilder<DuaLine, DuaLine, QWhereClause> {
  QueryBuilder<DuaLine, DuaLine, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterWhereClause> duaIdIndexEqualTo(
      int duaIdIndex) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'duaIdIndex',
        value: [duaIdIndex],
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterWhereClause> duaIdIndexNotEqualTo(
      int duaIdIndex) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'duaIdIndex',
              lower: [],
              upper: [duaIdIndex],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'duaIdIndex',
              lower: [duaIdIndex],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'duaIdIndex',
              lower: [duaIdIndex],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'duaIdIndex',
              lower: [],
              upper: [duaIdIndex],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterWhereClause> duaIdIndexGreaterThan(
    int duaIdIndex, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'duaIdIndex',
        lower: [duaIdIndex],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterWhereClause> duaIdIndexLessThan(
    int duaIdIndex, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'duaIdIndex',
        lower: [],
        upper: [duaIdIndex],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterWhereClause> duaIdIndexBetween(
    int lowerDuaIdIndex,
    int upperDuaIdIndex, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'duaIdIndex',
        lower: [lowerDuaIdIndex],
        includeLower: includeLower,
        upper: [upperDuaIdIndex],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DuaLineQueryFilter
    on QueryBuilder<DuaLine, DuaLine, QFilterCondition> {
  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> audioEndTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'audioEndTime',
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition>
      audioEndTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'audioEndTime',
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> audioEndTimeEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audioEndTime',
        value: value,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> audioEndTimeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'audioEndTime',
        value: value,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> audioEndTimeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'audioEndTime',
        value: value,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> audioEndTimeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'audioEndTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> audioStartTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'audioStartTime',
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition>
      audioStartTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'audioStartTime',
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> audioStartTimeEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audioStartTime',
        value: value,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition>
      audioStartTimeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'audioStartTime',
        value: value,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> audioStartTimeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'audioStartTime',
        value: value,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> audioStartTimeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'audioStartTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> audioUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'audioUrl',
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> audioUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'audioUrl',
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> audioUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> audioUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> audioUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> audioUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'audioUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> audioUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> audioUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> audioUrlContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> audioUrlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'audioUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> audioUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audioUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> audioUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'audioUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> duaIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'duaId',
        value: value,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> duaIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'duaId',
        value: value,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> duaIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'duaId',
        value: value,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> duaIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'duaId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> duaIdIndexEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'duaIdIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> duaIdIndexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'duaIdIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> duaIdIndexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'duaIdIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> duaIdIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'duaIdIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> lineNumberEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lineNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> lineNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lineNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> lineNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lineNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> lineNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lineNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textArabicEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textArabicGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'textArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textArabicLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'textArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textArabicBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'textArabic',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textArabicStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'textArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textArabicEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'textArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textArabicContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'textArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textArabicMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'textArabic',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textArabicIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textArabic',
        value: '',
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textArabicIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'textArabic',
        value: '',
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textEnglishEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textEnglish',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textEnglishGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'textEnglish',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textEnglishLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'textEnglish',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textEnglishBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'textEnglish',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textEnglishStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'textEnglish',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textEnglishEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'textEnglish',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textEnglishContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'textEnglish',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textEnglishMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'textEnglish',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textEnglishIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textEnglish',
        value: '',
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition>
      textEnglishIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'textEnglish',
        value: '',
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textFarsiEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textFarsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textFarsiGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'textFarsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textFarsiLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'textFarsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textFarsiBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'textFarsi',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textFarsiStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'textFarsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textFarsiEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'textFarsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textFarsiContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'textFarsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textFarsiMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'textFarsi',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textFarsiIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textFarsi',
        value: '',
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textFarsiIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'textFarsi',
        value: '',
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textUrduEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textUrdu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textUrduGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'textUrdu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textUrduLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'textUrdu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textUrduBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'textUrdu',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textUrduStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'textUrdu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textUrduEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'textUrdu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textUrduContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'textUrdu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textUrduMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'textUrdu',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textUrduIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textUrdu',
        value: '',
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> textUrduIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'textUrdu',
        value: '',
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> transliterationEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'transliteration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition>
      transliterationGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'transliteration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> transliterationLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'transliteration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> transliterationBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'transliteration',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition>
      transliterationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'transliteration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> transliterationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'transliteration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> transliterationContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'transliteration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition> transliterationMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'transliteration',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition>
      transliterationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'transliteration',
        value: '',
      ));
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterFilterCondition>
      transliterationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'transliteration',
        value: '',
      ));
    });
  }
}

extension DuaLineQueryObject
    on QueryBuilder<DuaLine, DuaLine, QFilterCondition> {}

extension DuaLineQueryLinks
    on QueryBuilder<DuaLine, DuaLine, QFilterCondition> {}

extension DuaLineQuerySortBy on QueryBuilder<DuaLine, DuaLine, QSortBy> {
  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> sortByAudioEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioEndTime', Sort.asc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> sortByAudioEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioEndTime', Sort.desc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> sortByAudioStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioStartTime', Sort.asc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> sortByAudioStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioStartTime', Sort.desc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> sortByAudioUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioUrl', Sort.asc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> sortByAudioUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioUrl', Sort.desc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> sortByDuaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duaId', Sort.asc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> sortByDuaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duaId', Sort.desc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> sortByDuaIdIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duaIdIndex', Sort.asc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> sortByDuaIdIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duaIdIndex', Sort.desc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> sortByLineNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineNumber', Sort.asc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> sortByLineNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineNumber', Sort.desc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> sortByTextArabic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textArabic', Sort.asc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> sortByTextArabicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textArabic', Sort.desc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> sortByTextEnglish() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textEnglish', Sort.asc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> sortByTextEnglishDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textEnglish', Sort.desc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> sortByTextFarsi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textFarsi', Sort.asc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> sortByTextFarsiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textFarsi', Sort.desc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> sortByTextUrdu() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textUrdu', Sort.asc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> sortByTextUrduDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textUrdu', Sort.desc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> sortByTransliteration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transliteration', Sort.asc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> sortByTransliterationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transliteration', Sort.desc);
    });
  }
}

extension DuaLineQuerySortThenBy
    on QueryBuilder<DuaLine, DuaLine, QSortThenBy> {
  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> thenByAudioEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioEndTime', Sort.asc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> thenByAudioEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioEndTime', Sort.desc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> thenByAudioStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioStartTime', Sort.asc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> thenByAudioStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioStartTime', Sort.desc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> thenByAudioUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioUrl', Sort.asc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> thenByAudioUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioUrl', Sort.desc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> thenByDuaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duaId', Sort.asc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> thenByDuaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duaId', Sort.desc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> thenByDuaIdIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duaIdIndex', Sort.asc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> thenByDuaIdIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duaIdIndex', Sort.desc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> thenByLineNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineNumber', Sort.asc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> thenByLineNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineNumber', Sort.desc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> thenByTextArabic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textArabic', Sort.asc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> thenByTextArabicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textArabic', Sort.desc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> thenByTextEnglish() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textEnglish', Sort.asc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> thenByTextEnglishDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textEnglish', Sort.desc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> thenByTextFarsi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textFarsi', Sort.asc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> thenByTextFarsiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textFarsi', Sort.desc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> thenByTextUrdu() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textUrdu', Sort.asc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> thenByTextUrduDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textUrdu', Sort.desc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> thenByTransliteration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transliteration', Sort.asc);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QAfterSortBy> thenByTransliterationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transliteration', Sort.desc);
    });
  }
}

extension DuaLineQueryWhereDistinct
    on QueryBuilder<DuaLine, DuaLine, QDistinct> {
  QueryBuilder<DuaLine, DuaLine, QDistinct> distinctByAudioEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'audioEndTime');
    });
  }

  QueryBuilder<DuaLine, DuaLine, QDistinct> distinctByAudioStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'audioStartTime');
    });
  }

  QueryBuilder<DuaLine, DuaLine, QDistinct> distinctByAudioUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'audioUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QDistinct> distinctByDuaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'duaId');
    });
  }

  QueryBuilder<DuaLine, DuaLine, QDistinct> distinctByDuaIdIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'duaIdIndex');
    });
  }

  QueryBuilder<DuaLine, DuaLine, QDistinct> distinctByLineNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lineNumber');
    });
  }

  QueryBuilder<DuaLine, DuaLine, QDistinct> distinctByTextArabic(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'textArabic', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QDistinct> distinctByTextEnglish(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'textEnglish', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QDistinct> distinctByTextFarsi(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'textFarsi', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QDistinct> distinctByTextUrdu(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'textUrdu', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DuaLine, DuaLine, QDistinct> distinctByTransliteration(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'transliteration',
          caseSensitive: caseSensitive);
    });
  }
}

extension DuaLineQueryProperty
    on QueryBuilder<DuaLine, DuaLine, QQueryProperty> {
  QueryBuilder<DuaLine, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DuaLine, int?, QQueryOperations> audioEndTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'audioEndTime');
    });
  }

  QueryBuilder<DuaLine, int?, QQueryOperations> audioStartTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'audioStartTime');
    });
  }

  QueryBuilder<DuaLine, String?, QQueryOperations> audioUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'audioUrl');
    });
  }

  QueryBuilder<DuaLine, int, QQueryOperations> duaIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'duaId');
    });
  }

  QueryBuilder<DuaLine, int, QQueryOperations> duaIdIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'duaIdIndex');
    });
  }

  QueryBuilder<DuaLine, int, QQueryOperations> lineNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lineNumber');
    });
  }

  QueryBuilder<DuaLine, String, QQueryOperations> textArabicProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'textArabic');
    });
  }

  QueryBuilder<DuaLine, String, QQueryOperations> textEnglishProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'textEnglish');
    });
  }

  QueryBuilder<DuaLine, String, QQueryOperations> textFarsiProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'textFarsi');
    });
  }

  QueryBuilder<DuaLine, String, QQueryOperations> textUrduProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'textUrdu');
    });
  }

  QueryBuilder<DuaLine, String, QQueryOperations> transliterationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'transliteration');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetBookCollection on Isar {
  IsarCollection<Book> get books => this.collection();
}

const BookSchema = CollectionSchema(
  name: r'Book',
  id: 4089735379470416465,
  properties: {
    r'author': PropertySchema(
      id: 0,
      name: r'author',
      type: IsarType.string,
    ),
    r'category': PropertySchema(
      id: 1,
      name: r'category',
      type: IsarType.string,
    ),
    r'description': PropertySchema(
      id: 2,
      name: r'description',
      type: IsarType.string,
    ),
    r'index': PropertySchema(
      id: 3,
      name: r'index',
      type: IsarType.long,
    ),
    r'sectionCount': PropertySchema(
      id: 4,
      name: r'sectionCount',
      type: IsarType.long,
    ),
    r'title': PropertySchema(
      id: 5,
      name: r'title',
      type: IsarType.string,
    ),
    r'titleArabic': PropertySchema(
      id: 6,
      name: r'titleArabic',
      type: IsarType.string,
    )
  },
  estimateSize: _bookEstimateSize,
  serialize: _bookSerialize,
  deserialize: _bookDeserialize,
  deserializeProp: _bookDeserializeProp,
  idName: r'id',
  indexes: {
    r'index': IndexSchema(
      id: -5425839060849557016,
      name: r'index',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'index',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _bookGetId,
  getLinks: _bookGetLinks,
  attach: _bookAttach,
  version: '3.1.0+1',
);

int _bookEstimateSize(
  Book object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.author.length * 3;
  bytesCount += 3 + object.category.length * 3;
  bytesCount += 3 + object.description.length * 3;
  bytesCount += 3 + object.title.length * 3;
  bytesCount += 3 + object.titleArabic.length * 3;
  return bytesCount;
}

void _bookSerialize(
  Book object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.author);
  writer.writeString(offsets[1], object.category);
  writer.writeString(offsets[2], object.description);
  writer.writeLong(offsets[3], object.index);
  writer.writeLong(offsets[4], object.sectionCount);
  writer.writeString(offsets[5], object.title);
  writer.writeString(offsets[6], object.titleArabic);
}

Book _bookDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Book();
  object.author = reader.readString(offsets[0]);
  object.category = reader.readString(offsets[1]);
  object.description = reader.readString(offsets[2]);
  object.id = id;
  object.index = reader.readLong(offsets[3]);
  object.sectionCount = reader.readLong(offsets[4]);
  object.title = reader.readString(offsets[5]);
  object.titleArabic = reader.readString(offsets[6]);
  return object;
}

P _bookDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _bookGetId(Book object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _bookGetLinks(Book object) {
  return [];
}

void _bookAttach(IsarCollection<dynamic> col, Id id, Book object) {
  object.id = id;
}

extension BookQueryWhereSort on QueryBuilder<Book, Book, QWhere> {
  QueryBuilder<Book, Book, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Book, Book, QAfterWhere> anyIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'index'),
      );
    });
  }
}

extension BookQueryWhere on QueryBuilder<Book, Book, QWhereClause> {
  QueryBuilder<Book, Book, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Book, Book, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Book, Book, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Book, Book, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterWhereClause> indexEqualTo(int index) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'index',
        value: [index],
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterWhereClause> indexNotEqualTo(int index) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'index',
              lower: [],
              upper: [index],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'index',
              lower: [index],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'index',
              lower: [index],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'index',
              lower: [],
              upper: [index],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Book, Book, QAfterWhereClause> indexGreaterThan(
    int index, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'index',
        lower: [index],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterWhereClause> indexLessThan(
    int index, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'index',
        lower: [],
        upper: [index],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterWhereClause> indexBetween(
    int lowerIndex,
    int upperIndex, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'index',
        lower: [lowerIndex],
        includeLower: includeLower,
        upper: [upperIndex],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension BookQueryFilter on QueryBuilder<Book, Book, QFilterCondition> {
  QueryBuilder<Book, Book, QAfterFilterCondition> authorEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'author',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> authorGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'author',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> authorLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'author',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> authorBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'author',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> authorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'author',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> authorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'author',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> authorContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'author',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> authorMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'author',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> authorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'author',
        value: '',
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> authorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'author',
        value: '',
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> categoryEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> categoryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> categoryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> categoryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> categoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> categoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> categoryContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> categoryMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> descriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> descriptionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> descriptionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> indexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'index',
        value: value,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> indexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'index',
        value: value,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> indexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'index',
        value: value,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> indexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'index',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> sectionCountEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sectionCount',
        value: value,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> sectionCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sectionCount',
        value: value,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> sectionCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sectionCount',
        value: value,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> sectionCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sectionCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> titleContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> titleMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> titleArabicEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'titleArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> titleArabicGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'titleArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> titleArabicLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'titleArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> titleArabicBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'titleArabic',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> titleArabicStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'titleArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> titleArabicEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'titleArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> titleArabicContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'titleArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> titleArabicMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'titleArabic',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> titleArabicIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'titleArabic',
        value: '',
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> titleArabicIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'titleArabic',
        value: '',
      ));
    });
  }
}

extension BookQueryObject on QueryBuilder<Book, Book, QFilterCondition> {}

extension BookQueryLinks on QueryBuilder<Book, Book, QFilterCondition> {}

extension BookQuerySortBy on QueryBuilder<Book, Book, QSortBy> {
  QueryBuilder<Book, Book, QAfterSortBy> sortByAuthor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'author', Sort.asc);
    });
  }

  QueryBuilder<Book, Book, QAfterSortBy> sortByAuthorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'author', Sort.desc);
    });
  }

  QueryBuilder<Book, Book, QAfterSortBy> sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<Book, Book, QAfterSortBy> sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<Book, Book, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Book, Book, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Book, Book, QAfterSortBy> sortByIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index', Sort.asc);
    });
  }

  QueryBuilder<Book, Book, QAfterSortBy> sortByIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index', Sort.desc);
    });
  }

  QueryBuilder<Book, Book, QAfterSortBy> sortBySectionCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sectionCount', Sort.asc);
    });
  }

  QueryBuilder<Book, Book, QAfterSortBy> sortBySectionCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sectionCount', Sort.desc);
    });
  }

  QueryBuilder<Book, Book, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<Book, Book, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<Book, Book, QAfterSortBy> sortByTitleArabic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titleArabic', Sort.asc);
    });
  }

  QueryBuilder<Book, Book, QAfterSortBy> sortByTitleArabicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titleArabic', Sort.desc);
    });
  }
}

extension BookQuerySortThenBy on QueryBuilder<Book, Book, QSortThenBy> {
  QueryBuilder<Book, Book, QAfterSortBy> thenByAuthor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'author', Sort.asc);
    });
  }

  QueryBuilder<Book, Book, QAfterSortBy> thenByAuthorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'author', Sort.desc);
    });
  }

  QueryBuilder<Book, Book, QAfterSortBy> thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<Book, Book, QAfterSortBy> thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<Book, Book, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Book, Book, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Book, Book, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Book, Book, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Book, Book, QAfterSortBy> thenByIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index', Sort.asc);
    });
  }

  QueryBuilder<Book, Book, QAfterSortBy> thenByIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index', Sort.desc);
    });
  }

  QueryBuilder<Book, Book, QAfterSortBy> thenBySectionCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sectionCount', Sort.asc);
    });
  }

  QueryBuilder<Book, Book, QAfterSortBy> thenBySectionCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sectionCount', Sort.desc);
    });
  }

  QueryBuilder<Book, Book, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<Book, Book, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<Book, Book, QAfterSortBy> thenByTitleArabic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titleArabic', Sort.asc);
    });
  }

  QueryBuilder<Book, Book, QAfterSortBy> thenByTitleArabicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titleArabic', Sort.desc);
    });
  }
}

extension BookQueryWhereDistinct on QueryBuilder<Book, Book, QDistinct> {
  QueryBuilder<Book, Book, QDistinct> distinctByAuthor(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'author', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Book, Book, QDistinct> distinctByCategory(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Book, Book, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Book, Book, QDistinct> distinctByIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'index');
    });
  }

  QueryBuilder<Book, Book, QDistinct> distinctBySectionCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sectionCount');
    });
  }

  QueryBuilder<Book, Book, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Book, Book, QDistinct> distinctByTitleArabic(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'titleArabic', caseSensitive: caseSensitive);
    });
  }
}

extension BookQueryProperty on QueryBuilder<Book, Book, QQueryProperty> {
  QueryBuilder<Book, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Book, String, QQueryOperations> authorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'author');
    });
  }

  QueryBuilder<Book, String, QQueryOperations> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<Book, String, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<Book, int, QQueryOperations> indexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'index');
    });
  }

  QueryBuilder<Book, int, QQueryOperations> sectionCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sectionCount');
    });
  }

  QueryBuilder<Book, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<Book, String, QQueryOperations> titleArabicProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'titleArabic');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetBookSectionCollection on Isar {
  IsarCollection<BookSection> get bookSections => this.collection();
}

const BookSectionSchema = CollectionSchema(
  name: r'BookSection',
  id: 1275096568563829035,
  properties: {
    r'bookId': PropertySchema(
      id: 0,
      name: r'bookId',
      type: IsarType.long,
    ),
    r'bookIdIndex': PropertySchema(
      id: 1,
      name: r'bookIdIndex',
      type: IsarType.long,
    ),
    r'content': PropertySchema(
      id: 2,
      name: r'content',
      type: IsarType.string,
    ),
    r'contentArabic': PropertySchema(
      id: 3,
      name: r'contentArabic',
      type: IsarType.string,
    ),
    r'contentFarsi': PropertySchema(
      id: 4,
      name: r'contentFarsi',
      type: IsarType.string,
    ),
    r'contentUrdu': PropertySchema(
      id: 5,
      name: r'contentUrdu',
      type: IsarType.string,
    ),
    r'sectionNumber': PropertySchema(
      id: 6,
      name: r'sectionNumber',
      type: IsarType.long,
    ),
    r'title': PropertySchema(
      id: 7,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _bookSectionEstimateSize,
  serialize: _bookSectionSerialize,
  deserialize: _bookSectionDeserialize,
  deserializeProp: _bookSectionDeserializeProp,
  idName: r'id',
  indexes: {
    r'bookIdIndex': IndexSchema(
      id: 3403501782873399700,
      name: r'bookIdIndex',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'bookIdIndex',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _bookSectionGetId,
  getLinks: _bookSectionGetLinks,
  attach: _bookSectionAttach,
  version: '3.1.0+1',
);

int _bookSectionEstimateSize(
  BookSection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.content.length * 3;
  bytesCount += 3 + object.contentArabic.length * 3;
  {
    final value = object.contentFarsi;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.contentUrdu;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _bookSectionSerialize(
  BookSection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.bookId);
  writer.writeLong(offsets[1], object.bookIdIndex);
  writer.writeString(offsets[2], object.content);
  writer.writeString(offsets[3], object.contentArabic);
  writer.writeString(offsets[4], object.contentFarsi);
  writer.writeString(offsets[5], object.contentUrdu);
  writer.writeLong(offsets[6], object.sectionNumber);
  writer.writeString(offsets[7], object.title);
}

BookSection _bookSectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BookSection();
  object.bookId = reader.readLong(offsets[0]);
  object.bookIdIndex = reader.readLong(offsets[1]);
  object.content = reader.readString(offsets[2]);
  object.contentArabic = reader.readString(offsets[3]);
  object.contentFarsi = reader.readStringOrNull(offsets[4]);
  object.contentUrdu = reader.readStringOrNull(offsets[5]);
  object.id = id;
  object.sectionNumber = reader.readLong(offsets[6]);
  object.title = reader.readString(offsets[7]);
  return object;
}

P _bookSectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _bookSectionGetId(BookSection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _bookSectionGetLinks(BookSection object) {
  return [];
}

void _bookSectionAttach(
    IsarCollection<dynamic> col, Id id, BookSection object) {
  object.id = id;
}

extension BookSectionQueryWhereSort
    on QueryBuilder<BookSection, BookSection, QWhere> {
  QueryBuilder<BookSection, BookSection, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterWhere> anyBookIdIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'bookIdIndex'),
      );
    });
  }
}

extension BookSectionQueryWhere
    on QueryBuilder<BookSection, BookSection, QWhereClause> {
  QueryBuilder<BookSection, BookSection, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterWhereClause> bookIdIndexEqualTo(
      int bookIdIndex) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'bookIdIndex',
        value: [bookIdIndex],
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterWhereClause>
      bookIdIndexNotEqualTo(int bookIdIndex) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'bookIdIndex',
              lower: [],
              upper: [bookIdIndex],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'bookIdIndex',
              lower: [bookIdIndex],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'bookIdIndex',
              lower: [bookIdIndex],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'bookIdIndex',
              lower: [],
              upper: [bookIdIndex],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterWhereClause>
      bookIdIndexGreaterThan(
    int bookIdIndex, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'bookIdIndex',
        lower: [bookIdIndex],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterWhereClause> bookIdIndexLessThan(
    int bookIdIndex, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'bookIdIndex',
        lower: [],
        upper: [bookIdIndex],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterWhereClause> bookIdIndexBetween(
    int lowerBookIdIndex,
    int upperBookIdIndex, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'bookIdIndex',
        lower: [lowerBookIdIndex],
        includeLower: includeLower,
        upper: [upperBookIdIndex],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension BookSectionQueryFilter
    on QueryBuilder<BookSection, BookSection, QFilterCondition> {
  QueryBuilder<BookSection, BookSection, QAfterFilterCondition> bookIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bookId',
        value: value,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      bookIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bookId',
        value: value,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition> bookIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bookId',
        value: value,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition> bookIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bookId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      bookIdIndexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bookIdIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      bookIdIndexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bookIdIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      bookIdIndexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bookIdIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      bookIdIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bookIdIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition> contentEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      contentGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition> contentLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition> contentBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'content',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      contentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition> contentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition> contentContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition> contentMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'content',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      contentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'content',
        value: '',
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      contentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'content',
        value: '',
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      contentArabicEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      contentArabicGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contentArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      contentArabicLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contentArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      contentArabicBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contentArabic',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      contentArabicStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'contentArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      contentArabicEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'contentArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      contentArabicContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'contentArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      contentArabicMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'contentArabic',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      contentArabicIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentArabic',
        value: '',
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      contentArabicIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contentArabic',
        value: '',
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      contentFarsiIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'contentFarsi',
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      contentFarsiIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'contentFarsi',
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      contentFarsiEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentFarsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      contentFarsiGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contentFarsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      contentFarsiLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contentFarsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      contentFarsiBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contentFarsi',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      contentFarsiStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'contentFarsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      contentFarsiEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'contentFarsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      contentFarsiContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'contentFarsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      contentFarsiMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'contentFarsi',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      contentFarsiIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentFarsi',
        value: '',
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      contentFarsiIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contentFarsi',
        value: '',
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      contentUrduIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'contentUrdu',
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      contentUrduIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'contentUrdu',
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      contentUrduEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentUrdu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      contentUrduGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contentUrdu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      contentUrduLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contentUrdu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      contentUrduBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contentUrdu',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      contentUrduStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'contentUrdu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      contentUrduEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'contentUrdu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      contentUrduContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'contentUrdu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      contentUrduMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'contentUrdu',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      contentUrduIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentUrdu',
        value: '',
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      contentUrduIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contentUrdu',
        value: '',
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      sectionNumberEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sectionNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      sectionNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sectionNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      sectionNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sectionNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      sectionNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sectionNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension BookSectionQueryObject
    on QueryBuilder<BookSection, BookSection, QFilterCondition> {}

extension BookSectionQueryLinks
    on QueryBuilder<BookSection, BookSection, QFilterCondition> {}

extension BookSectionQuerySortBy
    on QueryBuilder<BookSection, BookSection, QSortBy> {
  QueryBuilder<BookSection, BookSection, QAfterSortBy> sortByBookId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookId', Sort.asc);
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterSortBy> sortByBookIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookId', Sort.desc);
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterSortBy> sortByBookIdIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookIdIndex', Sort.asc);
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterSortBy> sortByBookIdIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookIdIndex', Sort.desc);
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterSortBy> sortByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterSortBy> sortByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterSortBy> sortByContentArabic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentArabic', Sort.asc);
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterSortBy>
      sortByContentArabicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentArabic', Sort.desc);
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterSortBy> sortByContentFarsi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentFarsi', Sort.asc);
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterSortBy>
      sortByContentFarsiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentFarsi', Sort.desc);
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterSortBy> sortByContentUrdu() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentUrdu', Sort.asc);
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterSortBy> sortByContentUrduDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentUrdu', Sort.desc);
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterSortBy> sortBySectionNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sectionNumber', Sort.asc);
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterSortBy>
      sortBySectionNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sectionNumber', Sort.desc);
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension BookSectionQuerySortThenBy
    on QueryBuilder<BookSection, BookSection, QSortThenBy> {
  QueryBuilder<BookSection, BookSection, QAfterSortBy> thenByBookId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookId', Sort.asc);
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterSortBy> thenByBookIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookId', Sort.desc);
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterSortBy> thenByBookIdIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookIdIndex', Sort.asc);
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterSortBy> thenByBookIdIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookIdIndex', Sort.desc);
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterSortBy> thenByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterSortBy> thenByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterSortBy> thenByContentArabic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentArabic', Sort.asc);
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterSortBy>
      thenByContentArabicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentArabic', Sort.desc);
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterSortBy> thenByContentFarsi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentFarsi', Sort.asc);
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterSortBy>
      thenByContentFarsiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentFarsi', Sort.desc);
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterSortBy> thenByContentUrdu() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentUrdu', Sort.asc);
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterSortBy> thenByContentUrduDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentUrdu', Sort.desc);
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterSortBy> thenBySectionNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sectionNumber', Sort.asc);
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterSortBy>
      thenBySectionNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sectionNumber', Sort.desc);
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<BookSection, BookSection, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension BookSectionQueryWhereDistinct
    on QueryBuilder<BookSection, BookSection, QDistinct> {
  QueryBuilder<BookSection, BookSection, QDistinct> distinctByBookId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bookId');
    });
  }

  QueryBuilder<BookSection, BookSection, QDistinct> distinctByBookIdIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bookIdIndex');
    });
  }

  QueryBuilder<BookSection, BookSection, QDistinct> distinctByContent(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'content', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BookSection, BookSection, QDistinct> distinctByContentArabic(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contentArabic',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BookSection, BookSection, QDistinct> distinctByContentFarsi(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contentFarsi', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BookSection, BookSection, QDistinct> distinctByContentUrdu(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contentUrdu', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BookSection, BookSection, QDistinct> distinctBySectionNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sectionNumber');
    });
  }

  QueryBuilder<BookSection, BookSection, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension BookSectionQueryProperty
    on QueryBuilder<BookSection, BookSection, QQueryProperty> {
  QueryBuilder<BookSection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<BookSection, int, QQueryOperations> bookIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bookId');
    });
  }

  QueryBuilder<BookSection, int, QQueryOperations> bookIdIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bookIdIndex');
    });
  }

  QueryBuilder<BookSection, String, QQueryOperations> contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'content');
    });
  }

  QueryBuilder<BookSection, String, QQueryOperations> contentArabicProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contentArabic');
    });
  }

  QueryBuilder<BookSection, String?, QQueryOperations> contentFarsiProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contentFarsi');
    });
  }

  QueryBuilder<BookSection, String?, QQueryOperations> contentUrduProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contentUrdu');
    });
  }

  QueryBuilder<BookSection, int, QQueryOperations> sectionNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sectionNumber');
    });
  }

  QueryBuilder<BookSection, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetZiyarahCollection on Isar {
  IsarCollection<Ziyarah> get ziyarahs => this.collection();
}

const ZiyarahSchema = CollectionSchema(
  name: r'Ziyarah',
  id: 6974169145930236886,
  properties: {
    r'audioUrl': PropertySchema(
      id: 0,
      name: r'audioUrl',
      type: IsarType.string,
    ),
    r'category': PropertySchema(
      id: 1,
      name: r'category',
      type: IsarType.string,
    ),
    r'description': PropertySchema(
      id: 2,
      name: r'description',
      type: IsarType.string,
    ),
    r'index': PropertySchema(
      id: 3,
      name: r'index',
      type: IsarType.long,
    ),
    r'name': PropertySchema(
      id: 4,
      name: r'name',
      type: IsarType.string,
    ),
    r'nameArabic': PropertySchema(
      id: 5,
      name: r'nameArabic',
      type: IsarType.string,
    ),
    r'occasion': PropertySchema(
      id: 6,
      name: r'occasion',
      type: IsarType.string,
    )
  },
  estimateSize: _ziyarahEstimateSize,
  serialize: _ziyarahSerialize,
  deserialize: _ziyarahDeserialize,
  deserializeProp: _ziyarahDeserializeProp,
  idName: r'id',
  indexes: {
    r'index': IndexSchema(
      id: -5425839060849557016,
      name: r'index',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'index',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _ziyarahGetId,
  getLinks: _ziyarahGetLinks,
  attach: _ziyarahAttach,
  version: '3.1.0+1',
);

int _ziyarahEstimateSize(
  Ziyarah object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.audioUrl.length * 3;
  bytesCount += 3 + object.category.length * 3;
  bytesCount += 3 + object.description.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.nameArabic.length * 3;
  bytesCount += 3 + object.occasion.length * 3;
  return bytesCount;
}

void _ziyarahSerialize(
  Ziyarah object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.audioUrl);
  writer.writeString(offsets[1], object.category);
  writer.writeString(offsets[2], object.description);
  writer.writeLong(offsets[3], object.index);
  writer.writeString(offsets[4], object.name);
  writer.writeString(offsets[5], object.nameArabic);
  writer.writeString(offsets[6], object.occasion);
}

Ziyarah _ziyarahDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Ziyarah();
  object.audioUrl = reader.readString(offsets[0]);
  object.category = reader.readString(offsets[1]);
  object.description = reader.readString(offsets[2]);
  object.id = id;
  object.index = reader.readLong(offsets[3]);
  object.name = reader.readString(offsets[4]);
  object.nameArabic = reader.readString(offsets[5]);
  object.occasion = reader.readString(offsets[6]);
  return object;
}

P _ziyarahDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _ziyarahGetId(Ziyarah object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _ziyarahGetLinks(Ziyarah object) {
  return [];
}

void _ziyarahAttach(IsarCollection<dynamic> col, Id id, Ziyarah object) {
  object.id = id;
}

extension ZiyarahQueryWhereSort on QueryBuilder<Ziyarah, Ziyarah, QWhere> {
  QueryBuilder<Ziyarah, Ziyarah, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterWhere> anyIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'index'),
      );
    });
  }
}

extension ZiyarahQueryWhere on QueryBuilder<Ziyarah, Ziyarah, QWhereClause> {
  QueryBuilder<Ziyarah, Ziyarah, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterWhereClause> indexEqualTo(int index) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'index',
        value: [index],
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterWhereClause> indexNotEqualTo(int index) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'index',
              lower: [],
              upper: [index],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'index',
              lower: [index],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'index',
              lower: [index],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'index',
              lower: [],
              upper: [index],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterWhereClause> indexGreaterThan(
    int index, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'index',
        lower: [index],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterWhereClause> indexLessThan(
    int index, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'index',
        lower: [],
        upper: [index],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterWhereClause> indexBetween(
    int lowerIndex,
    int upperIndex, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'index',
        lower: [lowerIndex],
        includeLower: includeLower,
        upper: [upperIndex],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ZiyarahQueryFilter
    on QueryBuilder<Ziyarah, Ziyarah, QFilterCondition> {
  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> audioUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> audioUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> audioUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> audioUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'audioUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> audioUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> audioUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> audioUrlContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> audioUrlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'audioUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> audioUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audioUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> audioUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'audioUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> categoryEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> categoryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> categoryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> categoryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> categoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> categoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> categoryContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> categoryMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> descriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> descriptionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> descriptionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> indexEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'index',
        value: value,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> indexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'index',
        value: value,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> indexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'index',
        value: value,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> indexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'index',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> nameArabicEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nameArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> nameArabicGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nameArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> nameArabicLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nameArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> nameArabicBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nameArabic',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> nameArabicStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nameArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> nameArabicEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nameArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> nameArabicContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nameArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> nameArabicMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nameArabic',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> nameArabicIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nameArabic',
        value: '',
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> nameArabicIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nameArabic',
        value: '',
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> occasionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'occasion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> occasionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'occasion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> occasionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'occasion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> occasionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'occasion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> occasionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'occasion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> occasionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'occasion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> occasionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'occasion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> occasionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'occasion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> occasionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'occasion',
        value: '',
      ));
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterFilterCondition> occasionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'occasion',
        value: '',
      ));
    });
  }
}

extension ZiyarahQueryObject
    on QueryBuilder<Ziyarah, Ziyarah, QFilterCondition> {}

extension ZiyarahQueryLinks
    on QueryBuilder<Ziyarah, Ziyarah, QFilterCondition> {}

extension ZiyarahQuerySortBy on QueryBuilder<Ziyarah, Ziyarah, QSortBy> {
  QueryBuilder<Ziyarah, Ziyarah, QAfterSortBy> sortByAudioUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioUrl', Sort.asc);
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterSortBy> sortByAudioUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioUrl', Sort.desc);
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterSortBy> sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterSortBy> sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterSortBy> sortByIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index', Sort.asc);
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterSortBy> sortByIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index', Sort.desc);
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterSortBy> sortByNameArabic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameArabic', Sort.asc);
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterSortBy> sortByNameArabicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameArabic', Sort.desc);
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterSortBy> sortByOccasion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occasion', Sort.asc);
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterSortBy> sortByOccasionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occasion', Sort.desc);
    });
  }
}

extension ZiyarahQuerySortThenBy
    on QueryBuilder<Ziyarah, Ziyarah, QSortThenBy> {
  QueryBuilder<Ziyarah, Ziyarah, QAfterSortBy> thenByAudioUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioUrl', Sort.asc);
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterSortBy> thenByAudioUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioUrl', Sort.desc);
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterSortBy> thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterSortBy> thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterSortBy> thenByIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index', Sort.asc);
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterSortBy> thenByIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index', Sort.desc);
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterSortBy> thenByNameArabic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameArabic', Sort.asc);
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterSortBy> thenByNameArabicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameArabic', Sort.desc);
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterSortBy> thenByOccasion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occasion', Sort.asc);
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QAfterSortBy> thenByOccasionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occasion', Sort.desc);
    });
  }
}

extension ZiyarahQueryWhereDistinct
    on QueryBuilder<Ziyarah, Ziyarah, QDistinct> {
  QueryBuilder<Ziyarah, Ziyarah, QDistinct> distinctByAudioUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'audioUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QDistinct> distinctByCategory(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QDistinct> distinctByIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'index');
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QDistinct> distinctByNameArabic(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nameArabic', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ziyarah, Ziyarah, QDistinct> distinctByOccasion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'occasion', caseSensitive: caseSensitive);
    });
  }
}

extension ZiyarahQueryProperty
    on QueryBuilder<Ziyarah, Ziyarah, QQueryProperty> {
  QueryBuilder<Ziyarah, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Ziyarah, String, QQueryOperations> audioUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'audioUrl');
    });
  }

  QueryBuilder<Ziyarah, String, QQueryOperations> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<Ziyarah, String, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<Ziyarah, int, QQueryOperations> indexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'index');
    });
  }

  QueryBuilder<Ziyarah, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Ziyarah, String, QQueryOperations> nameArabicProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nameArabic');
    });
  }

  QueryBuilder<Ziyarah, String, QQueryOperations> occasionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'occasion');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetZiyarahLineCollection on Isar {
  IsarCollection<ZiyarahLine> get ziyarahLines => this.collection();
}

const ZiyarahLineSchema = CollectionSchema(
  name: r'ZiyarahLine',
  id: 8248612790614959320,
  properties: {
    r'audioEndTime': PropertySchema(
      id: 0,
      name: r'audioEndTime',
      type: IsarType.long,
    ),
    r'audioStartTime': PropertySchema(
      id: 1,
      name: r'audioStartTime',
      type: IsarType.long,
    ),
    r'audioUrl': PropertySchema(
      id: 2,
      name: r'audioUrl',
      type: IsarType.string,
    ),
    r'lineNumber': PropertySchema(
      id: 3,
      name: r'lineNumber',
      type: IsarType.long,
    ),
    r'textArabic': PropertySchema(
      id: 4,
      name: r'textArabic',
      type: IsarType.string,
    ),
    r'textEnglish': PropertySchema(
      id: 5,
      name: r'textEnglish',
      type: IsarType.string,
    ),
    r'textFarsi': PropertySchema(
      id: 6,
      name: r'textFarsi',
      type: IsarType.string,
    ),
    r'textUrdu': PropertySchema(
      id: 7,
      name: r'textUrdu',
      type: IsarType.string,
    ),
    r'ziyarahId': PropertySchema(
      id: 8,
      name: r'ziyarahId',
      type: IsarType.long,
    ),
    r'ziyarahIdIndex': PropertySchema(
      id: 9,
      name: r'ziyarahIdIndex',
      type: IsarType.long,
    )
  },
  estimateSize: _ziyarahLineEstimateSize,
  serialize: _ziyarahLineSerialize,
  deserialize: _ziyarahLineDeserialize,
  deserializeProp: _ziyarahLineDeserializeProp,
  idName: r'id',
  indexes: {
    r'ziyarahIdIndex': IndexSchema(
      id: -6534798351106263949,
      name: r'ziyarahIdIndex',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'ziyarahIdIndex',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _ziyarahLineGetId,
  getLinks: _ziyarahLineGetLinks,
  attach: _ziyarahLineAttach,
  version: '3.1.0+1',
);

int _ziyarahLineEstimateSize(
  ZiyarahLine object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.audioUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.textArabic.length * 3;
  bytesCount += 3 + object.textEnglish.length * 3;
  bytesCount += 3 + object.textFarsi.length * 3;
  bytesCount += 3 + object.textUrdu.length * 3;
  return bytesCount;
}

void _ziyarahLineSerialize(
  ZiyarahLine object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.audioEndTime);
  writer.writeLong(offsets[1], object.audioStartTime);
  writer.writeString(offsets[2], object.audioUrl);
  writer.writeLong(offsets[3], object.lineNumber);
  writer.writeString(offsets[4], object.textArabic);
  writer.writeString(offsets[5], object.textEnglish);
  writer.writeString(offsets[6], object.textFarsi);
  writer.writeString(offsets[7], object.textUrdu);
  writer.writeLong(offsets[8], object.ziyarahId);
  writer.writeLong(offsets[9], object.ziyarahIdIndex);
}

ZiyarahLine _ziyarahLineDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ZiyarahLine();
  object.audioEndTime = reader.readLongOrNull(offsets[0]);
  object.audioStartTime = reader.readLongOrNull(offsets[1]);
  object.audioUrl = reader.readStringOrNull(offsets[2]);
  object.id = id;
  object.lineNumber = reader.readLong(offsets[3]);
  object.textArabic = reader.readString(offsets[4]);
  object.textEnglish = reader.readString(offsets[5]);
  object.textFarsi = reader.readString(offsets[6]);
  object.textUrdu = reader.readString(offsets[7]);
  object.ziyarahId = reader.readLong(offsets[8]);
  object.ziyarahIdIndex = reader.readLong(offsets[9]);
  return object;
}

P _ziyarahLineDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _ziyarahLineGetId(ZiyarahLine object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _ziyarahLineGetLinks(ZiyarahLine object) {
  return [];
}

void _ziyarahLineAttach(
    IsarCollection<dynamic> col, Id id, ZiyarahLine object) {
  object.id = id;
}

extension ZiyarahLineQueryWhereSort
    on QueryBuilder<ZiyarahLine, ZiyarahLine, QWhere> {
  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterWhere> anyZiyarahIdIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'ziyarahIdIndex'),
      );
    });
  }
}

extension ZiyarahLineQueryWhere
    on QueryBuilder<ZiyarahLine, ZiyarahLine, QWhereClause> {
  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterWhereClause>
      ziyarahIdIndexEqualTo(int ziyarahIdIndex) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'ziyarahIdIndex',
        value: [ziyarahIdIndex],
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterWhereClause>
      ziyarahIdIndexNotEqualTo(int ziyarahIdIndex) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ziyarahIdIndex',
              lower: [],
              upper: [ziyarahIdIndex],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ziyarahIdIndex',
              lower: [ziyarahIdIndex],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ziyarahIdIndex',
              lower: [ziyarahIdIndex],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ziyarahIdIndex',
              lower: [],
              upper: [ziyarahIdIndex],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterWhereClause>
      ziyarahIdIndexGreaterThan(
    int ziyarahIdIndex, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'ziyarahIdIndex',
        lower: [ziyarahIdIndex],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterWhereClause>
      ziyarahIdIndexLessThan(
    int ziyarahIdIndex, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'ziyarahIdIndex',
        lower: [],
        upper: [ziyarahIdIndex],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterWhereClause>
      ziyarahIdIndexBetween(
    int lowerZiyarahIdIndex,
    int upperZiyarahIdIndex, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'ziyarahIdIndex',
        lower: [lowerZiyarahIdIndex],
        includeLower: includeLower,
        upper: [upperZiyarahIdIndex],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ZiyarahLineQueryFilter
    on QueryBuilder<ZiyarahLine, ZiyarahLine, QFilterCondition> {
  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      audioEndTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'audioEndTime',
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      audioEndTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'audioEndTime',
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      audioEndTimeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audioEndTime',
        value: value,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      audioEndTimeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'audioEndTime',
        value: value,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      audioEndTimeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'audioEndTime',
        value: value,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      audioEndTimeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'audioEndTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      audioStartTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'audioStartTime',
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      audioStartTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'audioStartTime',
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      audioStartTimeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audioStartTime',
        value: value,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      audioStartTimeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'audioStartTime',
        value: value,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      audioStartTimeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'audioStartTime',
        value: value,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      audioStartTimeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'audioStartTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      audioUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'audioUrl',
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      audioUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'audioUrl',
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition> audioUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      audioUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      audioUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition> audioUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'audioUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      audioUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      audioUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      audioUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition> audioUrlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'audioUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      audioUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audioUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      audioUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'audioUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      lineNumberEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lineNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      lineNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lineNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      lineNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lineNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      lineNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lineNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      textArabicEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      textArabicGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'textArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      textArabicLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'textArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      textArabicBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'textArabic',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      textArabicStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'textArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      textArabicEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'textArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      textArabicContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'textArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      textArabicMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'textArabic',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      textArabicIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textArabic',
        value: '',
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      textArabicIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'textArabic',
        value: '',
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      textEnglishEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textEnglish',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      textEnglishGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'textEnglish',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      textEnglishLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'textEnglish',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      textEnglishBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'textEnglish',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      textEnglishStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'textEnglish',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      textEnglishEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'textEnglish',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      textEnglishContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'textEnglish',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      textEnglishMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'textEnglish',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      textEnglishIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textEnglish',
        value: '',
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      textEnglishIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'textEnglish',
        value: '',
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      textFarsiEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textFarsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      textFarsiGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'textFarsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      textFarsiLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'textFarsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      textFarsiBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'textFarsi',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      textFarsiStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'textFarsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      textFarsiEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'textFarsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      textFarsiContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'textFarsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      textFarsiMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'textFarsi',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      textFarsiIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textFarsi',
        value: '',
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      textFarsiIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'textFarsi',
        value: '',
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition> textUrduEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textUrdu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      textUrduGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'textUrdu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      textUrduLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'textUrdu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition> textUrduBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'textUrdu',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      textUrduStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'textUrdu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      textUrduEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'textUrdu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      textUrduContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'textUrdu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition> textUrduMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'textUrdu',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      textUrduIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textUrdu',
        value: '',
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      textUrduIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'textUrdu',
        value: '',
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      ziyarahIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ziyarahId',
        value: value,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      ziyarahIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ziyarahId',
        value: value,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      ziyarahIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ziyarahId',
        value: value,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      ziyarahIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ziyarahId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      ziyarahIdIndexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ziyarahIdIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      ziyarahIdIndexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ziyarahIdIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      ziyarahIdIndexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ziyarahIdIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterFilterCondition>
      ziyarahIdIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ziyarahIdIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ZiyarahLineQueryObject
    on QueryBuilder<ZiyarahLine, ZiyarahLine, QFilterCondition> {}

extension ZiyarahLineQueryLinks
    on QueryBuilder<ZiyarahLine, ZiyarahLine, QFilterCondition> {}

extension ZiyarahLineQuerySortBy
    on QueryBuilder<ZiyarahLine, ZiyarahLine, QSortBy> {
  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy> sortByAudioEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioEndTime', Sort.asc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy>
      sortByAudioEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioEndTime', Sort.desc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy> sortByAudioStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioStartTime', Sort.asc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy>
      sortByAudioStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioStartTime', Sort.desc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy> sortByAudioUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioUrl', Sort.asc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy> sortByAudioUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioUrl', Sort.desc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy> sortByLineNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineNumber', Sort.asc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy> sortByLineNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineNumber', Sort.desc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy> sortByTextArabic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textArabic', Sort.asc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy> sortByTextArabicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textArabic', Sort.desc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy> sortByTextEnglish() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textEnglish', Sort.asc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy> sortByTextEnglishDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textEnglish', Sort.desc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy> sortByTextFarsi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textFarsi', Sort.asc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy> sortByTextFarsiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textFarsi', Sort.desc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy> sortByTextUrdu() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textUrdu', Sort.asc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy> sortByTextUrduDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textUrdu', Sort.desc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy> sortByZiyarahId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ziyarahId', Sort.asc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy> sortByZiyarahIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ziyarahId', Sort.desc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy> sortByZiyarahIdIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ziyarahIdIndex', Sort.asc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy>
      sortByZiyarahIdIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ziyarahIdIndex', Sort.desc);
    });
  }
}

extension ZiyarahLineQuerySortThenBy
    on QueryBuilder<ZiyarahLine, ZiyarahLine, QSortThenBy> {
  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy> thenByAudioEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioEndTime', Sort.asc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy>
      thenByAudioEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioEndTime', Sort.desc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy> thenByAudioStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioStartTime', Sort.asc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy>
      thenByAudioStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioStartTime', Sort.desc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy> thenByAudioUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioUrl', Sort.asc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy> thenByAudioUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioUrl', Sort.desc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy> thenByLineNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineNumber', Sort.asc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy> thenByLineNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineNumber', Sort.desc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy> thenByTextArabic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textArabic', Sort.asc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy> thenByTextArabicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textArabic', Sort.desc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy> thenByTextEnglish() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textEnglish', Sort.asc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy> thenByTextEnglishDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textEnglish', Sort.desc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy> thenByTextFarsi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textFarsi', Sort.asc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy> thenByTextFarsiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textFarsi', Sort.desc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy> thenByTextUrdu() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textUrdu', Sort.asc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy> thenByTextUrduDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textUrdu', Sort.desc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy> thenByZiyarahId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ziyarahId', Sort.asc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy> thenByZiyarahIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ziyarahId', Sort.desc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy> thenByZiyarahIdIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ziyarahIdIndex', Sort.asc);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QAfterSortBy>
      thenByZiyarahIdIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ziyarahIdIndex', Sort.desc);
    });
  }
}

extension ZiyarahLineQueryWhereDistinct
    on QueryBuilder<ZiyarahLine, ZiyarahLine, QDistinct> {
  QueryBuilder<ZiyarahLine, ZiyarahLine, QDistinct> distinctByAudioEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'audioEndTime');
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QDistinct> distinctByAudioStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'audioStartTime');
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QDistinct> distinctByAudioUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'audioUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QDistinct> distinctByLineNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lineNumber');
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QDistinct> distinctByTextArabic(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'textArabic', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QDistinct> distinctByTextEnglish(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'textEnglish', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QDistinct> distinctByTextFarsi(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'textFarsi', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QDistinct> distinctByTextUrdu(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'textUrdu', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QDistinct> distinctByZiyarahId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ziyarahId');
    });
  }

  QueryBuilder<ZiyarahLine, ZiyarahLine, QDistinct> distinctByZiyarahIdIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ziyarahIdIndex');
    });
  }
}

extension ZiyarahLineQueryProperty
    on QueryBuilder<ZiyarahLine, ZiyarahLine, QQueryProperty> {
  QueryBuilder<ZiyarahLine, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ZiyarahLine, int?, QQueryOperations> audioEndTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'audioEndTime');
    });
  }

  QueryBuilder<ZiyarahLine, int?, QQueryOperations> audioStartTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'audioStartTime');
    });
  }

  QueryBuilder<ZiyarahLine, String?, QQueryOperations> audioUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'audioUrl');
    });
  }

  QueryBuilder<ZiyarahLine, int, QQueryOperations> lineNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lineNumber');
    });
  }

  QueryBuilder<ZiyarahLine, String, QQueryOperations> textArabicProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'textArabic');
    });
  }

  QueryBuilder<ZiyarahLine, String, QQueryOperations> textEnglishProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'textEnglish');
    });
  }

  QueryBuilder<ZiyarahLine, String, QQueryOperations> textFarsiProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'textFarsi');
    });
  }

  QueryBuilder<ZiyarahLine, String, QQueryOperations> textUrduProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'textUrdu');
    });
  }

  QueryBuilder<ZiyarahLine, int, QQueryOperations> ziyarahIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ziyarahId');
    });
  }

  QueryBuilder<ZiyarahLine, int, QQueryOperations> ziyarahIdIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ziyarahIdIndex');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAudioTrackCollection on Isar {
  IsarCollection<AudioTrack> get audioTracks => this.collection();
}

const AudioTrackSchema = CollectionSchema(
  name: r'AudioTrack',
  id: -931389713124530459,
  properties: {
    r'artist': PropertySchema(
      id: 0,
      name: r'artist',
      type: IsarType.string,
    ),
    r'contentId': PropertySchema(
      id: 1,
      name: r'contentId',
      type: IsarType.long,
    ),
    r'contentType': PropertySchema(
      id: 2,
      name: r'contentType',
      type: IsarType.string,
    ),
    r'duration': PropertySchema(
      id: 3,
      name: r'duration',
      type: IsarType.long,
    ),
    r'title': PropertySchema(
      id: 4,
      name: r'title',
      type: IsarType.string,
    ),
    r'url': PropertySchema(
      id: 5,
      name: r'url',
      type: IsarType.string,
    ),
    r'urlIndex': PropertySchema(
      id: 6,
      name: r'urlIndex',
      type: IsarType.string,
    )
  },
  estimateSize: _audioTrackEstimateSize,
  serialize: _audioTrackSerialize,
  deserialize: _audioTrackDeserialize,
  deserializeProp: _audioTrackDeserializeProp,
  idName: r'id',
  indexes: {
    r'urlIndex': IndexSchema(
      id: 178706085358332386,
      name: r'urlIndex',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'urlIndex',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _audioTrackGetId,
  getLinks: _audioTrackGetLinks,
  attach: _audioTrackAttach,
  version: '3.1.0+1',
);

int _audioTrackEstimateSize(
  AudioTrack object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.artist.length * 3;
  bytesCount += 3 + object.contentType.length * 3;
  bytesCount += 3 + object.title.length * 3;
  bytesCount += 3 + object.url.length * 3;
  bytesCount += 3 + object.urlIndex.length * 3;
  return bytesCount;
}

void _audioTrackSerialize(
  AudioTrack object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.artist);
  writer.writeLong(offsets[1], object.contentId);
  writer.writeString(offsets[2], object.contentType);
  writer.writeLong(offsets[3], object.duration);
  writer.writeString(offsets[4], object.title);
  writer.writeString(offsets[5], object.url);
  writer.writeString(offsets[6], object.urlIndex);
}

AudioTrack _audioTrackDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AudioTrack();
  object.artist = reader.readString(offsets[0]);
  object.contentId = reader.readLong(offsets[1]);
  object.contentType = reader.readString(offsets[2]);
  object.duration = reader.readLong(offsets[3]);
  object.id = id;
  object.title = reader.readString(offsets[4]);
  object.url = reader.readString(offsets[5]);
  object.urlIndex = reader.readString(offsets[6]);
  return object;
}

P _audioTrackDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _audioTrackGetId(AudioTrack object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _audioTrackGetLinks(AudioTrack object) {
  return [];
}

void _audioTrackAttach(IsarCollection<dynamic> col, Id id, AudioTrack object) {
  object.id = id;
}

extension AudioTrackQueryWhereSort
    on QueryBuilder<AudioTrack, AudioTrack, QWhere> {
  QueryBuilder<AudioTrack, AudioTrack, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AudioTrackQueryWhere
    on QueryBuilder<AudioTrack, AudioTrack, QWhereClause> {
  QueryBuilder<AudioTrack, AudioTrack, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterWhereClause> urlIndexEqualTo(
      String urlIndex) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'urlIndex',
        value: [urlIndex],
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterWhereClause> urlIndexNotEqualTo(
      String urlIndex) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'urlIndex',
              lower: [],
              upper: [urlIndex],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'urlIndex',
              lower: [urlIndex],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'urlIndex',
              lower: [urlIndex],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'urlIndex',
              lower: [],
              upper: [urlIndex],
              includeUpper: false,
            ));
      }
    });
  }
}

extension AudioTrackQueryFilter
    on QueryBuilder<AudioTrack, AudioTrack, QFilterCondition> {
  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> artistEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'artist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> artistGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'artist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> artistLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'artist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> artistBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'artist',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> artistStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'artist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> artistEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'artist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> artistContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'artist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> artistMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'artist',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> artistIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'artist',
        value: '',
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition>
      artistIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'artist',
        value: '',
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> contentIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentId',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition>
      contentIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contentId',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> contentIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contentId',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> contentIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contentId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition>
      contentTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition>
      contentTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition>
      contentTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition>
      contentTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contentType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition>
      contentTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'contentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition>
      contentTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'contentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition>
      contentTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'contentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition>
      contentTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'contentType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition>
      contentTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentType',
        value: '',
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition>
      contentTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contentType',
        value: '',
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> durationEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'duration',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition>
      durationGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'duration',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> durationLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'duration',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> durationBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'duration',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> urlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> urlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> urlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> urlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'url',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> urlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> urlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> urlContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> urlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'url',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> urlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'url',
        value: '',
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> urlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'url',
        value: '',
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> urlIndexEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'urlIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition>
      urlIndexGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'urlIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> urlIndexLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'urlIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> urlIndexBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'urlIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition>
      urlIndexStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'urlIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> urlIndexEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'urlIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> urlIndexContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'urlIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition> urlIndexMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'urlIndex',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition>
      urlIndexIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'urlIndex',
        value: '',
      ));
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterFilterCondition>
      urlIndexIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'urlIndex',
        value: '',
      ));
    });
  }
}

extension AudioTrackQueryObject
    on QueryBuilder<AudioTrack, AudioTrack, QFilterCondition> {}

extension AudioTrackQueryLinks
    on QueryBuilder<AudioTrack, AudioTrack, QFilterCondition> {}

extension AudioTrackQuerySortBy
    on QueryBuilder<AudioTrack, AudioTrack, QSortBy> {
  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> sortByArtist() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artist', Sort.asc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> sortByArtistDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artist', Sort.desc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> sortByContentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentId', Sort.asc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> sortByContentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentId', Sort.desc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> sortByContentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentType', Sort.asc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> sortByContentTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentType', Sort.desc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> sortByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.asc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> sortByDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.desc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> sortByUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.asc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> sortByUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.desc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> sortByUrlIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'urlIndex', Sort.asc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> sortByUrlIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'urlIndex', Sort.desc);
    });
  }
}

extension AudioTrackQuerySortThenBy
    on QueryBuilder<AudioTrack, AudioTrack, QSortThenBy> {
  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> thenByArtist() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artist', Sort.asc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> thenByArtistDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artist', Sort.desc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> thenByContentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentId', Sort.asc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> thenByContentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentId', Sort.desc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> thenByContentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentType', Sort.asc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> thenByContentTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentType', Sort.desc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> thenByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.asc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> thenByDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.desc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> thenByUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.asc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> thenByUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.desc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> thenByUrlIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'urlIndex', Sort.asc);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QAfterSortBy> thenByUrlIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'urlIndex', Sort.desc);
    });
  }
}

extension AudioTrackQueryWhereDistinct
    on QueryBuilder<AudioTrack, AudioTrack, QDistinct> {
  QueryBuilder<AudioTrack, AudioTrack, QDistinct> distinctByArtist(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'artist', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QDistinct> distinctByContentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contentId');
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QDistinct> distinctByContentType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contentType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QDistinct> distinctByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'duration');
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QDistinct> distinctByUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'url', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AudioTrack, AudioTrack, QDistinct> distinctByUrlIndex(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'urlIndex', caseSensitive: caseSensitive);
    });
  }
}

extension AudioTrackQueryProperty
    on QueryBuilder<AudioTrack, AudioTrack, QQueryProperty> {
  QueryBuilder<AudioTrack, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AudioTrack, String, QQueryOperations> artistProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'artist');
    });
  }

  QueryBuilder<AudioTrack, int, QQueryOperations> contentIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contentId');
    });
  }

  QueryBuilder<AudioTrack, String, QQueryOperations> contentTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contentType');
    });
  }

  QueryBuilder<AudioTrack, int, QQueryOperations> durationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'duration');
    });
  }

  QueryBuilder<AudioTrack, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<AudioTrack, String, QQueryOperations> urlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'url');
    });
  }

  QueryBuilder<AudioTrack, String, QQueryOperations> urlIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'urlIndex');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAudioTimestampCollection on Isar {
  IsarCollection<AudioTimestamp> get audioTimestamps => this.collection();
}

const AudioTimestampSchema = CollectionSchema(
  name: r'AudioTimestamp',
  id: -315906725977658092,
  properties: {
    r'audioId': PropertySchema(
      id: 0,
      name: r'audioId',
      type: IsarType.long,
    ),
    r'audioIdIndex': PropertySchema(
      id: 1,
      name: r'audioIdIndex',
      type: IsarType.long,
    ),
    r'endTime': PropertySchema(
      id: 2,
      name: r'endTime',
      type: IsarType.long,
    ),
    r'lineNumber': PropertySchema(
      id: 3,
      name: r'lineNumber',
      type: IsarType.long,
    ),
    r'startTime': PropertySchema(
      id: 4,
      name: r'startTime',
      type: IsarType.long,
    )
  },
  estimateSize: _audioTimestampEstimateSize,
  serialize: _audioTimestampSerialize,
  deserialize: _audioTimestampDeserialize,
  deserializeProp: _audioTimestampDeserializeProp,
  idName: r'id',
  indexes: {
    r'audioIdIndex': IndexSchema(
      id: 8722567851218890630,
      name: r'audioIdIndex',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'audioIdIndex',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _audioTimestampGetId,
  getLinks: _audioTimestampGetLinks,
  attach: _audioTimestampAttach,
  version: '3.1.0+1',
);

int _audioTimestampEstimateSize(
  AudioTimestamp object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _audioTimestampSerialize(
  AudioTimestamp object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.audioId);
  writer.writeLong(offsets[1], object.audioIdIndex);
  writer.writeLong(offsets[2], object.endTime);
  writer.writeLong(offsets[3], object.lineNumber);
  writer.writeLong(offsets[4], object.startTime);
}

AudioTimestamp _audioTimestampDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AudioTimestamp();
  object.audioId = reader.readLong(offsets[0]);
  object.audioIdIndex = reader.readLong(offsets[1]);
  object.endTime = reader.readLong(offsets[2]);
  object.id = id;
  object.lineNumber = reader.readLong(offsets[3]);
  object.startTime = reader.readLong(offsets[4]);
  return object;
}

P _audioTimestampDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _audioTimestampGetId(AudioTimestamp object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _audioTimestampGetLinks(AudioTimestamp object) {
  return [];
}

void _audioTimestampAttach(
    IsarCollection<dynamic> col, Id id, AudioTimestamp object) {
  object.id = id;
}

extension AudioTimestampQueryWhereSort
    on QueryBuilder<AudioTimestamp, AudioTimestamp, QWhere> {
  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterWhere> anyAudioIdIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'audioIdIndex'),
      );
    });
  }
}

extension AudioTimestampQueryWhere
    on QueryBuilder<AudioTimestamp, AudioTimestamp, QWhereClause> {
  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterWhereClause>
      audioIdIndexEqualTo(int audioIdIndex) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'audioIdIndex',
        value: [audioIdIndex],
      ));
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterWhereClause>
      audioIdIndexNotEqualTo(int audioIdIndex) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'audioIdIndex',
              lower: [],
              upper: [audioIdIndex],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'audioIdIndex',
              lower: [audioIdIndex],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'audioIdIndex',
              lower: [audioIdIndex],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'audioIdIndex',
              lower: [],
              upper: [audioIdIndex],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterWhereClause>
      audioIdIndexGreaterThan(
    int audioIdIndex, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'audioIdIndex',
        lower: [audioIdIndex],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterWhereClause>
      audioIdIndexLessThan(
    int audioIdIndex, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'audioIdIndex',
        lower: [],
        upper: [audioIdIndex],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterWhereClause>
      audioIdIndexBetween(
    int lowerAudioIdIndex,
    int upperAudioIdIndex, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'audioIdIndex',
        lower: [lowerAudioIdIndex],
        includeLower: includeLower,
        upper: [upperAudioIdIndex],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AudioTimestampQueryFilter
    on QueryBuilder<AudioTimestamp, AudioTimestamp, QFilterCondition> {
  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterFilterCondition>
      audioIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audioId',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterFilterCondition>
      audioIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'audioId',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterFilterCondition>
      audioIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'audioId',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterFilterCondition>
      audioIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'audioId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterFilterCondition>
      audioIdIndexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audioIdIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterFilterCondition>
      audioIdIndexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'audioIdIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterFilterCondition>
      audioIdIndexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'audioIdIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterFilterCondition>
      audioIdIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'audioIdIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterFilterCondition>
      endTimeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endTime',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterFilterCondition>
      endTimeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endTime',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterFilterCondition>
      endTimeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endTime',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterFilterCondition>
      endTimeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterFilterCondition>
      lineNumberEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lineNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterFilterCondition>
      lineNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lineNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterFilterCondition>
      lineNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lineNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterFilterCondition>
      lineNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lineNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterFilterCondition>
      startTimeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startTime',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterFilterCondition>
      startTimeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startTime',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterFilterCondition>
      startTimeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startTime',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterFilterCondition>
      startTimeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AudioTimestampQueryObject
    on QueryBuilder<AudioTimestamp, AudioTimestamp, QFilterCondition> {}

extension AudioTimestampQueryLinks
    on QueryBuilder<AudioTimestamp, AudioTimestamp, QFilterCondition> {}

extension AudioTimestampQuerySortBy
    on QueryBuilder<AudioTimestamp, AudioTimestamp, QSortBy> {
  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterSortBy> sortByAudioId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioId', Sort.asc);
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterSortBy>
      sortByAudioIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioId', Sort.desc);
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterSortBy>
      sortByAudioIdIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioIdIndex', Sort.asc);
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterSortBy>
      sortByAudioIdIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioIdIndex', Sort.desc);
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterSortBy> sortByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.asc);
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterSortBy>
      sortByEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.desc);
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterSortBy>
      sortByLineNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineNumber', Sort.asc);
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterSortBy>
      sortByLineNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineNumber', Sort.desc);
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterSortBy> sortByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.asc);
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterSortBy>
      sortByStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.desc);
    });
  }
}

extension AudioTimestampQuerySortThenBy
    on QueryBuilder<AudioTimestamp, AudioTimestamp, QSortThenBy> {
  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterSortBy> thenByAudioId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioId', Sort.asc);
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterSortBy>
      thenByAudioIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioId', Sort.desc);
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterSortBy>
      thenByAudioIdIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioIdIndex', Sort.asc);
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterSortBy>
      thenByAudioIdIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioIdIndex', Sort.desc);
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterSortBy> thenByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.asc);
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterSortBy>
      thenByEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.desc);
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterSortBy>
      thenByLineNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineNumber', Sort.asc);
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterSortBy>
      thenByLineNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineNumber', Sort.desc);
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterSortBy> thenByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.asc);
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QAfterSortBy>
      thenByStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.desc);
    });
  }
}

extension AudioTimestampQueryWhereDistinct
    on QueryBuilder<AudioTimestamp, AudioTimestamp, QDistinct> {
  QueryBuilder<AudioTimestamp, AudioTimestamp, QDistinct> distinctByAudioId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'audioId');
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QDistinct>
      distinctByAudioIdIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'audioIdIndex');
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QDistinct> distinctByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endTime');
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QDistinct>
      distinctByLineNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lineNumber');
    });
  }

  QueryBuilder<AudioTimestamp, AudioTimestamp, QDistinct>
      distinctByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startTime');
    });
  }
}

extension AudioTimestampQueryProperty
    on QueryBuilder<AudioTimestamp, AudioTimestamp, QQueryProperty> {
  QueryBuilder<AudioTimestamp, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AudioTimestamp, int, QQueryOperations> audioIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'audioId');
    });
  }

  QueryBuilder<AudioTimestamp, int, QQueryOperations> audioIdIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'audioIdIndex');
    });
  }

  QueryBuilder<AudioTimestamp, int, QQueryOperations> endTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endTime');
    });
  }

  QueryBuilder<AudioTimestamp, int, QQueryOperations> lineNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lineNumber');
    });
  }

  QueryBuilder<AudioTimestamp, int, QQueryOperations> startTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startTime');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetBookmarkCollection on Isar {
  IsarCollection<Bookmark> get bookmarks => this.collection();
}

const BookmarkSchema = CollectionSchema(
  name: r'Bookmark',
  id: 6727227738202460809,
  properties: {
    r'contentId': PropertySchema(
      id: 0,
      name: r'contentId',
      type: IsarType.long,
    ),
    r'contentType': PropertySchema(
      id: 1,
      name: r'contentType',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'createdAtIndex': PropertySchema(
      id: 3,
      name: r'createdAtIndex',
      type: IsarType.dateTime,
    ),
    r'lastUpdated': PropertySchema(
      id: 4,
      name: r'lastUpdated',
      type: IsarType.dateTime,
    ),
    r'lineNumber': PropertySchema(
      id: 5,
      name: r'lineNumber',
      type: IsarType.long,
    ),
    r'preview': PropertySchema(
      id: 6,
      name: r'preview',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 7,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _bookmarkEstimateSize,
  serialize: _bookmarkSerialize,
  deserialize: _bookmarkDeserialize,
  deserializeProp: _bookmarkDeserializeProp,
  idName: r'id',
  indexes: {
    r'createdAtIndex': IndexSchema(
      id: -7100342901358937067,
      name: r'createdAtIndex',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createdAtIndex',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _bookmarkGetId,
  getLinks: _bookmarkGetLinks,
  attach: _bookmarkAttach,
  version: '3.1.0+1',
);

int _bookmarkEstimateSize(
  Bookmark object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.contentType.length * 3;
  bytesCount += 3 + object.preview.length * 3;
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _bookmarkSerialize(
  Bookmark object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.contentId);
  writer.writeString(offsets[1], object.contentType);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeDateTime(offsets[3], object.createdAtIndex);
  writer.writeDateTime(offsets[4], object.lastUpdated);
  writer.writeLong(offsets[5], object.lineNumber);
  writer.writeString(offsets[6], object.preview);
  writer.writeString(offsets[7], object.title);
}

Bookmark _bookmarkDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Bookmark();
  object.contentId = reader.readLong(offsets[0]);
  object.contentType = reader.readString(offsets[1]);
  object.createdAt = reader.readDateTime(offsets[2]);
  object.createdAtIndex = reader.readDateTime(offsets[3]);
  object.id = id;
  object.lastUpdated = reader.readDateTime(offsets[4]);
  object.lineNumber = reader.readLongOrNull(offsets[5]);
  object.preview = reader.readString(offsets[6]);
  object.title = reader.readString(offsets[7]);
  return object;
}

P _bookmarkDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _bookmarkGetId(Bookmark object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _bookmarkGetLinks(Bookmark object) {
  return [];
}

void _bookmarkAttach(IsarCollection<dynamic> col, Id id, Bookmark object) {
  object.id = id;
}

extension BookmarkQueryWhereSort on QueryBuilder<Bookmark, Bookmark, QWhere> {
  QueryBuilder<Bookmark, Bookmark, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterWhere> anyCreatedAtIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAtIndex'),
      );
    });
  }
}

extension BookmarkQueryWhere on QueryBuilder<Bookmark, Bookmark, QWhereClause> {
  QueryBuilder<Bookmark, Bookmark, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterWhereClause> createdAtIndexEqualTo(
      DateTime createdAtIndex) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAtIndex',
        value: [createdAtIndex],
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterWhereClause> createdAtIndexNotEqualTo(
      DateTime createdAtIndex) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAtIndex',
              lower: [],
              upper: [createdAtIndex],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAtIndex',
              lower: [createdAtIndex],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAtIndex',
              lower: [createdAtIndex],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAtIndex',
              lower: [],
              upper: [createdAtIndex],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterWhereClause> createdAtIndexGreaterThan(
    DateTime createdAtIndex, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAtIndex',
        lower: [createdAtIndex],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterWhereClause> createdAtIndexLessThan(
    DateTime createdAtIndex, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAtIndex',
        lower: [],
        upper: [createdAtIndex],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterWhereClause> createdAtIndexBetween(
    DateTime lowerCreatedAtIndex,
    DateTime upperCreatedAtIndex, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAtIndex',
        lower: [lowerCreatedAtIndex],
        includeLower: includeLower,
        upper: [upperCreatedAtIndex],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension BookmarkQueryFilter
    on QueryBuilder<Bookmark, Bookmark, QFilterCondition> {
  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> contentIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentId',
        value: value,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> contentIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contentId',
        value: value,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> contentIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contentId',
        value: value,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> contentIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contentId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> contentTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition>
      contentTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> contentTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> contentTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contentType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> contentTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'contentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> contentTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'contentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> contentTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'contentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> contentTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'contentType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> contentTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentType',
        value: '',
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition>
      contentTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contentType',
        value: '',
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> createdAtIndexEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAtIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition>
      createdAtIndexGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAtIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition>
      createdAtIndexLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAtIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> createdAtIndexBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAtIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> lastUpdatedEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastUpdated',
        value: value,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition>
      lastUpdatedGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastUpdated',
        value: value,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> lastUpdatedLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastUpdated',
        value: value,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> lastUpdatedBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastUpdated',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> lineNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lineNumber',
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition>
      lineNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lineNumber',
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> lineNumberEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lineNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> lineNumberGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lineNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> lineNumberLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lineNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> lineNumberBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lineNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> previewEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'preview',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> previewGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'preview',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> previewLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'preview',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> previewBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'preview',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> previewStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'preview',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> previewEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'preview',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> previewContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'preview',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> previewMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'preview',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> previewIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'preview',
        value: '',
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> previewIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'preview',
        value: '',
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension BookmarkQueryObject
    on QueryBuilder<Bookmark, Bookmark, QFilterCondition> {}

extension BookmarkQueryLinks
    on QueryBuilder<Bookmark, Bookmark, QFilterCondition> {}

extension BookmarkQuerySortBy on QueryBuilder<Bookmark, Bookmark, QSortBy> {
  QueryBuilder<Bookmark, Bookmark, QAfterSortBy> sortByContentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentId', Sort.asc);
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterSortBy> sortByContentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentId', Sort.desc);
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterSortBy> sortByContentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentType', Sort.asc);
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterSortBy> sortByContentTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentType', Sort.desc);
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterSortBy> sortByCreatedAtIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtIndex', Sort.asc);
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterSortBy> sortByCreatedAtIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtIndex', Sort.desc);
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterSortBy> sortByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.asc);
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterSortBy> sortByLastUpdatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.desc);
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterSortBy> sortByLineNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineNumber', Sort.asc);
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterSortBy> sortByLineNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineNumber', Sort.desc);
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterSortBy> sortByPreview() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preview', Sort.asc);
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterSortBy> sortByPreviewDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preview', Sort.desc);
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension BookmarkQuerySortThenBy
    on QueryBuilder<Bookmark, Bookmark, QSortThenBy> {
  QueryBuilder<Bookmark, Bookmark, QAfterSortBy> thenByContentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentId', Sort.asc);
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterSortBy> thenByContentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentId', Sort.desc);
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterSortBy> thenByContentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentType', Sort.asc);
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterSortBy> thenByContentTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentType', Sort.desc);
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterSortBy> thenByCreatedAtIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtIndex', Sort.asc);
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterSortBy> thenByCreatedAtIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtIndex', Sort.desc);
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterSortBy> thenByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.asc);
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterSortBy> thenByLastUpdatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.desc);
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterSortBy> thenByLineNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineNumber', Sort.asc);
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterSortBy> thenByLineNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineNumber', Sort.desc);
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterSortBy> thenByPreview() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preview', Sort.asc);
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterSortBy> thenByPreviewDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preview', Sort.desc);
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<Bookmark, Bookmark, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension BookmarkQueryWhereDistinct
    on QueryBuilder<Bookmark, Bookmark, QDistinct> {
  QueryBuilder<Bookmark, Bookmark, QDistinct> distinctByContentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contentId');
    });
  }

  QueryBuilder<Bookmark, Bookmark, QDistinct> distinctByContentType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contentType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Bookmark, Bookmark, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<Bookmark, Bookmark, QDistinct> distinctByCreatedAtIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAtIndex');
    });
  }

  QueryBuilder<Bookmark, Bookmark, QDistinct> distinctByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastUpdated');
    });
  }

  QueryBuilder<Bookmark, Bookmark, QDistinct> distinctByLineNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lineNumber');
    });
  }

  QueryBuilder<Bookmark, Bookmark, QDistinct> distinctByPreview(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'preview', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Bookmark, Bookmark, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension BookmarkQueryProperty
    on QueryBuilder<Bookmark, Bookmark, QQueryProperty> {
  QueryBuilder<Bookmark, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Bookmark, int, QQueryOperations> contentIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contentId');
    });
  }

  QueryBuilder<Bookmark, String, QQueryOperations> contentTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contentType');
    });
  }

  QueryBuilder<Bookmark, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<Bookmark, DateTime, QQueryOperations> createdAtIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAtIndex');
    });
  }

  QueryBuilder<Bookmark, DateTime, QQueryOperations> lastUpdatedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastUpdated');
    });
  }

  QueryBuilder<Bookmark, int?, QQueryOperations> lineNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lineNumber');
    });
  }

  QueryBuilder<Bookmark, String, QQueryOperations> previewProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'preview');
    });
  }

  QueryBuilder<Bookmark, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFavoriteCollection on Isar {
  IsarCollection<Favorite> get favorites => this.collection();
}

const FavoriteSchema = CollectionSchema(
  name: r'Favorite',
  id: 5577971995748139032,
  properties: {
    r'contentId': PropertySchema(
      id: 0,
      name: r'contentId',
      type: IsarType.long,
    ),
    r'contentType': PropertySchema(
      id: 1,
      name: r'contentType',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'createdAtIndex': PropertySchema(
      id: 3,
      name: r'createdAtIndex',
      type: IsarType.dateTime,
    ),
    r'title': PropertySchema(
      id: 4,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _favoriteEstimateSize,
  serialize: _favoriteSerialize,
  deserialize: _favoriteDeserialize,
  deserializeProp: _favoriteDeserializeProp,
  idName: r'id',
  indexes: {
    r'createdAtIndex': IndexSchema(
      id: -7100342901358937067,
      name: r'createdAtIndex',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createdAtIndex',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _favoriteGetId,
  getLinks: _favoriteGetLinks,
  attach: _favoriteAttach,
  version: '3.1.0+1',
);

int _favoriteEstimateSize(
  Favorite object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.contentType.length * 3;
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _favoriteSerialize(
  Favorite object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.contentId);
  writer.writeString(offsets[1], object.contentType);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeDateTime(offsets[3], object.createdAtIndex);
  writer.writeString(offsets[4], object.title);
}

Favorite _favoriteDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Favorite();
  object.contentId = reader.readLong(offsets[0]);
  object.contentType = reader.readString(offsets[1]);
  object.createdAt = reader.readDateTime(offsets[2]);
  object.createdAtIndex = reader.readDateTime(offsets[3]);
  object.id = id;
  object.title = reader.readString(offsets[4]);
  return object;
}

P _favoriteDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _favoriteGetId(Favorite object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _favoriteGetLinks(Favorite object) {
  return [];
}

void _favoriteAttach(IsarCollection<dynamic> col, Id id, Favorite object) {
  object.id = id;
}

extension FavoriteQueryWhereSort on QueryBuilder<Favorite, Favorite, QWhere> {
  QueryBuilder<Favorite, Favorite, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterWhere> anyCreatedAtIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAtIndex'),
      );
    });
  }
}

extension FavoriteQueryWhere on QueryBuilder<Favorite, Favorite, QWhereClause> {
  QueryBuilder<Favorite, Favorite, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterWhereClause> createdAtIndexEqualTo(
      DateTime createdAtIndex) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAtIndex',
        value: [createdAtIndex],
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterWhereClause> createdAtIndexNotEqualTo(
      DateTime createdAtIndex) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAtIndex',
              lower: [],
              upper: [createdAtIndex],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAtIndex',
              lower: [createdAtIndex],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAtIndex',
              lower: [createdAtIndex],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAtIndex',
              lower: [],
              upper: [createdAtIndex],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterWhereClause> createdAtIndexGreaterThan(
    DateTime createdAtIndex, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAtIndex',
        lower: [createdAtIndex],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterWhereClause> createdAtIndexLessThan(
    DateTime createdAtIndex, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAtIndex',
        lower: [],
        upper: [createdAtIndex],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterWhereClause> createdAtIndexBetween(
    DateTime lowerCreatedAtIndex,
    DateTime upperCreatedAtIndex, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAtIndex',
        lower: [lowerCreatedAtIndex],
        includeLower: includeLower,
        upper: [upperCreatedAtIndex],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FavoriteQueryFilter
    on QueryBuilder<Favorite, Favorite, QFilterCondition> {
  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> contentIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentId',
        value: value,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> contentIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contentId',
        value: value,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> contentIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contentId',
        value: value,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> contentIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contentId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> contentTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition>
      contentTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> contentTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> contentTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contentType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> contentTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'contentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> contentTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'contentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> contentTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'contentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> contentTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'contentType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> contentTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentType',
        value: '',
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition>
      contentTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contentType',
        value: '',
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> createdAtIndexEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAtIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition>
      createdAtIndexGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAtIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition>
      createdAtIndexLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAtIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> createdAtIndexBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAtIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension FavoriteQueryObject
    on QueryBuilder<Favorite, Favorite, QFilterCondition> {}

extension FavoriteQueryLinks
    on QueryBuilder<Favorite, Favorite, QFilterCondition> {}

extension FavoriteQuerySortBy on QueryBuilder<Favorite, Favorite, QSortBy> {
  QueryBuilder<Favorite, Favorite, QAfterSortBy> sortByContentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentId', Sort.asc);
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterSortBy> sortByContentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentId', Sort.desc);
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterSortBy> sortByContentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentType', Sort.asc);
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterSortBy> sortByContentTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentType', Sort.desc);
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterSortBy> sortByCreatedAtIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtIndex', Sort.asc);
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterSortBy> sortByCreatedAtIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtIndex', Sort.desc);
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension FavoriteQuerySortThenBy
    on QueryBuilder<Favorite, Favorite, QSortThenBy> {
  QueryBuilder<Favorite, Favorite, QAfterSortBy> thenByContentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentId', Sort.asc);
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterSortBy> thenByContentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentId', Sort.desc);
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterSortBy> thenByContentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentType', Sort.asc);
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterSortBy> thenByContentTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentType', Sort.desc);
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterSortBy> thenByCreatedAtIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtIndex', Sort.asc);
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterSortBy> thenByCreatedAtIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtIndex', Sort.desc);
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension FavoriteQueryWhereDistinct
    on QueryBuilder<Favorite, Favorite, QDistinct> {
  QueryBuilder<Favorite, Favorite, QDistinct> distinctByContentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contentId');
    });
  }

  QueryBuilder<Favorite, Favorite, QDistinct> distinctByContentType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contentType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Favorite, Favorite, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<Favorite, Favorite, QDistinct> distinctByCreatedAtIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAtIndex');
    });
  }

  QueryBuilder<Favorite, Favorite, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension FavoriteQueryProperty
    on QueryBuilder<Favorite, Favorite, QQueryProperty> {
  QueryBuilder<Favorite, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Favorite, int, QQueryOperations> contentIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contentId');
    });
  }

  QueryBuilder<Favorite, String, QQueryOperations> contentTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contentType');
    });
  }

  QueryBuilder<Favorite, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<Favorite, DateTime, QQueryOperations> createdAtIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAtIndex');
    });
  }

  QueryBuilder<Favorite, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetReadingProgressCollection on Isar {
  IsarCollection<ReadingProgress> get readingProgress => this.collection();
}

const ReadingProgressSchema = CollectionSchema(
  name: r'ReadingProgress',
  id: -2251063111460261641,
  properties: {
    r'contentId': PropertySchema(
      id: 0,
      name: r'contentId',
      type: IsarType.long,
    ),
    r'contentType': PropertySchema(
      id: 1,
      name: r'contentType',
      type: IsarType.string,
    ),
    r'contentTypeIndex': PropertySchema(
      id: 2,
      name: r'contentTypeIndex',
      type: IsarType.string,
    ),
    r'lastReadAt': PropertySchema(
      id: 3,
      name: r'lastReadAt',
      type: IsarType.dateTime,
    ),
    r'lastReadLine': PropertySchema(
      id: 4,
      name: r'lastReadLine',
      type: IsarType.long,
    ),
    r'totalReadCount': PropertySchema(
      id: 5,
      name: r'totalReadCount',
      type: IsarType.long,
    )
  },
  estimateSize: _readingProgressEstimateSize,
  serialize: _readingProgressSerialize,
  deserialize: _readingProgressDeserialize,
  deserializeProp: _readingProgressDeserializeProp,
  idName: r'id',
  indexes: {
    r'contentTypeIndex': IndexSchema(
      id: -5231726848499791405,
      name: r'contentTypeIndex',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'contentTypeIndex',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _readingProgressGetId,
  getLinks: _readingProgressGetLinks,
  attach: _readingProgressAttach,
  version: '3.1.0+1',
);

int _readingProgressEstimateSize(
  ReadingProgress object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.contentType.length * 3;
  bytesCount += 3 + object.contentTypeIndex.length * 3;
  return bytesCount;
}

void _readingProgressSerialize(
  ReadingProgress object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.contentId);
  writer.writeString(offsets[1], object.contentType);
  writer.writeString(offsets[2], object.contentTypeIndex);
  writer.writeDateTime(offsets[3], object.lastReadAt);
  writer.writeLong(offsets[4], object.lastReadLine);
  writer.writeLong(offsets[5], object.totalReadCount);
}

ReadingProgress _readingProgressDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ReadingProgress();
  object.contentId = reader.readLong(offsets[0]);
  object.contentType = reader.readString(offsets[1]);
  object.contentTypeIndex = reader.readString(offsets[2]);
  object.id = id;
  object.lastReadAt = reader.readDateTime(offsets[3]);
  object.lastReadLine = reader.readLong(offsets[4]);
  object.totalReadCount = reader.readLong(offsets[5]);
  return object;
}

P _readingProgressDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _readingProgressGetId(ReadingProgress object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _readingProgressGetLinks(ReadingProgress object) {
  return [];
}

void _readingProgressAttach(
    IsarCollection<dynamic> col, Id id, ReadingProgress object) {
  object.id = id;
}

extension ReadingProgressQueryWhereSort
    on QueryBuilder<ReadingProgress, ReadingProgress, QWhere> {
  QueryBuilder<ReadingProgress, ReadingProgress, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ReadingProgressQueryWhere
    on QueryBuilder<ReadingProgress, ReadingProgress, QWhereClause> {
  QueryBuilder<ReadingProgress, ReadingProgress, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterWhereClause>
      contentTypeIndexEqualTo(String contentTypeIndex) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'contentTypeIndex',
        value: [contentTypeIndex],
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterWhereClause>
      contentTypeIndexNotEqualTo(String contentTypeIndex) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'contentTypeIndex',
              lower: [],
              upper: [contentTypeIndex],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'contentTypeIndex',
              lower: [contentTypeIndex],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'contentTypeIndex',
              lower: [contentTypeIndex],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'contentTypeIndex',
              lower: [],
              upper: [contentTypeIndex],
              includeUpper: false,
            ));
      }
    });
  }
}

extension ReadingProgressQueryFilter
    on QueryBuilder<ReadingProgress, ReadingProgress, QFilterCondition> {
  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      contentIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentId',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      contentIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contentId',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      contentIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contentId',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      contentIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contentId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      contentTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      contentTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      contentTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      contentTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contentType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      contentTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'contentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      contentTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'contentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      contentTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'contentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      contentTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'contentType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      contentTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentType',
        value: '',
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      contentTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contentType',
        value: '',
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      contentTypeIndexEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentTypeIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      contentTypeIndexGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contentTypeIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      contentTypeIndexLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contentTypeIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      contentTypeIndexBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contentTypeIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      contentTypeIndexStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'contentTypeIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      contentTypeIndexEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'contentTypeIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      contentTypeIndexContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'contentTypeIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      contentTypeIndexMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'contentTypeIndex',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      contentTypeIndexIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentTypeIndex',
        value: '',
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      contentTypeIndexIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contentTypeIndex',
        value: '',
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      lastReadAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastReadAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      lastReadAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastReadAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      lastReadAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastReadAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      lastReadAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastReadAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      lastReadLineEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastReadLine',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      lastReadLineGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastReadLine',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      lastReadLineLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastReadLine',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      lastReadLineBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastReadLine',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      totalReadCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalReadCount',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      totalReadCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalReadCount',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      totalReadCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalReadCount',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterFilterCondition>
      totalReadCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalReadCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ReadingProgressQueryObject
    on QueryBuilder<ReadingProgress, ReadingProgress, QFilterCondition> {}

extension ReadingProgressQueryLinks
    on QueryBuilder<ReadingProgress, ReadingProgress, QFilterCondition> {}

extension ReadingProgressQuerySortBy
    on QueryBuilder<ReadingProgress, ReadingProgress, QSortBy> {
  QueryBuilder<ReadingProgress, ReadingProgress, QAfterSortBy>
      sortByContentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentId', Sort.asc);
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterSortBy>
      sortByContentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentId', Sort.desc);
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterSortBy>
      sortByContentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentType', Sort.asc);
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterSortBy>
      sortByContentTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentType', Sort.desc);
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterSortBy>
      sortByContentTypeIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentTypeIndex', Sort.asc);
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterSortBy>
      sortByContentTypeIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentTypeIndex', Sort.desc);
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterSortBy>
      sortByLastReadAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReadAt', Sort.asc);
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterSortBy>
      sortByLastReadAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReadAt', Sort.desc);
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterSortBy>
      sortByLastReadLine() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReadLine', Sort.asc);
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterSortBy>
      sortByLastReadLineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReadLine', Sort.desc);
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterSortBy>
      sortByTotalReadCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalReadCount', Sort.asc);
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterSortBy>
      sortByTotalReadCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalReadCount', Sort.desc);
    });
  }
}

extension ReadingProgressQuerySortThenBy
    on QueryBuilder<ReadingProgress, ReadingProgress, QSortThenBy> {
  QueryBuilder<ReadingProgress, ReadingProgress, QAfterSortBy>
      thenByContentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentId', Sort.asc);
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterSortBy>
      thenByContentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentId', Sort.desc);
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterSortBy>
      thenByContentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentType', Sort.asc);
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterSortBy>
      thenByContentTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentType', Sort.desc);
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterSortBy>
      thenByContentTypeIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentTypeIndex', Sort.asc);
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterSortBy>
      thenByContentTypeIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentTypeIndex', Sort.desc);
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterSortBy>
      thenByLastReadAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReadAt', Sort.asc);
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterSortBy>
      thenByLastReadAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReadAt', Sort.desc);
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterSortBy>
      thenByLastReadLine() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReadLine', Sort.asc);
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterSortBy>
      thenByLastReadLineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReadLine', Sort.desc);
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterSortBy>
      thenByTotalReadCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalReadCount', Sort.asc);
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QAfterSortBy>
      thenByTotalReadCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalReadCount', Sort.desc);
    });
  }
}

extension ReadingProgressQueryWhereDistinct
    on QueryBuilder<ReadingProgress, ReadingProgress, QDistinct> {
  QueryBuilder<ReadingProgress, ReadingProgress, QDistinct>
      distinctByContentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contentId');
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QDistinct>
      distinctByContentType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contentType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QDistinct>
      distinctByContentTypeIndex({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contentTypeIndex',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QDistinct>
      distinctByLastReadAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastReadAt');
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QDistinct>
      distinctByLastReadLine() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastReadLine');
    });
  }

  QueryBuilder<ReadingProgress, ReadingProgress, QDistinct>
      distinctByTotalReadCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalReadCount');
    });
  }
}

extension ReadingProgressQueryProperty
    on QueryBuilder<ReadingProgress, ReadingProgress, QQueryProperty> {
  QueryBuilder<ReadingProgress, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ReadingProgress, int, QQueryOperations> contentIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contentId');
    });
  }

  QueryBuilder<ReadingProgress, String, QQueryOperations>
      contentTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contentType');
    });
  }

  QueryBuilder<ReadingProgress, String, QQueryOperations>
      contentTypeIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contentTypeIndex');
    });
  }

  QueryBuilder<ReadingProgress, DateTime, QQueryOperations>
      lastReadAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastReadAt');
    });
  }

  QueryBuilder<ReadingProgress, int, QQueryOperations> lastReadLineProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastReadLine');
    });
  }

  QueryBuilder<ReadingProgress, int, QQueryOperations>
      totalReadCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalReadCount');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAppSettingsCollection on Isar {
  IsarCollection<AppSettings> get appSettings => this.collection();
}

const AppSettingsSchema = CollectionSchema(
  name: r'AppSettings',
  id: -5633561779022347008,
  properties: {
    r'arabicFontSize': PropertySchema(
      id: 0,
      name: r'arabicFontSize',
      type: IsarType.double,
    ),
    r'azanNotifications': PropertySchema(
      id: 1,
      name: r'azanNotifications',
      type: IsarType.bool,
    ),
    r'darkMode': PropertySchema(
      id: 2,
      name: r'darkMode',
      type: IsarType.bool,
    ),
    r'eventNotifications': PropertySchema(
      id: 3,
      name: r'eventNotifications',
      type: IsarType.bool,
    ),
    r'fontSize': PropertySchema(
      id: 4,
      name: r'fontSize',
      type: IsarType.double,
    ),
    r'lastKnownLatitude': PropertySchema(
      id: 5,
      name: r'lastKnownLatitude',
      type: IsarType.double,
    ),
    r'lastKnownLocation': PropertySchema(
      id: 6,
      name: r'lastKnownLocation',
      type: IsarType.string,
    ),
    r'lastKnownLongitude': PropertySchema(
      id: 7,
      name: r'lastKnownLongitude',
      type: IsarType.double,
    ),
    r'locale': PropertySchema(
      id: 8,
      name: r'locale',
      type: IsarType.string,
    ),
    r'notificationsEnabled': PropertySchema(
      id: 9,
      name: r'notificationsEnabled',
      type: IsarType.bool,
    ),
    r'reciterPreference': PropertySchema(
      id: 10,
      name: r'reciterPreference',
      type: IsarType.string,
    ),
    r'settingsUpdateTime': PropertySchema(
      id: 11,
      name: r'settingsUpdateTime',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _appSettingsEstimateSize,
  serialize: _appSettingsSerialize,
  deserialize: _appSettingsDeserialize,
  deserializeProp: _appSettingsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _appSettingsGetId,
  getLinks: _appSettingsGetLinks,
  attach: _appSettingsAttach,
  version: '3.1.0+1',
);

int _appSettingsEstimateSize(
  AppSettings object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.lastKnownLocation;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.locale.length * 3;
  bytesCount += 3 + object.reciterPreference.length * 3;
  return bytesCount;
}

void _appSettingsSerialize(
  AppSettings object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.arabicFontSize);
  writer.writeBool(offsets[1], object.azanNotifications);
  writer.writeBool(offsets[2], object.darkMode);
  writer.writeBool(offsets[3], object.eventNotifications);
  writer.writeDouble(offsets[4], object.fontSize);
  writer.writeDouble(offsets[5], object.lastKnownLatitude);
  writer.writeString(offsets[6], object.lastKnownLocation);
  writer.writeDouble(offsets[7], object.lastKnownLongitude);
  writer.writeString(offsets[8], object.locale);
  writer.writeBool(offsets[9], object.notificationsEnabled);
  writer.writeString(offsets[10], object.reciterPreference);
  writer.writeDateTime(offsets[11], object.settingsUpdateTime);
}

AppSettings _appSettingsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AppSettings();
  object.arabicFontSize = reader.readDouble(offsets[0]);
  object.azanNotifications = reader.readBool(offsets[1]);
  object.darkMode = reader.readBool(offsets[2]);
  object.eventNotifications = reader.readBool(offsets[3]);
  object.fontSize = reader.readDouble(offsets[4]);
  object.id = id;
  object.lastKnownLatitude = reader.readDouble(offsets[5]);
  object.lastKnownLocation = reader.readStringOrNull(offsets[6]);
  object.lastKnownLongitude = reader.readDouble(offsets[7]);
  object.locale = reader.readString(offsets[8]);
  object.notificationsEnabled = reader.readBool(offsets[9]);
  object.reciterPreference = reader.readString(offsets[10]);
  object.settingsUpdateTime = reader.readDateTime(offsets[11]);
  return object;
}

P _appSettingsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readBool(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _appSettingsGetId(AppSettings object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _appSettingsGetLinks(AppSettings object) {
  return [];
}

void _appSettingsAttach(
    IsarCollection<dynamic> col, Id id, AppSettings object) {
  object.id = id;
}

extension AppSettingsQueryWhereSort
    on QueryBuilder<AppSettings, AppSettings, QWhere> {
  QueryBuilder<AppSettings, AppSettings, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AppSettingsQueryWhere
    on QueryBuilder<AppSettings, AppSettings, QWhereClause> {
  QueryBuilder<AppSettings, AppSettings, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AppSettingsQueryFilter
    on QueryBuilder<AppSettings, AppSettings, QFilterCondition> {
  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      arabicFontSizeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'arabicFontSize',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      arabicFontSizeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'arabicFontSize',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      arabicFontSizeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'arabicFontSize',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      arabicFontSizeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'arabicFontSize',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      azanNotificationsEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'azanNotifications',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> darkModeEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'darkMode',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      eventNotificationsEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'eventNotifications',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> fontSizeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fontSize',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      fontSizeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fontSize',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      fontSizeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fontSize',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> fontSizeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fontSize',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      lastKnownLatitudeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastKnownLatitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      lastKnownLatitudeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastKnownLatitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      lastKnownLatitudeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastKnownLatitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      lastKnownLatitudeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastKnownLatitude',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      lastKnownLocationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastKnownLocation',
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      lastKnownLocationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastKnownLocation',
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      lastKnownLocationEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastKnownLocation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      lastKnownLocationGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastKnownLocation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      lastKnownLocationLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastKnownLocation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      lastKnownLocationBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastKnownLocation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      lastKnownLocationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastKnownLocation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      lastKnownLocationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastKnownLocation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      lastKnownLocationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastKnownLocation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      lastKnownLocationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastKnownLocation',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      lastKnownLocationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastKnownLocation',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      lastKnownLocationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastKnownLocation',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      lastKnownLongitudeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastKnownLongitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      lastKnownLongitudeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastKnownLongitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      lastKnownLongitudeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastKnownLongitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      lastKnownLongitudeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastKnownLongitude',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> localeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locale',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      localeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'locale',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> localeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'locale',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> localeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'locale',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      localeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'locale',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> localeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'locale',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> localeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'locale',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> localeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'locale',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      localeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locale',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      localeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'locale',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      notificationsEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificationsEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      reciterPreferenceEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reciterPreference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      reciterPreferenceGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reciterPreference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      reciterPreferenceLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reciterPreference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      reciterPreferenceBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reciterPreference',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      reciterPreferenceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'reciterPreference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      reciterPreferenceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'reciterPreference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      reciterPreferenceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'reciterPreference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      reciterPreferenceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'reciterPreference',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      reciterPreferenceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reciterPreference',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      reciterPreferenceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'reciterPreference',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      settingsUpdateTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'settingsUpdateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      settingsUpdateTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'settingsUpdateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      settingsUpdateTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'settingsUpdateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      settingsUpdateTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'settingsUpdateTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AppSettingsQueryObject
    on QueryBuilder<AppSettings, AppSettings, QFilterCondition> {}

extension AppSettingsQueryLinks
    on QueryBuilder<AppSettings, AppSettings, QFilterCondition> {}

extension AppSettingsQuerySortBy
    on QueryBuilder<AppSettings, AppSettings, QSortBy> {
  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> sortByArabicFontSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'arabicFontSize', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
      sortByArabicFontSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'arabicFontSize', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
      sortByAzanNotifications() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'azanNotifications', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
      sortByAzanNotificationsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'azanNotifications', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> sortByDarkMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'darkMode', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> sortByDarkModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'darkMode', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
      sortByEventNotifications() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventNotifications', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
      sortByEventNotificationsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventNotifications', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> sortByFontSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontSize', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> sortByFontSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontSize', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
      sortByLastKnownLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastKnownLatitude', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
      sortByLastKnownLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastKnownLatitude', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
      sortByLastKnownLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastKnownLocation', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
      sortByLastKnownLocationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastKnownLocation', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
      sortByLastKnownLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastKnownLongitude', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
      sortByLastKnownLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastKnownLongitude', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> sortByLocale() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locale', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> sortByLocaleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locale', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
      sortByNotificationsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationsEnabled', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
      sortByNotificationsEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationsEnabled', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
      sortByReciterPreference() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reciterPreference', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
      sortByReciterPreferenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reciterPreference', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
      sortBySettingsUpdateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'settingsUpdateTime', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
      sortBySettingsUpdateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'settingsUpdateTime', Sort.desc);
    });
  }
}

extension AppSettingsQuerySortThenBy
    on QueryBuilder<AppSettings, AppSettings, QSortThenBy> {
  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> thenByArabicFontSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'arabicFontSize', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
      thenByArabicFontSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'arabicFontSize', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
      thenByAzanNotifications() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'azanNotifications', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
      thenByAzanNotificationsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'azanNotifications', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> thenByDarkMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'darkMode', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> thenByDarkModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'darkMode', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
      thenByEventNotifications() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventNotifications', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
      thenByEventNotificationsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventNotifications', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> thenByFontSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontSize', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> thenByFontSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontSize', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
      thenByLastKnownLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastKnownLatitude', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
      thenByLastKnownLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastKnownLatitude', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
      thenByLastKnownLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastKnownLocation', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
      thenByLastKnownLocationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastKnownLocation', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
      thenByLastKnownLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastKnownLongitude', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
      thenByLastKnownLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastKnownLongitude', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> thenByLocale() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locale', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> thenByLocaleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locale', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
      thenByNotificationsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationsEnabled', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
      thenByNotificationsEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationsEnabled', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
      thenByReciterPreference() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reciterPreference', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
      thenByReciterPreferenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reciterPreference', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
      thenBySettingsUpdateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'settingsUpdateTime', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
      thenBySettingsUpdateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'settingsUpdateTime', Sort.desc);
    });
  }
}

extension AppSettingsQueryWhereDistinct
    on QueryBuilder<AppSettings, AppSettings, QDistinct> {
  QueryBuilder<AppSettings, AppSettings, QDistinct> distinctByArabicFontSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'arabicFontSize');
    });
  }

  QueryBuilder<AppSettings, AppSettings, QDistinct>
      distinctByAzanNotifications() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'azanNotifications');
    });
  }

  QueryBuilder<AppSettings, AppSettings, QDistinct> distinctByDarkMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'darkMode');
    });
  }

  QueryBuilder<AppSettings, AppSettings, QDistinct>
      distinctByEventNotifications() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'eventNotifications');
    });
  }

  QueryBuilder<AppSettings, AppSettings, QDistinct> distinctByFontSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fontSize');
    });
  }

  QueryBuilder<AppSettings, AppSettings, QDistinct>
      distinctByLastKnownLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastKnownLatitude');
    });
  }

  QueryBuilder<AppSettings, AppSettings, QDistinct> distinctByLastKnownLocation(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastKnownLocation',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QDistinct>
      distinctByLastKnownLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastKnownLongitude');
    });
  }

  QueryBuilder<AppSettings, AppSettings, QDistinct> distinctByLocale(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'locale', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QDistinct>
      distinctByNotificationsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notificationsEnabled');
    });
  }

  QueryBuilder<AppSettings, AppSettings, QDistinct> distinctByReciterPreference(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reciterPreference',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QDistinct>
      distinctBySettingsUpdateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'settingsUpdateTime');
    });
  }
}

extension AppSettingsQueryProperty
    on QueryBuilder<AppSettings, AppSettings, QQueryProperty> {
  QueryBuilder<AppSettings, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AppSettings, double, QQueryOperations> arabicFontSizeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'arabicFontSize');
    });
  }

  QueryBuilder<AppSettings, bool, QQueryOperations>
      azanNotificationsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'azanNotifications');
    });
  }

  QueryBuilder<AppSettings, bool, QQueryOperations> darkModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'darkMode');
    });
  }

  QueryBuilder<AppSettings, bool, QQueryOperations>
      eventNotificationsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'eventNotifications');
    });
  }

  QueryBuilder<AppSettings, double, QQueryOperations> fontSizeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fontSize');
    });
  }

  QueryBuilder<AppSettings, double, QQueryOperations>
      lastKnownLatitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastKnownLatitude');
    });
  }

  QueryBuilder<AppSettings, String?, QQueryOperations>
      lastKnownLocationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastKnownLocation');
    });
  }

  QueryBuilder<AppSettings, double, QQueryOperations>
      lastKnownLongitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastKnownLongitude');
    });
  }

  QueryBuilder<AppSettings, String, QQueryOperations> localeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'locale');
    });
  }

  QueryBuilder<AppSettings, bool, QQueryOperations>
      notificationsEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notificationsEnabled');
    });
  }

  QueryBuilder<AppSettings, String, QQueryOperations>
      reciterPreferenceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reciterPreference');
    });
  }

  QueryBuilder<AppSettings, DateTime, QQueryOperations>
      settingsUpdateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'settingsUpdateTime');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCategoryCollection on Isar {
  IsarCollection<Category> get categorys => this.collection();
}

const CategorySchema = CollectionSchema(
  name: r'Category',
  id: 5751694338128944171,
  properties: {
    r'categoryId': PropertySchema(
      id: 0,
      name: r'categoryId',
      type: IsarType.long,
    ),
    r'icon': PropertySchema(
      id: 1,
      name: r'icon',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 2,
      name: r'name',
      type: IsarType.string,
    ),
    r'nameArabic': PropertySchema(
      id: 3,
      name: r'nameArabic',
      type: IsarType.string,
    ),
    r'order': PropertySchema(
      id: 4,
      name: r'order',
      type: IsarType.long,
    ),
    r'type': PropertySchema(
      id: 5,
      name: r'type',
      type: IsarType.string,
    )
  },
  estimateSize: _categoryEstimateSize,
  serialize: _categorySerialize,
  deserialize: _categoryDeserialize,
  deserializeProp: _categoryDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _categoryGetId,
  getLinks: _categoryGetLinks,
  attach: _categoryAttach,
  version: '3.1.0+1',
);

int _categoryEstimateSize(
  Category object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.icon.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.nameArabic.length * 3;
  bytesCount += 3 + object.type.length * 3;
  return bytesCount;
}

void _categorySerialize(
  Category object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.categoryId);
  writer.writeString(offsets[1], object.icon);
  writer.writeString(offsets[2], object.name);
  writer.writeString(offsets[3], object.nameArabic);
  writer.writeLong(offsets[4], object.order);
  writer.writeString(offsets[5], object.type);
}

Category _categoryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Category();
  object.categoryId = reader.readLong(offsets[0]);
  object.icon = reader.readString(offsets[1]);
  object.id = id;
  object.name = reader.readString(offsets[2]);
  object.nameArabic = reader.readString(offsets[3]);
  object.order = reader.readLong(offsets[4]);
  object.type = reader.readString(offsets[5]);
  return object;
}

P _categoryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _categoryGetId(Category object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _categoryGetLinks(Category object) {
  return [];
}

void _categoryAttach(IsarCollection<dynamic> col, Id id, Category object) {
  object.id = id;
}

extension CategoryQueryWhereSort on QueryBuilder<Category, Category, QWhere> {
  QueryBuilder<Category, Category, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CategoryQueryWhere on QueryBuilder<Category, Category, QWhereClause> {
  QueryBuilder<Category, Category, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Category, Category, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Category, Category, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Category, Category, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CategoryQueryFilter
    on QueryBuilder<Category, Category, QFilterCondition> {
  QueryBuilder<Category, Category, QAfterFilterCondition> categoryIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categoryId',
        value: value,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> categoryIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'categoryId',
        value: value,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> categoryIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'categoryId',
        value: value,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> categoryIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'categoryId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> iconEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'icon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> iconGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'icon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> iconLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'icon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> iconBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'icon',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> iconStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'icon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> iconEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'icon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> iconContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'icon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> iconMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'icon',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> iconIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'icon',
        value: '',
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> iconIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'icon',
        value: '',
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> nameArabicEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nameArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> nameArabicGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nameArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> nameArabicLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nameArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> nameArabicBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nameArabic',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> nameArabicStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nameArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> nameArabicEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nameArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> nameArabicContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nameArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> nameArabicMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nameArabic',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> nameArabicIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nameArabic',
        value: '',
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition>
      nameArabicIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nameArabic',
        value: '',
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> orderEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'order',
        value: value,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> orderGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'order',
        value: value,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> orderLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'order',
        value: value,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> orderBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'order',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> typeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> typeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> typeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> typeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> typeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<Category, Category, QAfterFilterCondition> typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension CategoryQueryObject
    on QueryBuilder<Category, Category, QFilterCondition> {}

extension CategoryQueryLinks
    on QueryBuilder<Category, Category, QFilterCondition> {}

extension CategoryQuerySortBy on QueryBuilder<Category, Category, QSortBy> {
  QueryBuilder<Category, Category, QAfterSortBy> sortByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.asc);
    });
  }

  QueryBuilder<Category, Category, QAfterSortBy> sortByCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.desc);
    });
  }

  QueryBuilder<Category, Category, QAfterSortBy> sortByIcon() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'icon', Sort.asc);
    });
  }

  QueryBuilder<Category, Category, QAfterSortBy> sortByIconDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'icon', Sort.desc);
    });
  }

  QueryBuilder<Category, Category, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Category, Category, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Category, Category, QAfterSortBy> sortByNameArabic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameArabic', Sort.asc);
    });
  }

  QueryBuilder<Category, Category, QAfterSortBy> sortByNameArabicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameArabic', Sort.desc);
    });
  }

  QueryBuilder<Category, Category, QAfterSortBy> sortByOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.asc);
    });
  }

  QueryBuilder<Category, Category, QAfterSortBy> sortByOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.desc);
    });
  }

  QueryBuilder<Category, Category, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Category, Category, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension CategoryQuerySortThenBy
    on QueryBuilder<Category, Category, QSortThenBy> {
  QueryBuilder<Category, Category, QAfterSortBy> thenByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.asc);
    });
  }

  QueryBuilder<Category, Category, QAfterSortBy> thenByCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.desc);
    });
  }

  QueryBuilder<Category, Category, QAfterSortBy> thenByIcon() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'icon', Sort.asc);
    });
  }

  QueryBuilder<Category, Category, QAfterSortBy> thenByIconDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'icon', Sort.desc);
    });
  }

  QueryBuilder<Category, Category, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Category, Category, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Category, Category, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Category, Category, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Category, Category, QAfterSortBy> thenByNameArabic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameArabic', Sort.asc);
    });
  }

  QueryBuilder<Category, Category, QAfterSortBy> thenByNameArabicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameArabic', Sort.desc);
    });
  }

  QueryBuilder<Category, Category, QAfterSortBy> thenByOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.asc);
    });
  }

  QueryBuilder<Category, Category, QAfterSortBy> thenByOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.desc);
    });
  }

  QueryBuilder<Category, Category, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Category, Category, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension CategoryQueryWhereDistinct
    on QueryBuilder<Category, Category, QDistinct> {
  QueryBuilder<Category, Category, QDistinct> distinctByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'categoryId');
    });
  }

  QueryBuilder<Category, Category, QDistinct> distinctByIcon(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'icon', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Category, Category, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Category, Category, QDistinct> distinctByNameArabic(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nameArabic', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Category, Category, QDistinct> distinctByOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'order');
    });
  }

  QueryBuilder<Category, Category, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }
}

extension CategoryQueryProperty
    on QueryBuilder<Category, Category, QQueryProperty> {
  QueryBuilder<Category, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Category, int, QQueryOperations> categoryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'categoryId');
    });
  }

  QueryBuilder<Category, String, QQueryOperations> iconProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'icon');
    });
  }

  QueryBuilder<Category, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Category, String, QQueryOperations> nameArabicProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nameArabic');
    });
  }

  QueryBuilder<Category, int, QQueryOperations> orderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'order');
    });
  }

  QueryBuilder<Category, String, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetEventNotificationCollection on Isar {
  IsarCollection<EventNotification> get eventNotifications => this.collection();
}

const EventNotificationSchema = CollectionSchema(
  name: r'EventNotification',
  id: -7786168950530380289,
  properties: {
    r'description': PropertySchema(
      id: 0,
      name: r'description',
      type: IsarType.string,
    ),
    r'eventDate': PropertySchema(
      id: 1,
      name: r'eventDate',
      type: IsarType.dateTime,
    ),
    r'eventName': PropertySchema(
      id: 2,
      name: r'eventName',
      type: IsarType.string,
    ),
    r'eventNameArabic': PropertySchema(
      id: 3,
      name: r'eventNameArabic',
      type: IsarType.string,
    ),
    r'isHijriDate': PropertySchema(
      id: 4,
      name: r'isHijriDate',
      type: IsarType.bool,
    ),
    r'relatedContent': PropertySchema(
      id: 5,
      name: r'relatedContent',
      type: IsarType.string,
    ),
    r'reminderEnabled': PropertySchema(
      id: 6,
      name: r'reminderEnabled',
      type: IsarType.bool,
    ),
    r'reminderTime': PropertySchema(
      id: 7,
      name: r'reminderTime',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _eventNotificationEstimateSize,
  serialize: _eventNotificationSerialize,
  deserialize: _eventNotificationDeserialize,
  deserializeProp: _eventNotificationDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _eventNotificationGetId,
  getLinks: _eventNotificationGetLinks,
  attach: _eventNotificationAttach,
  version: '3.1.0+1',
);

int _eventNotificationEstimateSize(
  EventNotification object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.description.length * 3;
  bytesCount += 3 + object.eventName.length * 3;
  bytesCount += 3 + object.eventNameArabic.length * 3;
  {
    final value = object.relatedContent;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _eventNotificationSerialize(
  EventNotification object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.description);
  writer.writeDateTime(offsets[1], object.eventDate);
  writer.writeString(offsets[2], object.eventName);
  writer.writeString(offsets[3], object.eventNameArabic);
  writer.writeBool(offsets[4], object.isHijriDate);
  writer.writeString(offsets[5], object.relatedContent);
  writer.writeBool(offsets[6], object.reminderEnabled);
  writer.writeDateTime(offsets[7], object.reminderTime);
}

EventNotification _eventNotificationDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = EventNotification();
  object.description = reader.readString(offsets[0]);
  object.eventDate = reader.readDateTime(offsets[1]);
  object.eventName = reader.readString(offsets[2]);
  object.eventNameArabic = reader.readString(offsets[3]);
  object.id = id;
  object.isHijriDate = reader.readBool(offsets[4]);
  object.relatedContent = reader.readStringOrNull(offsets[5]);
  object.reminderEnabled = reader.readBool(offsets[6]);
  object.reminderTime = reader.readDateTimeOrNull(offsets[7]);
  return object;
}

P _eventNotificationDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _eventNotificationGetId(EventNotification object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _eventNotificationGetLinks(
    EventNotification object) {
  return [];
}

void _eventNotificationAttach(
    IsarCollection<dynamic> col, Id id, EventNotification object) {
  object.id = id;
}

extension EventNotificationQueryWhereSort
    on QueryBuilder<EventNotification, EventNotification, QWhere> {
  QueryBuilder<EventNotification, EventNotification, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension EventNotificationQueryWhere
    on QueryBuilder<EventNotification, EventNotification, QWhereClause> {
  QueryBuilder<EventNotification, EventNotification, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension EventNotificationQueryFilter
    on QueryBuilder<EventNotification, EventNotification, QFilterCondition> {
  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      descriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      eventDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'eventDate',
        value: value,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      eventDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'eventDate',
        value: value,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      eventDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'eventDate',
        value: value,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      eventDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'eventDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      eventNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'eventName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      eventNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'eventName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      eventNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'eventName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      eventNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'eventName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      eventNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'eventName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      eventNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'eventName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      eventNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'eventName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      eventNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'eventName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      eventNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'eventName',
        value: '',
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      eventNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'eventName',
        value: '',
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      eventNameArabicEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'eventNameArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      eventNameArabicGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'eventNameArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      eventNameArabicLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'eventNameArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      eventNameArabicBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'eventNameArabic',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      eventNameArabicStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'eventNameArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      eventNameArabicEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'eventNameArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      eventNameArabicContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'eventNameArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      eventNameArabicMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'eventNameArabic',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      eventNameArabicIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'eventNameArabic',
        value: '',
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      eventNameArabicIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'eventNameArabic',
        value: '',
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      isHijriDateEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isHijriDate',
        value: value,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      relatedContentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'relatedContent',
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      relatedContentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'relatedContent',
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      relatedContentEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'relatedContent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      relatedContentGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'relatedContent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      relatedContentLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'relatedContent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      relatedContentBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'relatedContent',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      relatedContentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'relatedContent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      relatedContentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'relatedContent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      relatedContentContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'relatedContent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      relatedContentMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'relatedContent',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      relatedContentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'relatedContent',
        value: '',
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      relatedContentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'relatedContent',
        value: '',
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      reminderEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reminderEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      reminderTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'reminderTime',
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      reminderTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'reminderTime',
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      reminderTimeEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reminderTime',
        value: value,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      reminderTimeGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reminderTime',
        value: value,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      reminderTimeLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reminderTime',
        value: value,
      ));
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterFilterCondition>
      reminderTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reminderTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension EventNotificationQueryObject
    on QueryBuilder<EventNotification, EventNotification, QFilterCondition> {}

extension EventNotificationQueryLinks
    on QueryBuilder<EventNotification, EventNotification, QFilterCondition> {}

extension EventNotificationQuerySortBy
    on QueryBuilder<EventNotification, EventNotification, QSortBy> {
  QueryBuilder<EventNotification, EventNotification, QAfterSortBy>
      sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterSortBy>
      sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterSortBy>
      sortByEventDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventDate', Sort.asc);
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterSortBy>
      sortByEventDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventDate', Sort.desc);
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterSortBy>
      sortByEventName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventName', Sort.asc);
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterSortBy>
      sortByEventNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventName', Sort.desc);
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterSortBy>
      sortByEventNameArabic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventNameArabic', Sort.asc);
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterSortBy>
      sortByEventNameArabicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventNameArabic', Sort.desc);
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterSortBy>
      sortByIsHijriDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHijriDate', Sort.asc);
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterSortBy>
      sortByIsHijriDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHijriDate', Sort.desc);
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterSortBy>
      sortByRelatedContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relatedContent', Sort.asc);
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterSortBy>
      sortByRelatedContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relatedContent', Sort.desc);
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterSortBy>
      sortByReminderEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderEnabled', Sort.asc);
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterSortBy>
      sortByReminderEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderEnabled', Sort.desc);
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterSortBy>
      sortByReminderTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderTime', Sort.asc);
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterSortBy>
      sortByReminderTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderTime', Sort.desc);
    });
  }
}

extension EventNotificationQuerySortThenBy
    on QueryBuilder<EventNotification, EventNotification, QSortThenBy> {
  QueryBuilder<EventNotification, EventNotification, QAfterSortBy>
      thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterSortBy>
      thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterSortBy>
      thenByEventDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventDate', Sort.asc);
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterSortBy>
      thenByEventDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventDate', Sort.desc);
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterSortBy>
      thenByEventName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventName', Sort.asc);
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterSortBy>
      thenByEventNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventName', Sort.desc);
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterSortBy>
      thenByEventNameArabic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventNameArabic', Sort.asc);
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterSortBy>
      thenByEventNameArabicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventNameArabic', Sort.desc);
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterSortBy>
      thenByIsHijriDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHijriDate', Sort.asc);
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterSortBy>
      thenByIsHijriDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHijriDate', Sort.desc);
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterSortBy>
      thenByRelatedContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relatedContent', Sort.asc);
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterSortBy>
      thenByRelatedContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relatedContent', Sort.desc);
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterSortBy>
      thenByReminderEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderEnabled', Sort.asc);
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterSortBy>
      thenByReminderEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderEnabled', Sort.desc);
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterSortBy>
      thenByReminderTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderTime', Sort.asc);
    });
  }

  QueryBuilder<EventNotification, EventNotification, QAfterSortBy>
      thenByReminderTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderTime', Sort.desc);
    });
  }
}

extension EventNotificationQueryWhereDistinct
    on QueryBuilder<EventNotification, EventNotification, QDistinct> {
  QueryBuilder<EventNotification, EventNotification, QDistinct>
      distinctByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EventNotification, EventNotification, QDistinct>
      distinctByEventDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'eventDate');
    });
  }

  QueryBuilder<EventNotification, EventNotification, QDistinct>
      distinctByEventName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'eventName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EventNotification, EventNotification, QDistinct>
      distinctByEventNameArabic({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'eventNameArabic',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EventNotification, EventNotification, QDistinct>
      distinctByIsHijriDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isHijriDate');
    });
  }

  QueryBuilder<EventNotification, EventNotification, QDistinct>
      distinctByRelatedContent({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'relatedContent',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EventNotification, EventNotification, QDistinct>
      distinctByReminderEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reminderEnabled');
    });
  }

  QueryBuilder<EventNotification, EventNotification, QDistinct>
      distinctByReminderTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reminderTime');
    });
  }
}

extension EventNotificationQueryProperty
    on QueryBuilder<EventNotification, EventNotification, QQueryProperty> {
  QueryBuilder<EventNotification, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<EventNotification, String, QQueryOperations>
      descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<EventNotification, DateTime, QQueryOperations>
      eventDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'eventDate');
    });
  }

  QueryBuilder<EventNotification, String, QQueryOperations>
      eventNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'eventName');
    });
  }

  QueryBuilder<EventNotification, String, QQueryOperations>
      eventNameArabicProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'eventNameArabic');
    });
  }

  QueryBuilder<EventNotification, bool, QQueryOperations>
      isHijriDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isHijriDate');
    });
  }

  QueryBuilder<EventNotification, String?, QQueryOperations>
      relatedContentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'relatedContent');
    });
  }

  QueryBuilder<EventNotification, bool, QQueryOperations>
      reminderEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reminderEnabled');
    });
  }

  QueryBuilder<EventNotification, DateTime?, QQueryOperations>
      reminderTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reminderTime');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPrayerTimeCollection on Isar {
  IsarCollection<PrayerTime> get prayerTimes => this.collection();
}

const PrayerTimeSchema = CollectionSchema(
  name: r'PrayerTime',
  id: -2307682095520615532,
  properties: {
    r'asr': PropertySchema(
      id: 0,
      name: r'asr',
      type: IsarType.string,
    ),
    r'date': PropertySchema(
      id: 1,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'dateIndex': PropertySchema(
      id: 2,
      name: r'dateIndex',
      type: IsarType.dateTime,
    ),
    r'dhuhr': PropertySchema(
      id: 3,
      name: r'dhuhr',
      type: IsarType.string,
    ),
    r'fajr': PropertySchema(
      id: 4,
      name: r'fajr',
      type: IsarType.string,
    ),
    r'isha': PropertySchema(
      id: 5,
      name: r'isha',
      type: IsarType.string,
    ),
    r'lastUpdated': PropertySchema(
      id: 6,
      name: r'lastUpdated',
      type: IsarType.dateTime,
    ),
    r'location': PropertySchema(
      id: 7,
      name: r'location',
      type: IsarType.string,
    ),
    r'maghrib': PropertySchema(
      id: 8,
      name: r'maghrib',
      type: IsarType.string,
    ),
    r'sunrise': PropertySchema(
      id: 9,
      name: r'sunrise',
      type: IsarType.string,
    )
  },
  estimateSize: _prayerTimeEstimateSize,
  serialize: _prayerTimeSerialize,
  deserialize: _prayerTimeDeserialize,
  deserializeProp: _prayerTimeDeserializeProp,
  idName: r'id',
  indexes: {
    r'dateIndex': IndexSchema(
      id: 5202930406488400928,
      name: r'dateIndex',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'dateIndex',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _prayerTimeGetId,
  getLinks: _prayerTimeGetLinks,
  attach: _prayerTimeAttach,
  version: '3.1.0+1',
);

int _prayerTimeEstimateSize(
  PrayerTime object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.asr.length * 3;
  bytesCount += 3 + object.dhuhr.length * 3;
  bytesCount += 3 + object.fajr.length * 3;
  bytesCount += 3 + object.isha.length * 3;
  bytesCount += 3 + object.location.length * 3;
  bytesCount += 3 + object.maghrib.length * 3;
  bytesCount += 3 + object.sunrise.length * 3;
  return bytesCount;
}

void _prayerTimeSerialize(
  PrayerTime object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.asr);
  writer.writeDateTime(offsets[1], object.date);
  writer.writeDateTime(offsets[2], object.dateIndex);
  writer.writeString(offsets[3], object.dhuhr);
  writer.writeString(offsets[4], object.fajr);
  writer.writeString(offsets[5], object.isha);
  writer.writeDateTime(offsets[6], object.lastUpdated);
  writer.writeString(offsets[7], object.location);
  writer.writeString(offsets[8], object.maghrib);
  writer.writeString(offsets[9], object.sunrise);
}

PrayerTime _prayerTimeDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PrayerTime();
  object.asr = reader.readString(offsets[0]);
  object.date = reader.readDateTime(offsets[1]);
  object.dateIndex = reader.readDateTime(offsets[2]);
  object.dhuhr = reader.readString(offsets[3]);
  object.fajr = reader.readString(offsets[4]);
  object.id = id;
  object.isha = reader.readString(offsets[5]);
  object.lastUpdated = reader.readDateTime(offsets[6]);
  object.location = reader.readString(offsets[7]);
  object.maghrib = reader.readString(offsets[8]);
  object.sunrise = reader.readString(offsets[9]);
  return object;
}

P _prayerTimeDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readDateTime(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _prayerTimeGetId(PrayerTime object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _prayerTimeGetLinks(PrayerTime object) {
  return [];
}

void _prayerTimeAttach(IsarCollection<dynamic> col, Id id, PrayerTime object) {
  object.id = id;
}

extension PrayerTimeQueryWhereSort
    on QueryBuilder<PrayerTime, PrayerTime, QWhere> {
  QueryBuilder<PrayerTime, PrayerTime, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterWhere> anyDateIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'dateIndex'),
      );
    });
  }
}

extension PrayerTimeQueryWhere
    on QueryBuilder<PrayerTime, PrayerTime, QWhereClause> {
  QueryBuilder<PrayerTime, PrayerTime, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterWhereClause> dateIndexEqualTo(
      DateTime dateIndex) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'dateIndex',
        value: [dateIndex],
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterWhereClause> dateIndexNotEqualTo(
      DateTime dateIndex) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateIndex',
              lower: [],
              upper: [dateIndex],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateIndex',
              lower: [dateIndex],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateIndex',
              lower: [dateIndex],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateIndex',
              lower: [],
              upper: [dateIndex],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterWhereClause> dateIndexGreaterThan(
    DateTime dateIndex, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dateIndex',
        lower: [dateIndex],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterWhereClause> dateIndexLessThan(
    DateTime dateIndex, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dateIndex',
        lower: [],
        upper: [dateIndex],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterWhereClause> dateIndexBetween(
    DateTime lowerDateIndex,
    DateTime upperDateIndex, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dateIndex',
        lower: [lowerDateIndex],
        includeLower: includeLower,
        upper: [upperDateIndex],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PrayerTimeQueryFilter
    on QueryBuilder<PrayerTime, PrayerTime, QFilterCondition> {
  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> asrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'asr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> asrGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'asr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> asrLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'asr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> asrBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'asr',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> asrStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'asr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> asrEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'asr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> asrContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'asr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> asrMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'asr',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> asrIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'asr',
        value: '',
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> asrIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'asr',
        value: '',
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> dateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> dateIndexEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition>
      dateIndexGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> dateIndexLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> dateIndexBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> dhuhrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dhuhr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> dhuhrGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dhuhr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> dhuhrLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dhuhr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> dhuhrBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dhuhr',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> dhuhrStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dhuhr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> dhuhrEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dhuhr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> dhuhrContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dhuhr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> dhuhrMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dhuhr',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> dhuhrIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dhuhr',
        value: '',
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition>
      dhuhrIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dhuhr',
        value: '',
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> fajrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fajr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> fajrGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fajr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> fajrLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fajr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> fajrBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fajr',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> fajrStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fajr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> fajrEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fajr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> fajrContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fajr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> fajrMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fajr',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> fajrIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fajr',
        value: '',
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> fajrIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fajr',
        value: '',
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> ishaEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isha',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> ishaGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isha',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> ishaLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isha',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> ishaBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isha',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> ishaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'isha',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> ishaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'isha',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> ishaContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'isha',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> ishaMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'isha',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> ishaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isha',
        value: '',
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> ishaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'isha',
        value: '',
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition>
      lastUpdatedEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastUpdated',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition>
      lastUpdatedGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastUpdated',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition>
      lastUpdatedLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastUpdated',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition>
      lastUpdatedBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastUpdated',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> locationEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition>
      locationGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> locationLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> locationBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'location',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition>
      locationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> locationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> locationContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> locationMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'location',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition>
      locationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'location',
        value: '',
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition>
      locationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'location',
        value: '',
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> maghribEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maghrib',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition>
      maghribGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maghrib',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> maghribLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maghrib',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> maghribBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maghrib',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> maghribStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'maghrib',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> maghribEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'maghrib',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> maghribContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'maghrib',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> maghribMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'maghrib',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> maghribIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maghrib',
        value: '',
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition>
      maghribIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'maghrib',
        value: '',
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> sunriseEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sunrise',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition>
      sunriseGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sunrise',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> sunriseLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sunrise',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> sunriseBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sunrise',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> sunriseStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sunrise',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> sunriseEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sunrise',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> sunriseContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sunrise',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> sunriseMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sunrise',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition> sunriseIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sunrise',
        value: '',
      ));
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterFilterCondition>
      sunriseIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sunrise',
        value: '',
      ));
    });
  }
}

extension PrayerTimeQueryObject
    on QueryBuilder<PrayerTime, PrayerTime, QFilterCondition> {}

extension PrayerTimeQueryLinks
    on QueryBuilder<PrayerTime, PrayerTime, QFilterCondition> {}

extension PrayerTimeQuerySortBy
    on QueryBuilder<PrayerTime, PrayerTime, QSortBy> {
  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> sortByAsr() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'asr', Sort.asc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> sortByAsrDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'asr', Sort.desc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> sortByDateIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateIndex', Sort.asc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> sortByDateIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateIndex', Sort.desc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> sortByDhuhr() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dhuhr', Sort.asc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> sortByDhuhrDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dhuhr', Sort.desc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> sortByFajr() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fajr', Sort.asc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> sortByFajrDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fajr', Sort.desc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> sortByIsha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isha', Sort.asc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> sortByIshaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isha', Sort.desc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> sortByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.asc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> sortByLastUpdatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.desc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> sortByLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.asc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> sortByLocationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.desc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> sortByMaghrib() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maghrib', Sort.asc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> sortByMaghribDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maghrib', Sort.desc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> sortBySunrise() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sunrise', Sort.asc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> sortBySunriseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sunrise', Sort.desc);
    });
  }
}

extension PrayerTimeQuerySortThenBy
    on QueryBuilder<PrayerTime, PrayerTime, QSortThenBy> {
  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> thenByAsr() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'asr', Sort.asc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> thenByAsrDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'asr', Sort.desc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> thenByDateIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateIndex', Sort.asc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> thenByDateIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateIndex', Sort.desc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> thenByDhuhr() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dhuhr', Sort.asc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> thenByDhuhrDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dhuhr', Sort.desc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> thenByFajr() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fajr', Sort.asc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> thenByFajrDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fajr', Sort.desc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> thenByIsha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isha', Sort.asc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> thenByIshaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isha', Sort.desc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> thenByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.asc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> thenByLastUpdatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.desc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> thenByLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.asc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> thenByLocationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.desc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> thenByMaghrib() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maghrib', Sort.asc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> thenByMaghribDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maghrib', Sort.desc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> thenBySunrise() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sunrise', Sort.asc);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QAfterSortBy> thenBySunriseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sunrise', Sort.desc);
    });
  }
}

extension PrayerTimeQueryWhereDistinct
    on QueryBuilder<PrayerTime, PrayerTime, QDistinct> {
  QueryBuilder<PrayerTime, PrayerTime, QDistinct> distinctByAsr(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'asr', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QDistinct> distinctByDateIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateIndex');
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QDistinct> distinctByDhuhr(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dhuhr', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QDistinct> distinctByFajr(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fajr', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QDistinct> distinctByIsha(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isha', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QDistinct> distinctByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastUpdated');
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QDistinct> distinctByLocation(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'location', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QDistinct> distinctByMaghrib(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maghrib', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PrayerTime, PrayerTime, QDistinct> distinctBySunrise(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sunrise', caseSensitive: caseSensitive);
    });
  }
}

extension PrayerTimeQueryProperty
    on QueryBuilder<PrayerTime, PrayerTime, QQueryProperty> {
  QueryBuilder<PrayerTime, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PrayerTime, String, QQueryOperations> asrProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'asr');
    });
  }

  QueryBuilder<PrayerTime, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<PrayerTime, DateTime, QQueryOperations> dateIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateIndex');
    });
  }

  QueryBuilder<PrayerTime, String, QQueryOperations> dhuhrProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dhuhr');
    });
  }

  QueryBuilder<PrayerTime, String, QQueryOperations> fajrProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fajr');
    });
  }

  QueryBuilder<PrayerTime, String, QQueryOperations> ishaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isha');
    });
  }

  QueryBuilder<PrayerTime, DateTime, QQueryOperations> lastUpdatedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastUpdated');
    });
  }

  QueryBuilder<PrayerTime, String, QQueryOperations> locationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'location');
    });
  }

  QueryBuilder<PrayerTime, String, QQueryOperations> maghribProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maghrib');
    });
  }

  QueryBuilder<PrayerTime, String, QQueryOperations> sunriseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sunrise');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDailyDuaCollection on Isar {
  IsarCollection<DailyDua> get dailyDuas => this.collection();
}

const DailyDuaSchema = CollectionSchema(
  name: r'DailyDua',
  id: -7693617379649095353,
  properties: {
    r'date': PropertySchema(
      id: 0,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'duaId': PropertySchema(
      id: 1,
      name: r'duaId',
      type: IsarType.long,
    ),
    r'duaTitle': PropertySchema(
      id: 2,
      name: r'duaTitle',
      type: IsarType.string,
    ),
    r'isRead': PropertySchema(
      id: 3,
      name: r'isRead',
      type: IsarType.bool,
    )
  },
  estimateSize: _dailyDuaEstimateSize,
  serialize: _dailyDuaSerialize,
  deserialize: _dailyDuaDeserialize,
  deserializeProp: _dailyDuaDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _dailyDuaGetId,
  getLinks: _dailyDuaGetLinks,
  attach: _dailyDuaAttach,
  version: '3.1.0+1',
);

int _dailyDuaEstimateSize(
  DailyDua object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.duaTitle.length * 3;
  return bytesCount;
}

void _dailyDuaSerialize(
  DailyDua object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.date);
  writer.writeLong(offsets[1], object.duaId);
  writer.writeString(offsets[2], object.duaTitle);
  writer.writeBool(offsets[3], object.isRead);
}

DailyDua _dailyDuaDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DailyDua();
  object.date = reader.readDateTime(offsets[0]);
  object.duaId = reader.readLong(offsets[1]);
  object.duaTitle = reader.readString(offsets[2]);
  object.id = id;
  object.isRead = reader.readBool(offsets[3]);
  return object;
}

P _dailyDuaDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dailyDuaGetId(DailyDua object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _dailyDuaGetLinks(DailyDua object) {
  return [];
}

void _dailyDuaAttach(IsarCollection<dynamic> col, Id id, DailyDua object) {
  object.id = id;
}

extension DailyDuaQueryWhereSort on QueryBuilder<DailyDua, DailyDua, QWhere> {
  QueryBuilder<DailyDua, DailyDua, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DailyDuaQueryWhere on QueryBuilder<DailyDua, DailyDua, QWhereClause> {
  QueryBuilder<DailyDua, DailyDua, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DailyDuaQueryFilter
    on QueryBuilder<DailyDua, DailyDua, QFilterCondition> {
  QueryBuilder<DailyDua, DailyDua, QAfterFilterCondition> dateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterFilterCondition> dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterFilterCondition> dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterFilterCondition> dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterFilterCondition> duaIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'duaId',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterFilterCondition> duaIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'duaId',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterFilterCondition> duaIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'duaId',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterFilterCondition> duaIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'duaId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterFilterCondition> duaTitleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'duaTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterFilterCondition> duaTitleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'duaTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterFilterCondition> duaTitleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'duaTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterFilterCondition> duaTitleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'duaTitle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterFilterCondition> duaTitleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'duaTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterFilterCondition> duaTitleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'duaTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterFilterCondition> duaTitleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'duaTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterFilterCondition> duaTitleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'duaTitle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterFilterCondition> duaTitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'duaTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterFilterCondition> duaTitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'duaTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterFilterCondition> isReadEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isRead',
        value: value,
      ));
    });
  }
}

extension DailyDuaQueryObject
    on QueryBuilder<DailyDua, DailyDua, QFilterCondition> {}

extension DailyDuaQueryLinks
    on QueryBuilder<DailyDua, DailyDua, QFilterCondition> {}

extension DailyDuaQuerySortBy on QueryBuilder<DailyDua, DailyDua, QSortBy> {
  QueryBuilder<DailyDua, DailyDua, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterSortBy> sortByDuaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duaId', Sort.asc);
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterSortBy> sortByDuaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duaId', Sort.desc);
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterSortBy> sortByDuaTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duaTitle', Sort.asc);
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterSortBy> sortByDuaTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duaTitle', Sort.desc);
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterSortBy> sortByIsRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRead', Sort.asc);
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterSortBy> sortByIsReadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRead', Sort.desc);
    });
  }
}

extension DailyDuaQuerySortThenBy
    on QueryBuilder<DailyDua, DailyDua, QSortThenBy> {
  QueryBuilder<DailyDua, DailyDua, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterSortBy> thenByDuaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duaId', Sort.asc);
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterSortBy> thenByDuaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duaId', Sort.desc);
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterSortBy> thenByDuaTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duaTitle', Sort.asc);
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterSortBy> thenByDuaTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duaTitle', Sort.desc);
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterSortBy> thenByIsRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRead', Sort.asc);
    });
  }

  QueryBuilder<DailyDua, DailyDua, QAfterSortBy> thenByIsReadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRead', Sort.desc);
    });
  }
}

extension DailyDuaQueryWhereDistinct
    on QueryBuilder<DailyDua, DailyDua, QDistinct> {
  QueryBuilder<DailyDua, DailyDua, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<DailyDua, DailyDua, QDistinct> distinctByDuaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'duaId');
    });
  }

  QueryBuilder<DailyDua, DailyDua, QDistinct> distinctByDuaTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'duaTitle', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DailyDua, DailyDua, QDistinct> distinctByIsRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isRead');
    });
  }
}

extension DailyDuaQueryProperty
    on QueryBuilder<DailyDua, DailyDua, QQueryProperty> {
  QueryBuilder<DailyDua, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DailyDua, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<DailyDua, int, QQueryOperations> duaIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'duaId');
    });
  }

  QueryBuilder<DailyDua, String, QQueryOperations> duaTitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'duaTitle');
    });
  }

  QueryBuilder<DailyDua, bool, QQueryOperations> isReadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isRead');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAamaalCollection on Isar {
  IsarCollection<Aamaal> get aamaals => this.collection();
}

const AamaalSchema = CollectionSchema(
  name: r'Aamaal',
  id: 2912604475465912495,
  properties: {
    r'content': PropertySchema(
      id: 0,
      name: r'content',
      type: IsarType.string,
    ),
    r'contentArabic': PropertySchema(
      id: 1,
      name: r'contentArabic',
      type: IsarType.string,
    ),
    r'contentFarsi': PropertySchema(
      id: 2,
      name: r'contentFarsi',
      type: IsarType.string,
    ),
    r'contentUrdu': PropertySchema(
      id: 3,
      name: r'contentUrdu',
      type: IsarType.string,
    ),
    r'day': PropertySchema(
      id: 4,
      name: r'day',
      type: IsarType.long,
    ),
    r'description': PropertySchema(
      id: 5,
      name: r'description',
      type: IsarType.string,
    ),
    r'month': PropertySchema(
      id: 6,
      name: r'month',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 7,
      name: r'title',
      type: IsarType.string,
    ),
    r'titleArabic': PropertySchema(
      id: 8,
      name: r'titleArabic',
      type: IsarType.string,
    )
  },
  estimateSize: _aamaalEstimateSize,
  serialize: _aamaalSerialize,
  deserialize: _aamaalDeserialize,
  deserializeProp: _aamaalDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _aamaalGetId,
  getLinks: _aamaalGetLinks,
  attach: _aamaalAttach,
  version: '3.1.0+1',
);

int _aamaalEstimateSize(
  Aamaal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.content.length * 3;
  bytesCount += 3 + object.contentArabic.length * 3;
  {
    final value = object.contentFarsi;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.contentUrdu;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.description.length * 3;
  bytesCount += 3 + object.month.length * 3;
  bytesCount += 3 + object.title.length * 3;
  bytesCount += 3 + object.titleArabic.length * 3;
  return bytesCount;
}

void _aamaalSerialize(
  Aamaal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.content);
  writer.writeString(offsets[1], object.contentArabic);
  writer.writeString(offsets[2], object.contentFarsi);
  writer.writeString(offsets[3], object.contentUrdu);
  writer.writeLong(offsets[4], object.day);
  writer.writeString(offsets[5], object.description);
  writer.writeString(offsets[6], object.month);
  writer.writeString(offsets[7], object.title);
  writer.writeString(offsets[8], object.titleArabic);
}

Aamaal _aamaalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Aamaal();
  object.content = reader.readString(offsets[0]);
  object.contentArabic = reader.readString(offsets[1]);
  object.contentFarsi = reader.readStringOrNull(offsets[2]);
  object.contentUrdu = reader.readStringOrNull(offsets[3]);
  object.day = reader.readLong(offsets[4]);
  object.description = reader.readString(offsets[5]);
  object.id = id;
  object.month = reader.readString(offsets[6]);
  object.title = reader.readString(offsets[7]);
  object.titleArabic = reader.readString(offsets[8]);
  return object;
}

P _aamaalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _aamaalGetId(Aamaal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _aamaalGetLinks(Aamaal object) {
  return [];
}

void _aamaalAttach(IsarCollection<dynamic> col, Id id, Aamaal object) {
  object.id = id;
}

extension AamaalQueryWhereSort on QueryBuilder<Aamaal, Aamaal, QWhere> {
  QueryBuilder<Aamaal, Aamaal, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AamaalQueryWhere on QueryBuilder<Aamaal, Aamaal, QWhereClause> {
  QueryBuilder<Aamaal, Aamaal, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AamaalQueryFilter on QueryBuilder<Aamaal, Aamaal, QFilterCondition> {
  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'content',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'content',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'content',
        value: '',
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'content',
        value: '',
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentArabicEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentArabicGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contentArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentArabicLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contentArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentArabicBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contentArabic',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentArabicStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'contentArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentArabicEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'contentArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentArabicContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'contentArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentArabicMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'contentArabic',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentArabicIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentArabic',
        value: '',
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition>
      contentArabicIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contentArabic',
        value: '',
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentFarsiIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'contentFarsi',
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentFarsiIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'contentFarsi',
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentFarsiEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentFarsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentFarsiGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contentFarsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentFarsiLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contentFarsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentFarsiBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contentFarsi',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentFarsiStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'contentFarsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentFarsiEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'contentFarsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentFarsiContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'contentFarsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentFarsiMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'contentFarsi',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentFarsiIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentFarsi',
        value: '',
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentFarsiIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contentFarsi',
        value: '',
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentUrduIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'contentUrdu',
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentUrduIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'contentUrdu',
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentUrduEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentUrdu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentUrduGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contentUrdu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentUrduLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contentUrdu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentUrduBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contentUrdu',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentUrduStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'contentUrdu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentUrduEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'contentUrdu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentUrduContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'contentUrdu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentUrduMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'contentUrdu',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentUrduIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentUrdu',
        value: '',
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> contentUrduIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contentUrdu',
        value: '',
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> dayEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'day',
        value: value,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> dayGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'day',
        value: value,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> dayLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'day',
        value: value,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> dayBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'day',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> descriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> descriptionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> descriptionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> monthEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'month',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> monthGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'month',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> monthLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'month',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> monthBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'month',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> monthStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'month',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> monthEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'month',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> monthContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'month',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> monthMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'month',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> monthIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'month',
        value: '',
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> monthIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'month',
        value: '',
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> titleArabicEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'titleArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> titleArabicGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'titleArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> titleArabicLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'titleArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> titleArabicBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'titleArabic',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> titleArabicStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'titleArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> titleArabicEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'titleArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> titleArabicContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'titleArabic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> titleArabicMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'titleArabic',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> titleArabicIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'titleArabic',
        value: '',
      ));
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterFilterCondition> titleArabicIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'titleArabic',
        value: '',
      ));
    });
  }
}

extension AamaalQueryObject on QueryBuilder<Aamaal, Aamaal, QFilterCondition> {}

extension AamaalQueryLinks on QueryBuilder<Aamaal, Aamaal, QFilterCondition> {}

extension AamaalQuerySortBy on QueryBuilder<Aamaal, Aamaal, QSortBy> {
  QueryBuilder<Aamaal, Aamaal, QAfterSortBy> sortByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterSortBy> sortByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterSortBy> sortByContentArabic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentArabic', Sort.asc);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterSortBy> sortByContentArabicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentArabic', Sort.desc);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterSortBy> sortByContentFarsi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentFarsi', Sort.asc);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterSortBy> sortByContentFarsiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentFarsi', Sort.desc);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterSortBy> sortByContentUrdu() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentUrdu', Sort.asc);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterSortBy> sortByContentUrduDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentUrdu', Sort.desc);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterSortBy> sortByDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'day', Sort.asc);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterSortBy> sortByDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'day', Sort.desc);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterSortBy> sortByMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.asc);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterSortBy> sortByMonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.desc);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterSortBy> sortByTitleArabic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titleArabic', Sort.asc);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterSortBy> sortByTitleArabicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titleArabic', Sort.desc);
    });
  }
}

extension AamaalQuerySortThenBy on QueryBuilder<Aamaal, Aamaal, QSortThenBy> {
  QueryBuilder<Aamaal, Aamaal, QAfterSortBy> thenByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterSortBy> thenByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterSortBy> thenByContentArabic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentArabic', Sort.asc);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterSortBy> thenByContentArabicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentArabic', Sort.desc);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterSortBy> thenByContentFarsi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentFarsi', Sort.asc);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterSortBy> thenByContentFarsiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentFarsi', Sort.desc);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterSortBy> thenByContentUrdu() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentUrdu', Sort.asc);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterSortBy> thenByContentUrduDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentUrdu', Sort.desc);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterSortBy> thenByDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'day', Sort.asc);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterSortBy> thenByDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'day', Sort.desc);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterSortBy> thenByMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.asc);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterSortBy> thenByMonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.desc);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterSortBy> thenByTitleArabic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titleArabic', Sort.asc);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QAfterSortBy> thenByTitleArabicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titleArabic', Sort.desc);
    });
  }
}

extension AamaalQueryWhereDistinct on QueryBuilder<Aamaal, Aamaal, QDistinct> {
  QueryBuilder<Aamaal, Aamaal, QDistinct> distinctByContent(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'content', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QDistinct> distinctByContentArabic(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contentArabic',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QDistinct> distinctByContentFarsi(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contentFarsi', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QDistinct> distinctByContentUrdu(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contentUrdu', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QDistinct> distinctByDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'day');
    });
  }

  QueryBuilder<Aamaal, Aamaal, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QDistinct> distinctByMonth(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'month', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Aamaal, Aamaal, QDistinct> distinctByTitleArabic(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'titleArabic', caseSensitive: caseSensitive);
    });
  }
}

extension AamaalQueryProperty on QueryBuilder<Aamaal, Aamaal, QQueryProperty> {
  QueryBuilder<Aamaal, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Aamaal, String, QQueryOperations> contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'content');
    });
  }

  QueryBuilder<Aamaal, String, QQueryOperations> contentArabicProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contentArabic');
    });
  }

  QueryBuilder<Aamaal, String?, QQueryOperations> contentFarsiProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contentFarsi');
    });
  }

  QueryBuilder<Aamaal, String?, QQueryOperations> contentUrduProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contentUrdu');
    });
  }

  QueryBuilder<Aamaal, int, QQueryOperations> dayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'day');
    });
  }

  QueryBuilder<Aamaal, String, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<Aamaal, String, QQueryOperations> monthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'month');
    });
  }

  QueryBuilder<Aamaal, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<Aamaal, String, QQueryOperations> titleArabicProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'titleArabic');
    });
  }
}
