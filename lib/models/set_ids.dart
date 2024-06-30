// This is used to map endpoints for each set to a setID from the pokemonTCG Set
// API. This is because they break them up differently and where prices are 
// pulled from dont always match the same convention. 

enum SetId {
  base1,
  base2,
  basep,
  base3,
  base4,
  base5,
  gym1,
  gym2,
  neo1,
  neo2,
  si1,
  neo3,
  neo4,
  base6,
  ecard1,
  bp,
  ecard2,
  ecard3,
  ex1,
  ex2,
  np,
  ex3,
  ex4,
  ex5,
  tk1a,
  tk1b,
  ex6,
  pop1,
  ex7,
  ex8,
  ex9,
  ex10,
  pop2,
  ex11,
  ex12,
  tk2a,
  tk2b,
  pop3,
  ex13,
  ex14,
  pop4,
  ex15,
  ex16,
  pop5,
  dpp,
  dp1,
  dp2,
  pop6,
  dp3,
  dp4,
  pop7,
  dp5,
  dp6,
  pop8,
  dp7,
  pl1,
  pop9,
  pl2,
  pl3,
  pl4,
  ru1,
  hsp,
  hgss1,
  hgss2,
  hgss3,
  hgss4,
  col1,
  bwp,
  bw1,
  mcd11,
  bw2,
  bw3,
  bw4,
  bw5,
  mcd12,
  bw6,
  dv1,
  bw7,
  bw8,
  bw9,
  bw10,
  xyp,
  bw11,
  xy0,
  xy1,
  xy2,
  mcd14,
  xy3,
  xy4,
  xy5,
  dc1,
  xy6,
  xy7,
  xy8,
  mcd15,
  xy9,
  g1,
  xy10,
  xy11,
  mcd16,
  xy12,
  smp,
  sm1,
  sm2,
  sm3,
  sm35,
  sm4,
  mcd17,
  sm5,
  sm6,
  sm7,
  sm75,
  mcd18,
  sm8,
  sm9,
  det1,
  sm10,
  sm11,
  sma,
  sm115,
  mcd19,
  sm12,
  swshp,
  swsh1,
  swsh2,
  swsh3,
  fut20,
  swsh35,
  swsh4,
  mcd21,
  swsh45,
  swsh45sv,
  swsh5,
  swsh6,
  swsh7,
  cel25,
  cel25c,
  swsh8,
  swsh9,
  swsh9tg,
  swsh10,
  swsh10tg,
  pgo,
  mcd22,
  swsh11,
  swsh11tg,
  swsh12,
  swsh12tg,
  svp,
  swsh12pt5,
  swsh12pt5gg,
  sv1,
  sve,
  sv2,
  sv3,
  sv3pt5,
  sv4,
  sv4pt5,
  sv5,
  sv6,
}

extension SetBaseUrl on SetId {
  String get baseUrl {
    switch (this) {
      case SetId.base1:
        return 'base1/base/';
      case SetId.base2:
        return 'base2/jungle/';
      case SetId.basep:
        return 'basep/wizards-black-star-promos/';
      case SetId.base3:
        return 'base3/fossil/';
      case SetId.base4:
        return 'base4/base-set-2/';
      case SetId.base5:
        return 'base5/team-rocket/';
      case SetId.gym1:
        return 'gym1/gym-heroes/';
      case SetId.gym2:
        return 'gym2/gym-challenge/';
      case SetId.neo1:
        return 'neo1/neo-genesis/';
      case SetId.neo2:
        return 'neo2/neo-discovery/';
      case SetId.si1:
        return 'si1/southern-islands/';
      case SetId.neo3:
        return 'neo3/neo-revelation/';
      case SetId.neo4:
        return 'neo4/neo-destiny/';
      case SetId.base6:
        return 'base6/legendary-collection/';
      case SetId.ecard1:
        return 'ecard1/expedition-base-set/';
      case SetId.bp:
        return 'bog1/best-of-game-promos/';
      case SetId.ecard2:
        return 'ecard2/aquapolis/';
      case SetId.ecard3:
        return 'ecard3/skyridge/';
      case SetId.ex1:
        return 'ex1/ruby-sapphire/';
      case SetId.ex2:
        return 'ex2/sandstorm/';
      case SetId.np:
        return 'np/nintendo-black-star-promos/';
      case SetId.ex3:
        return 'ex3/dragon/';
      case SetId.ex4:
        return 'ex4/team-magma-vs-team-aqua/';
      case SetId.ex5:
        return 'ex5/hidden-legends/';
      case SetId.tk1a:
        return 'tk1/ex-trainer-kit-latias/';
      case SetId.tk1b:
        return 'tk2/ex-trainer-kit-latios/';
      case SetId.ex6:
        return 'ex6/firered-leafgreen/';
      case SetId.pop1:
        return 'pop1/pop-series-1/';
      case SetId.ex7:
        return 'ex7/team-rocket-returns/';
      case SetId.ex8:
        return 'ex8/deoxys/';
      case SetId.ex9:
        return 'ex9/emerald/';
      case SetId.ex10:
        return 'ex10/unseen-forces/';
      case SetId.pop2:
        return 'pop2/pop-series-2/';
      case SetId.ex11:
        return 'ex11/delta-species/';
      case SetId.ex12:
        return 'ex12/legend-maker/';
      case SetId.tk2a:
        return 'tk3/ex-trainer-kit-2-minun/';
      case SetId.tk2b:
        return 'tk4/ex-trainer-kit-2-plusle/';
      case SetId.pop3:
        return 'pop3/pop-series-3/';
      case SetId.ex13:
        return 'ex13/holon-phantoms/';
      case SetId.ex14:
        return 'ex14/crystal-guardians/';
      case SetId.pop4:
        return 'pop4/pop-series-4/';
      case SetId.ex15:
        return 'ex15/dragon-frontiers/';
      case SetId.ex16:
        return 'ex16/power-keepers/';
      case SetId.pop5:
        return 'pop5/pop-series-5/';
      case SetId.dpp:
        return 'dpp/dp-black-star-promos/';
      case SetId.dp1:
        return 'dp1/diamond-pearl/';
      case SetId.dp2:
        return 'dp2/mysterious-treasures/';
      case SetId.pop6:
        return 'pop6/pop-series-6/';
      case SetId.dp3:
        return 'dp3/secret-wonders/';
      case SetId.dp4:
        return 'dp4/great-encounters/';
      case SetId.pop7:
        return 'pop7/pop-series-7/';
      case SetId.dp5:
        return 'dp5/majestic-dawn/';
      case SetId.dp6:
        return 'dp6/legends-awakened/';
      case SetId.pop8:
        return 'pop8/pop-series-8/';
      case SetId.dp7:
        return 'dp7/stormfront/';
      case SetId.pl1:
        return 'pl1/platinum/';
      case SetId.pop9:
        return 'pop9/pop-series-9/';
      case SetId.pl2:
        return 'pl2/rising-rivals/';
      case SetId.pl3:
        return 'pl3/supreme-victors/';
      case SetId.pl4:
        return 'pl4/arceus/';
      case SetId.ru1:
        return 'ru1/pokemon-rumble/';
      case SetId.hsp:
        return 'hsp/hgss-black-star-promos/';
      case SetId.hgss1:
        return 'hgss1/heartgold-soulsilver/';
      case SetId.hgss2:
        return 'hgss2/hs-unleashed/';
      case SetId.hgss3:
        return 'hgss3/hs-undaunted/';
      case SetId.hgss4:
        return 'hgss4/hs-triumphant/';
      case SetId.col1:
        return 'col1/call-of-legends/';
      case SetId.bwp:
        return 'bwp/bw-black-star-promos/';
      case SetId.bw1:
        return 'bw1/black-white/';
      case SetId.mcd11:
        return 'mc11/mcdonalds-collection-2011/';
      case SetId.bw2:
        return 'bw2/emerging-powers/';
      case SetId.bw3:
        return 'bw3/noble-victories/';
      case SetId.bw4:
        return 'bw4/next-destinies/';
      case SetId.bw5:
        return 'bw5/dark-explorers/';
      case SetId.mcd12:
        return 'mc12/mcdonalds-collection-2012/';
      case SetId.bw6:
        return 'bw6/dragons-exalted/';
      case SetId.dv1:
        return 'dv1/dragon-vault/';
      case SetId.bw7:
        return 'bw7/boundaries-crossed/';
      case SetId.bw8:
        return 'bw8/plasma-storm/';
      case SetId.bw9:
        return 'bw9/plasma-freeze/';
      case SetId.bw10:
        return 'bw10/plasma-blast/';
      case SetId.xyp:
        return 'xyp/xy-black-star-promos/';
      case SetId.bw11:
        return 'bw11/legendary-treasures/';
      case SetId.xy0:
        return 'xy0/kalos-starter-set/';
      case SetId.xy1:
        return 'xy1/xy/';
      case SetId.xy2:
        return 'xy2/flashfire/';
      case SetId.mcd14:
        return 'mc14/mcdonalds-collection-2014/';
      case SetId.xy3:
        return 'xy3/furious-fists/';
      case SetId.xy4:
        return 'xy4/phantom-forces/';
      case SetId.xy5:
        return 'xy5/primal-clash/';
      case SetId.dc1:
        return 'dc1/double-crisis/';
      case SetId.xy6:
        return 'xy6/roaring-skies/';
      case SetId.xy7:
        return 'xy7/ancient-origins/';
      case SetId.xy8:
        return 'xy8/breakthrough/';
      case SetId.mcd15:
        return 'mc15/mcdonalds-collection-2015/';
      case SetId.xy9:
        return 'xy9/breakpoint/';
      case SetId.g1:
        return 'g1/generations/';
      case SetId.xy10:
        return 'xy10/fates-collide/';
      case SetId.xy11:
        return 'xy11/steam-siege/';
      case SetId.mcd16:
        return 'mc16/mcdonalds-collection-2016/';
      case SetId.xy12:
        return 'xy12/evolutions/';
      case SetId.smp:
        return 'smp/sm-black-star-promos/';
      case SetId.sm1:
        return 'sm1/sun-moon/';
      case SetId.sm2:
        return 'sm2/guardians-rising/';
      case SetId.sm3:
        return 'sm3/burning-shadows/';
      case SetId.sm35:
        return 'sm35/shining-legends/';
      case SetId.sm4:
        return 'sm4/crimson-invasion/';
      case SetId.mcd17:
        return 'mc17/mcdonalds-collection-2017/';
      case SetId.sm5:
        return 'sm5/ultra-prism/';
      case SetId.sm6:
        return 'sm6/forbidden-light/';
      case SetId.sm7:
        return 'sm7/celestial-storm/';
      case SetId.sm75:
        return 'sm75/dragon-majesty/';
      case SetId.mcd18:
        return 'mc18/mcdonalds-collection-2018/';
      case SetId.sm8:
        return 'sm8/lost-thunder/';
      case SetId.sm9:
        return 'sm9/team-up/';
      case SetId.det1:
        return 'det1/detective-pikachu/';
      case SetId.sm10:
        return 'sm10/unbroken-bonds/';
      case SetId.sm11:
        return 'sm11/unified-minds/';
      case SetId.sma:
        return 'sm115/hidden-fates/';
      case SetId.sm115:
        return 'sm115/hidden-fates/';
      case SetId.mcd19:
        return 'mc19/mcdonalds-collection-2019/';
      case SetId.sm12:
        return 'sm12/cosmic-eclipse/';
      case SetId.swshp:
        return 'swshp/sword-shield-black-star-promos/';
      case SetId.swsh1:
        return 'swsh1/sword-shield/';
      case SetId.swsh2:
        return 'swsh2/rebel-clash/';
      case SetId.swsh3:
        return 'swsh3/darkness-ablaze/';
      case SetId.fut20:
        return 'swsh34/pokemon-futsal-collection/';
      case SetId.swsh35:
        return 'swsh35/champions-path/';
      case SetId.swsh4:
        return 'swsh4/vivid-voltage/';
      case SetId.mcd21:
        return 'mc21/mcdonalds-25th-anniversary/';
      case SetId.swsh45:
        return 'swsh45/shining-fates/';
      case SetId.swsh45sv:
        return 'swsh45/shining-fates/';
      case SetId.swsh5:
        return 'swsh5/battle-styles/';
      case SetId.swsh6:
        return 'swsh6/chilling-reign/';
      case SetId.swsh7:
        return 'swsh7/evolving-skies/';
      case SetId.cel25:
        return 'cel25/celebrations/';
      case SetId.cel25c:
        return 'cel25c/celebrations-classic-collection/';
      case SetId.swsh8:
        return 'swsh8/fusion-strike/';
      case SetId.swsh9:
        return 'swsh9/brilliant-stars/';
      case SetId.swsh9tg:
        return 'swsh9/brilliant-stars/';
      case SetId.swsh10:
        return 'swsh10/astral-radiance/';
      case SetId.swsh10tg:
        return 'swsh10/astral-radiance/';
      case SetId.pgo:
        return 'swsh105/pokemon-go/';
      case SetId.mcd22:
        return 'mc22/mcdonalds-match-battle-collection-2022/';
      case SetId.swsh11:
        return 'swsh11/lost-origin/';
      case SetId.swsh11tg:
        return 'swsh11/lost-origin/';
      case SetId.swsh12:
        return 'swsh12/silver-tempest/';
      case SetId.swsh12tg:
        return 'swsh12/silver-tempest/';
      case SetId.svp:
        return 'svp/scarlet-violet-black-star-promos/';
      case SetId.swsh12pt5:
        return 'swsh13/crown-zenith/';
      case SetId.swsh12pt5gg:
        return 'swsh13/crown-zenith/';
      case SetId.sv1:
        return 'sv1/scarlet-violet/';
      case SetId.sve:
        return '';
      case SetId.sv2:
        return 'sv2/paldea-evolved/';
      case SetId.sv3:
        return 'sv3/obsidian-flames/';
      case SetId.sv3pt5:
        return 'sv3pt5/151/';
      case SetId.sv4:
        return 'sv4/paradox-rift/';
      case SetId.sv4pt5:
        return 'sv4pt5/paldean-fates/';
      case SetId.sv5:
        return 'sv5/temporal-forces/';
      case SetId.sv6:
        return 'sv6/twilight-masquerade/';
    }
  }
}
