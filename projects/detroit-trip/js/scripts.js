/* /-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\ */
/* |                                                                         | */
/* \ @@@@@@@@  @@@  @@@  @@@@@@@  @@@@@@@    @@@@@@   @@@@@@@   @@@ @@@      / */
/* - @@@@@@@@  @@@@ @@@  @@@@@@@  @@@@@@@@  @@@@@@@@  @@@@@@@@  @@@ @@@      - */
/* / @@!       @@!@!@@@    @@!    @@!  @@@  @@!  @@@  @@!  @@@  @@! !@@      \ */
/* | !@!       !@!!@!@!    !@!    !@!  @!@  !@!  @!@  !@!  @!@  !@! @!!      | */
/* \ @!!!:!    @!@ !!@!    @!!    @!@!!@!   @!@  !@!  @!@@!@!    !@!@!       / */
/* - !!!!!:    !@!  !!!    !!!    !!@!@!    !@!  !!!  !!@!!!      @!!!       - */
/* / !!:       !!:  !!!    !!:    !!: :!!   !!:  !!!  !!:         !!:        \ */
/* | :!:       :!:  !:!    :!:    :!:  !:!  :!:  !:!  :!:         :!:        | */
/* \  :: ::::   ::   ::     ::    ::   :::  ::::: ::   ::          ::        / */
/* - : :: ::   ::    :      :      :   : :   : :  :    :           :         - */
/* /                                                                         \ */
/* |                                                                         | */
/* \ @@@  @@@  @@@   @@@@@@   @@@@@@@    @@@@@@   @@@  @@@  @@@  @@@@@@@     / */
/* - @@@  @@@  @@@  @@@@@@@@  @@@@@@@@  @@@@@@@   @@@  @@@  @@@  @@@@@@@@    - */
/* / @@!  @@!  @@!  @@!  @@@  @@!  @@@  !@@       @@!  @@@  @@!  @@!  @@@    \ */
/* | !@!  !@!  !@!  !@!  @!@  !@!  @!@  !@!       !@!  @!@  !@!  !@!  @!@    | */
/* \ @!!  !!@  @!@  @!@  !@!  @!@!!@!   !!@@!!    @!@!@!@!  !!@  @!@@!@!     / */
/* - !@!  !!!  !@!  !@!  !!!  !!@!@!     !!@!!!   !!!@!!!!  !!!  !!@!!!      - */
/* / !!:  !!:  !!:  !!:  !!!  !!: :!!        !:!  !!:  !!!  !!:  !!:         \ */
/* | :!:  :!:  :!:  :!:  !:!  :!:  !:!      !:!   :!:  !:!  :!:  :!:         | */
/* \  :::: :: :::   ::::: ::  ::   :::  :::: ::   ::   :::   ::   ::         / */
/* -   :: :  : :     : :  :    :   : :  :: : :     :   : :  :     :          - */
/* /                                                                         \ */
/* |                                                                         | */
/* \-/|\-/|\-/|\-/|\-/|\-/|\-/|\-/|\-/|\-/|\-/|\-/|\-/|\-/|\-/|\-/|\-/|\-/|\-/ */

const towns = [
  "Jersey City",
  "Paterson",
  "Parsippany",
  "Morristown",
  "Stroudsburg",
  "Easton",
  "Allentown",
  "Reading",
  "Harrisburg",
  "Carlisle",
  "Chambersburg",
  "Hagerstown",
  "Greencastle",
  "Bedford",
  "Somerset",
  "Johnstown",
  "Altoona",
  "Clearfield",
  "DuBois",
  "Brookville",
  "Clarion",
  "Oil City",
  "Franklin",
  "Meadville",
  "Erie",
  "Ashtabula",
  "Mentor",
  "Cleveland",
  "Parma",
  "Elyria",
  "Lorain",
  "Sandusky",
  "Norwalk",
  "Mansfield",
  "Ashland",
  "Wooster",
  "Akron",
  "Cuyahoga Falls",
  "Medina",
  "Brunswick",
  "Strongsville",
  "Elyria",
  "Lorain",
  "Amherst",
  "Vermilion",
  "Huron",
  "Port Clinton",
  "Toledo",
  "Maumee",
  "Bowling Green",
  "Findlay",
  "Fostoria",
  "Tiffin",
  "Fremont",
  "Sandusky",
  "Bellevue",
  "Norwalk",
  "Monroe",
  "Temperance",
  "Ann Arbor",
  "Ypsilanti",
  "Canton",
  "Westland",
  "Livonia",
  "Dearborn",
];
const stuckDoing = [
  "waiting in the bathroom line",
  "looking for your lost friend",
  "trippin in a sketchy gas station bathroom",
  "changing a flat tire in the rain",
  "trippin in a never-ending traffic jam",
  "rerouting around a closed highway",
  "talking to a random guy who won't stop ranting about psytrance",
  "holding everyone's bags at the entrance",
  "arguing with security over a lost ticket",
  "searching for the car in a muddy field",
  "waiting for someone to finish changing outfits",
  "carrying a massive speaker up three flights of stairs",
  "trying to get signal to find the afters location",
  "defrosting your windshield at 4 AM",
  "waiting for the sketchy shuttle bus that never comes",
  "helping someone who lost their shoes",
  "untangling a mess of extension cords",
  "DJing an empty side room for six hours",
  "listening to a terrible opening set",
  "waiting for your phone to charge at a random outlet",
  "tracking down someone's lost wallet",
  "getting searched by security twice",
  "getting freaky in the van",
  "babysitting a friend having a meltdown",
  "explaining to the Uber driver where the secret location is",
  "pushing a car out of the mud",
  "waiting for the bathroom while someone does their makeup",
  "trying to convince someone not to climb the speaker stack",
  "trippin in line for overpriced water bottles",
  "trippin in a conversation with a DJ who only talks about gear",
  "helping someone find their hotel room at sunrise",
  "untangling LED wire lights",
  "getting wristbands for everyone at will call",
  "being the designated driver for the fifth time",
  "waiting for the headliner who's two hours late",
  "done trapped under a giant inflatable prop",
  "guarding the gear while everyone else dances",
  "waiting in the coat check line that never moves",
  "calming down a neighbor complaining about noise",
  "carrying crates of vinyl up stairs",
  "searching the venue for better sound",
  "waiting for the food truck to reopen",
  "trippin in a porta-potty that won't lock",
  "trying to charge your phone with a dying battery pack",
  "listening to the same song loop during a bad DJ transition",
  "untangling cables behind the booth",
  "waiting for a friend to stop hugging everyone",
  "driving someone to the ER for dehydration",
  "trying to find the secret entrance",
  "wandering the festival grounds at sunrise",
  "sharing a tent with a couple arguing",
  "waiting in line for showers that don't work",
  "negotiating set times with four other DJs",
  "explaining what techno is to someone's cousin",
  "rolling up a massive tangled tarp",
  "trippin in the backseat surrounded by camping gear",
  "trying to get reception to call an Uber",
  "finding someone who wandered off barefoot",
  "passing out earplugs to everyone who ain't trippin",
  "herding everyone to the next spot",
  "collecting bottles to get the deposit back",
  "waiting for the sun to come up to find your way out",
];
const tracks = [
  "house tracks",
  "ambient tracks",
  "Throbbing Gristle tracks",
  "crust punk tracks",
  "sounds of whales breeding",
  "some sick AF breaks",
  "Detroit techno bangers",
  "Berlin warehouse cuts",
  "acid house squelches",
  "deep dub techno journeys",
  "industrial noise loops",
  "field recordings of a haunted forest",
  "post-punk basslines",
  "gabber kick assaults",
  "microhouse minimalisms",
  "jungle rollers",
  "ethereal drone pieces",
  "binaural beats for mind melt",
  "Italo disco jams",
  "goth club classics",
  "trance build-ups that never drop",
  "recordings of the Beatles",
  "lo-fi hip hop beats for sketchy basements",
  "free jazz freakouts",
  "power electronics blasts",
  "synthwave outrun anthems",
  "IDM glitch experiments",
  "ambient ASMR whispers",
  "obscure hardcore dubplates",
  "cosmic disco grooves",
  "live modular wiggles",
  "noise wall textures",
  "foghorn bass rumbles",
  "alien contact recordings",
  "chopped & screwed edits",
  "field samples of distant raves",
  "bootleg disco re-edits",
  "bunker techno pounders",
  "mangled tape loops",
  "ritual drone mantras",
  "psytrance full-on spirals",
  "bad karaoke versions of classics",
  "night bus melancholy bangers",
  "emo synthpop power ballads",
  "post-industrial metal stabs",
  "witch house hexes",
  "underwater techno bubbles",
  "breakcore speed assaults",
  "drum machine workouts",
  "vinyl hiss interludes",
  "dub siren echoes",
  "glitched pop deconstructions",
  "slow-motion club edits",
  "DIY rave bootlegs",
  "booty bass shakers",
  "acid gabber meltdowns",
  "karaoke drone doomscapes",
  "AI-generated trance loops",
  "hardstyle kicks to the face",
  "haunted disco ball reflections",
  "graveyard shift dubplates",
  "dungeon synth incantations",
  "digital hardcore tantrums",
  "sludge techno slabs",
  "forest rave hoots and hollers",
  "meme-core bootlegs",
  "low-res chiptune glitches",
  "dystopian cityscape soundtracks",
  "dissociative drone layers",
  "hyperpop sugar rushes",
  "barrel fire dancehall cuts",
  "horror movie ambient stabs",
  "folk punk busker bangers",
  "DIY cassette hiss dreams",
  "warehouse breakbeat riots",
  "post-rock swell crescendos",
  "anti-club no wave jams",
  "post-trance ambient weepings",
  "scuzz punk rave-ups",
  "squelchy modular wiggles",
  "vaporwave mall echoes",
  "trap metal growls",
  "hardvapour bangers",
  "garage rock basement sweaters",
  "mutant electroclash yelps",
  "surf goth reverb walls",
  "cracklecore static textures",
  "shoegaze noise avalanches",
  "post-dubstep lullabies",
  "slow acid drip sessions",
  "industrial grime slams",
  "glam punk glitter bombs",
  "post-folk drone wanderings",
  "digital cumbia cassettes",
  "future garage tears",
  "sad boy cloud rap echoes",
  "wonky beat excursions",
  "vocaloid heartbreak karaoke samples",
  "broken ambient piano loops",
  "shamanic techno rituals",
  "fractured funk breakdowns",
  "speed metal synth rampages",
  "bubblegum bass freakouts",
  "old rave anthems",
  "bassline mutant wobblers",
  "triple-time footwork spirals",
  "spiritual jazz jams",
  "ritualistic jungle steps",
  "horrorcore trap nightmares",
  "mallsoft echo chambers",
  "cybergrind blast beats",
  "slowcore shoegaze mopes",
  "apocalypse folk dirges",
  "ritual noise incantations",
];
const cares = [
  "No one gives a shit",
  "Everyone is bored",
  "The three heads present are tripping balls",
  "Everyone was into it until you started doing that one dance move you pull",
  "The promoter fell asleep behind the booth",
  "The bartender turned off the speakers to put on their playlist instead",
  "Someone's dog is getting more attention than you",
  "They're only here because it's raining outside",
  "Everyone left to smoke and never came back",
  "The floor is sticky and so is your set",
  "Some guy just started blasting country on a Bluetooth speaker",
  "A fight broke out during your ambient set",
  "Someone's livestreaming you to zero viewers",
  "The subwoofer died and no one noticed",
  "The only fan you had is your mom, and even she left early",
  "Everyone's staring at their phones waiting for the next DJ",
  "The crowd is debating politics instead of listening",
  "Someone unplugged your gear to charge their vape",
  "One dude clapping ironically in the back",
  "A raccoon just walked in and stole the vibe",
  "You thought you were the opening DJ, but you're just at an empty park",
  "Someone dropped acid and decided to play bongo drums over you",
  "A heckler is requesting Nickelback",
  "Your USB stick just corrupted and nobody noticed",
  "Someone's telling you they 'liked your old stuff better'",
  "A drunk couple is having a breakup argument next to the booth",
  "Someone tripped over your cables and you lost audio",
  "A random birthday party took over the dancefloor",
  "Your opening track made the crowd disappear",
  "Someone is loudly ordering food instead of listening",
  "A random dog keeps barking on beat and stealing the show",
  "The lights turned on and no one noticed you were still playing",
  "A kid is selling glowsticks louder than your set",
  "The neighbor is blasting reggaeton and outplaying you",
  "Your laptop died and you just pretended it was an outro",
  "A drunk uncle requested 'Free Bird' ironically",
  "Everyone is asking when the real DJ shows up",
  "Someone gave you a tip to stop playing",
  "A couple is hooking up in the booth because they think it's a couch",
  "A guy is trying to sell mixtapes during your drop",
  "Someone tried to Venmo you to skip your set",
  "A random child wandered in and started crying",
  "A dog just peed on your record bag",
  "You got replaced by Spotify autoplay",
  "A drone flew in with a sign that says 'Stop Please'",
  "Your mom texted: 'Please come home'",
  "You turned around and the club is empty",
  "Someone thought you were the coat check",
  "A rat just ran across the mixer and did a better job",
  "You found out the speakers were off the whole time",
  "Someone started beatboxing over your ambient drone",
  "The only person nodding is actually asleep",
  "Your USB drive fell out mid-mix and no one flinched",
  "A random karaoke party just drowned you out",
  "A different street busker outside has a bigger crowd",
  "Someone asked you to DJ their mom's funeral next",
  "You overheard someone say 'Is this just one long song?'",
  "The only claps you hear are mosquitoes",
  "Your visuals glitched and the screens went blue",
  "Someone just requested silence",
  "A baby started crying and synced better than your beats",
  "Someone is loudly watching TikToks next to the booth",
  "The bouncer turned off the booth to test the fire alarm",
  "Your power strip caught fire and no one offered help",
  "A cat jumped on the decks and scratched better than you",
  "Someone brought a guitar and started busking your crowd",
  "Your FX pedal froze and loops one bad kick forever",
  "You realized halfway you were playing last week's recording",
  "Someone spilled beer on your patch cables and shorted the vibe",
  "A bird pooped on your modular case mid-set",
  "Someone shouted 'Play something good!' on repeat",
  "The crowd is just a group of lost tourists asking for directions",
  "Someone started knitting in front of the booth",
  "You blew a fuse and it got better without you",
  "Your kick drum got replaced by someone's ringtone",
  "A random drone flew by and did a light show instead",
  "Someone switched the projector to play Mario Kart instead",
  "Your own video visuals say 'Please stop'",
];

const goodVibes = [
  "Everyone was hyped and gave you energy",
  "The crowd was totally locked in and vibed out",
  "People danced so hard the floor bounced",
  "Your dance moves started a whole new trend",
  "The promoter grinned ear to ear behind the booth",
  "The bartender mixed drinks to the beat of your set",
  "Someone brought their dog and it became the party mascot",
  "Nobody cared about the rain... they came for the music",
  "Everyone left to grab friends to join the dancefloor",
  "The floor was packed and everyone moved as one",
  "Someone started singing along to your track and it was magic",
  "A spontaneous cypher broke out during your ambient set",
  "People livestreamed because it was THAT good",
  "The subwoofer dropped and the crowd went wild",
  "Even your mom was up front, losing it to your set",
  "Phones were in the air capturing epic moments",
  "The crowd shouted for an encore between tracks",
  "Applause rolled in from every corner of the room",
  "Even the raccoon outside grooved to your vibe",
  "It started as an empty park but you made it a party",
  "Bongo drums joined in for a perfect jam session",
  "Someone requested your best track and the place erupted",
  "You dropped a new tune and everyone noticed",
  "People told you it was your best set ever",
  "Couples fell in love right by the booth",
  "Your cables survived, and the crowd loved your live tweaking",
  "A birthday party joined in and made it wilder",
  "Your opening track filled the floor in seconds",
  "People shouted food orders because they didn't want to leave",
  "That time the dog barked on beat and everyone lost it",
  "Glowsticks were everywhere",
  "The neighbors blasted your mix from their windows",
  "Your laptop died, but you freestyled an epic outro",
  "People shouted encore requests for 'Free Bird' as a joke",
  "Everyone thought you were the headliner and wanted more",
  "Someone slipped you some more acid because they loved your sound",
  "People cozied up near the booth to feel closer to the energy",
  "Someone handed you a mixtape out of respect",
  "People Venmoed you for track IDs, not to skip you",
  "A random child danced so hard, it was adorable",
  "Spotify couldn't match you, you were the real DJ that night",
  "A drone flew by with a sign saying 'Crushed It!'",
  "Your mom texted: 'So proud of you!'",
  "You turned around and the club was still full at 4am",
  "People thought you were staff because you were THAT approachable",
  "Even the rat nodded to your beat",
  "The speakers were so loud the whole block partied",
  "Someone started beatboxing with your drone... collab vibes",
  "Everyone nodded and smiled, locked in",
  "Your USB fell out, but you kept the vibe going live",
  "A karaoke party joined in to back you up with vocals",
  "You had a bigger crowd than the street festival outside",
  "Someone wanted you to DJ their wedding next",
  "You overheard, 'I hope this set never ends!'",
  "Clapping was nonstop... you felt the love",
  "Your visuals blew minds, not screens",
  "Someone just requested 'More music!'",
  "Even the baby bounced to your beats",
  "People shared TikToks about how sick the night was",
  "The bouncer fist bumped you for raising the energy",
  "That moment when your power strip caught fire... ",
  "A cat chilled on the decks, not missing a beat",
  "Someone brought a guitar and jammed along in sync",
  "Your FX pedal glitched, but the crowd loved the loop",
  "You dropped a rare track and people lost their minds",
  "Someone spilled beer, but you turned it into a water party",
  "A bird flew in, circled, and landed to watch you play",
  "The crowd was so hyped they asked for directions to the afterparty",
  "Someone started knitting rave scarves for everyone",
  "You blew a fuse, but the singalong kept going",
  "Your kick drum got remixed by a phone, ringtone... perfect timing",
  "A drone did a light show as you dropped the bass",
  "That moment when the projector switched to Mario Kart... crowd went apeshit",
  "Your visuals flashed 'You're a legend!' in giant letters",
  "A random grandma started breakdancing and got a standing ovation",
  "Confetti cannons went off perfectly in sync with your drop",
  "You played a secret track and the whole room gasped",
  "Someone handed you a bouquet of glowsticks",
  "A parade joined in from the street, doubling your crowd",
  "A lost balloon floated down and everyone cheered for its journey",
  "The security guard was smiling and bobbing their head",
  "Your beat matched the heart rate of the crowd",
  "You got a thank you note on a napkin slid across the booth",
  "A group brought homemade banners with your name on them",
  "Someone crowd-surfed on an inflatable unicorn",
  "Every drink got toasted to your set",
  "The disco ball dropped right at your build-up",
  "The fog machine timed it so perfectly it looked like a magic trick",
  "A mystery fan handed you a cold drink at the perfect moment",
  "You played a throwback track and everyone sang along word for word",
  "A laser show started mid-set, surprise style",
  "You tossed a USB into the crowd and someone caught it like a bouquet",
  "A couple got engaged right after your best drop",
  "Your set made the power go out...  people cheered and kept chanting",
  "An old friend surprised you in the crowd and danced up front",
  "A record label scout was spotted grooving to your tracks",
  "A random dog wore sunglasses and danced",
  "Glow-in-the-dark bubbles filled the air",
  "You played a meme song and the whole floor went wild",
  "Someone painted your portrait during your set",
  "A pizza delivery arrived mid-song... everyone cheered",
  "Every selfie in the room had you in the background",
  "A stranger complimented your sneakers over the mic",
  "You sampled someone's laugh live and it became the drop",
  "A rainbow appeared right when you hit the euphoric breakdown",
  "People tossed hats in the air at your last track",
  "Even the sound techs danced behind the mixer",
  "You invented a new hand signal and the crowd copied it",
  "Someone threw flowers and you caught them without missing a beat",
  "The merch table sold out before you even finished playing",
  "You made friends with the opening act and now you're tour buddies",
  "Even the ice in drinks kept clinking perfectly on beat",
  "You looked up and the moon was shining straight through the window",
  "Your afterparty invite list filled up in minutes",
  "You got tagged in every story on Instagram that night",
  "Someone gave you a friendship bracelet mid-mix",
  "A couple did a surprise proposal in front of your booth",
  "You started a conga line that wrapped around the block",
  "People waved their shoes in the air for the last drop",
  "The catering staff danced while serving snacks",
  "A random parade float rolled in and joined the party",
  "The venue ran out of water because the crowd danced so hard",
  "Someone remixed your track live on their phone and played it back",
  "The power flickered and everyone cheered, thinking it was part of the show",
  "You crowd-surfed all the way back to your booth",
  "You got invited to an exclusive sunrise set after your show",
  "People painted their faces to match your visuals",
  "A fire dancer started spinning during your breakdown",
  "Someone started a limbo contest with your cables",
  "The janitor gave you a thumbs up on the way out",
  "You found your sticker on the bathroom mirror",
  "A bike gang rolled through and stayed for the whole set",
  "Someone set off fireworks outside right as your set ended",
  "The bartender created a drink named after your DJ name",
  "People started chanting your name between every track",
  "A drone dropped confetti from above the dancefloor",
  "You freestyled a whole new genre and everyone followed",
  "You got a standing ovation before you even finished",
  "A group in matching outfits did a flashmob to your music",
  "Your last track got requested three times in a row",
  "The local news did a story on the party because of you",
  "People high fived you on the way out, grinning",
  "Even the moon seemed to pulse with the bass",
  "Someone called you a legend as they left",
  "A street artist made a mural inspired by your set",
  "The sun came up just as your encore ended and people cheered",
];

const chickenKinds = [
  "fried chicken buckets",
  "honey butter chicken biscuits",
  "spicy chicken wings",
  "buffalo chicken tenders",
  "grilled chicken skewers",
  "chicken nuggets with dipping sauces",
  "popcorn chicken bites",
  "Korean fried chickens",
  "hot chicken sandwiches",
  "chicken and waffles",
  "crispy chicken drumsticks",
  "chicken katsu cutlets",
  "lemon pepper chicken wings",
  "sticky sweet soy chickens",
  "buttermilk fried chickens",
  "teriyaki chicken thighs",
  "BBQ chicken legs",
  "chicken feet dim sums",
  "chicken karaage bites",
  "garlic parmesan wings",
  "southern fried chicken breasts",
  "chicken lollipops",
  "chicken schnitzels",
  "habanero spiced wings",
  "chicken tikka skewers",
  "chicken parmesan sliders",
  "sweet chili chicken strips",
  "chicken popcorn balls",
  "chicken taquitos",
  "chicken tenders baskets",
  "spicy breaded chicken patties",
  "chicken drumettes",
  "orange chicken bites",
  "General Tso's chickens",
  "cajun fried chicken wings",
  "chicken gizzards fried",
  "chicken croquettes",
  "crispy chicken skin chips",
  "chicken mini sandwiches",
  "chicken meatballs",
  "chicken sausage bites",
  "crispy chicken tacos",
  "chicken dumplings fried",
  "chicken burrito bites",
  "roasted chicken quarters",
  "chicken cutlets with gravies",
  "chicken spring rolls",
  "Nashville hot chickens",
  "chicken sliders with pickles",
  "crispy chicken nuggets",
  "chicken schnitzel bites",
  "buffalo chicken poppers",
  "chicken breast tenders",
  "sesame chicken pieces",
  "chicken wings with ranches",
  "panko chicken strips",
  "chicken livers",
  "crispy chicken wraps",
  "chicken biscuit sandwiches",
  "garlic fried chickens",
  "spicy chipotle chickens",
  "buttermilk chicken fingers",
  "chicken tenders with honey mustards",
  "chicken and cheese taquitos",
  "crispy chicken burritos",
  "chicken empanadas",
  "boneless chicken bites",
  "buffalo chicken egg rolls",
  "sweet soy glazed chickens",
  "chicken schnitzel strips",
  "chicken kiev nuggets",
  "chicken satay skewers",
  "crispy chicken lollipops",
  "teriyaki chicken bites",
  "chicken quesadilla slices",
  "chicken strips baskets",
  "spicy chicken nuggets",
  "chicken sliders with slaws",
  "chicken tenders and fries",
  "double battered fried chickens",
  "hot honey chicken bites",
];
const scoredSlang = [
  "Bagged",
  "Snagged",
  "Copped",
  "Landed",
  "Hooked",
  "Nailed",
  "Secured",
  "Grabbed",
  "Pocketed",
  "Clinched",
  "Scooped",
  "Reeled",
  "Clocked",
  "Cashed",
  "Locked",
  "Snatched",
  "Nabbed",
  "Net",
  "Won",
  "Caught",
  "Hustled",
  "Banked",
  "Swiped",
  "Jackpot",
  "Hauled",
  "Claimed",
  "Plucked",
  "Stashed",
  "Scored",
  "Looted",
  "Pinned",
  "Swept",
  "Booked",
  "Busted",
  "Tapped",
  "Pulled",
  "Reeled",
  "Fetched",
  "Done Got",
  "Wrangled",
  "Zipped",
  "Grabbed",
  "Dibbed",
  "Hopped",
  "Lifted",
  "Cashed",
  "Popped",
  "Clutched",
];
const thingsNotToDo = [
  "tries to DJ in the van",
  "starts blasting gabber at sunrise",
  "pulls out a recorder and plays off-key",
  "starts an unsolicited group meditation",
  "turns on the bright overhead lights",
  "starts a heated political debate",
  "asks to borrow everyone's chargers at once",
  "tries to sell tickets to another party",
  "turns the speaker to max volume during a chill vibe",
  "starts freestyling aggressively",
  "opens a bag of chips really loudly",
  "starts vacuuming the tent area",
  "sprays deodorant in the middle of the cuddle puddle",
  "tries to fight someone over set times",
  "makes everyone do trust falls",
  "tries to play an unfinished SoundCloud demo",
  "starts preaching about cryptocurrency",
  "calls their ex on speakerphone",
  "starts playing country music out of nowhere",
  "begins reorganizing everyone's bags",
  "tries to fix the lights and kills the power",
  "tries to order food delivery to the forest",
  "does a loud, off beat drum circle",
  "asks for everyone's attention for a terrible joke",
  "starts filming everyone without asking",
  "tries to get a mosh pit going",
  "puts on a sad movie on a projector",
  "starts cooking something that smells awful",
  "plays with fire toys too close to the group",
  "starts ranting about the meaning of life for an hour",
  "turns the ambient set into a rave banger set mid track",
  "brags about how they could do it better",
  "starts passing around random pills",
  "tries to sell merch from their backpack",
  "unplugs the music to charge their phone",
  "starts chanting something no one understands",
  "tries to organize an impromptu talent show",
  "gets on the mic and won't give it back",
  "turns the smoke machine on full blast",
  "brings up old drama between people",
  "tries to crowd surf when no one wants to catch them",
  "tries to out yell the music with motivational speeches",
  "brings out a megaphone to hype the vibe but kills it",
  "starts throwing glow sticks at everyone's faces",
  "tries to teach a dance nobody wants to learn",
  "pulls out a guitar and plays Wonderwall",
  "tries to plug in an air fryer and blows the fuse",
  "asks everyone to quiet down for their acoustic set",
  "keeps asking, 'what's the WiFi password?'",
  "brings a karaoke machine and demands a singalong",
  "starts calling parents to check in... on speakerphone",
  "puts on an offensive standup comedy set",
  "crashes the DJ booth to 'fix the mix'",
  "starts spraying silly string over everyone's drinks",
  "cranks the AC so everyone freezes",
  "starts grilling fish inside the tent",
  "tries to negotiate the next party venue midmoment",
  "tries to swap the playlist for their own rap demo",
  "invites random outsiders into a private moment",
  "starts yelling conspiracy theories about aliens",
  "stands in the middle and starts live streaming everything",
  "starts critiquing everyone's dance moves",
  "tries to enforce weird new house rules",
  "asks everyone to help pack up early",
  "starts randomly unplugging lights for no reason",
  "starts a pushup contest no one asked for",
  "demands a group selfie every 5 minutes",
  "tries to auction off leftover snacks",
];

const awesomeSlang = [
  "Tight",
  "Tight",
  "Tight",
  "Tight",
  "Tight",
  "Tight",
  "Tight",
  "Tight",
  "Tight",
  "Tight",
  "Sick",
  "Dope",
  "Ill",
  "Fire",
  "Lit",
  "Rad",
  "Wicked",
  "Killer",
  "Gnarly",
  "Insane",
  "Mad",
  "Wild",
  "Next Level",
  "Bangin'",
  "Badass",
  "Fresh",
  "Solid",
  "Beast",
  "Epic",
  "Legendary",
  "Heavy",
  "Prime",
  "Choice",
  "Mint",
  "On Point",
  "Crazy Good",
  "Massive",
  "Clutch",
  "Hard",
  "Vicious",
  "Brutal",
  "Ace",
  "Off The Hook",
  "Bomb",
  "Sweet",
  "Savage",
  "Ripping",
  "Mega",
  "Monster",
  "Ridiculous",
  "Boss",
  "Unreal",
];

const badSlang = [
  "Whack",
  "Whack",
  "Whack",
  "Whack",
  "Whack",
  "Whack",
  "Bunk",
  "Fucked",
  "Shitty",
  "Lame",
  "Trash",
  "Garbage",
  "Weak",
  "Bogus",
  "Janky",
  "Busted",
  "Sus",
  "Corny",
  "Bootleg",
  "Sketchy",
  "Crusty",
  "Wack",
  "Dogshit",
  "Half Assed",
  "Raggedy",
  "Basic",
  "Cheesy",
  "Busted",
  "Rusty",
  "Fake",
  "Flaky",
  "Junk",
  "Soggy",
  "Nasty",
  "Busted Ass",
  "Shambles",
  "Fail",
  "Fail",
  "Fail",
  "Booty",
  "Doood",
  "No Good",
  "Trash",
];

let randomTownsMessage = "";
let randomStuckDoingMessage = "";
let randomScoreSlangMessage = "";
let randomChickenMessage = "";
let randomCaresMessage = "";
let randomTracksMessage = "";
let randomThingsNotToDoMessage = "";
let randomAwesomeSlangMessage = "";
let randomBadSlangMessage = "";
let randomGoodVibesMessage = "";
setInterval(() => {
  const townsIndex = Math.floor(Math.random() * towns.length);
  const stuckIndex = Math.floor(Math.random() * stuckDoing.length);
  const randomScoreSlang = Math.floor(Math.random() * scoredSlang.length);
  const randomChicken = Math.floor(Math.random() * chickenKinds.length);
  const randomCares = Math.floor(Math.random() * cares.length);
  const randomIndex = Math.floor(Math.random() * tracks.length);
  const notToDoIndex = Math.floor(Math.random() * thingsNotToDo.length);
  const awesomeSlangIndex = Math.floor(Math.random() * awesomeSlang.length);
  const badSlangIndex = Math.floor(Math.random() * badSlang.length);
  const goodVibesIndex = Math.floor(Math.random() * goodVibes.length);
  randomTownsMessage = towns[townsIndex];
  randomStuckDoingMessage = stuckDoing[stuckIndex];
  randomScoreSlangMessage = scoredSlang[randomScoreSlang];
  randomChickenMessage = chickenKinds[randomChicken];
  randomCaresMessage = cares[randomCares];
  randomTracksMessage = tracks[randomIndex];
  randomThingsNotToDoMessage = thingsNotToDo[notToDoIndex];
  randomAwesomeSlangMessage = awesomeSlang[awesomeSlangIndex];
  randomBadSlangMessage = badSlang[badSlangIndex];
  randomGoodVibesMessage = goodVibes[goodVibesIndex];
}, 1000); // 1000 milliseconds = 1 second

// character constructor
function Character(name) {
  this.name = name;
  this.health = 100;
  this.status = "Chillin";
  this.illness = [];
}
// wagon/inventory constructor
function Wagon() {
  this.food = 0;
  this.money = 500;
  this.days = 0;
  this.characters = [];
  this.bullets = 0;
  this.distance = 0;
  this.hunted = 0;
  this.completed = 0.01;
}

Character.prototype.healthBar = function () {
  var pairs = {
    Chillin: "#28a745",
    Lagging: "#f0ad4e",
    "Running on Fumes": "#d9534f",
    "Done (Just... Done)": "black",
  };
  $("#char1-health-bar").progressbar({ value: char1.health });
  $("#char1-health-bar .ui-widget-header")
    .css("background", pairs[char1.status])
    .css("border-color", pairs[char1.status]);
  $("#char2-health-bar").progressbar({ value: char2.health });
  $("#char2-health-bar .ui-widget-header")
    .css("background", pairs[char2.status])
    .css("border-color", pairs[char2.status]);
  $("#char3-health-bar").progressbar({ value: char3.health });
  $("#char3-health-bar .ui-widget-header")
    .css("background", pairs[char3.status])
    .css("border-color", pairs[char3.status]);
  $("#char4-health-bar").progressbar({ value: char4.health });
  $("#char4-health-bar .ui-widget-header")
    .css("background", pairs[char4.status])
    .css("border-color", pairs[char4.status]);
  $("#char5-health-bar").progressbar({ value: char5.health });
  $("#char5-health-bar .ui-widget-header")
    .css("background", pairs[char5.status])
    .css("border-color", pairs[char5.status]);
};

// illness generator
Character.prototype.illnessGenerator = function () {
  var num = Math.floor(Math.random() * Math.floor(80));
  if (num === 1 && this.illness.includes("Acid Crash") == false) {
    this.illness.push("Acid Crash");
    $(".ongoing-events").prepend(this.name + " hit an Acid Crash <br>");
  } else if (num === 2 && this.illness.includes("Rave Anxiety") == false) {
    this.illness.push("Rave Anxiety");
    $(".ongoing-events").prepend(this.name + " is suffering Rave Anxiety <br>");
  } else if (num === 3 && this.illness.includes("Party Regret") == false) {
    this.illness.push("Party Regret");
    $(".ongoing-events").prepend(
      this.name + " is overcome with Party Regret <br>"
    );
  } else if (num === 4 && this.illness.includes("CDJ Rage") == false) {
    this.illness.push("CDJ Rage");
    $(".ongoing-events").prepend(this.name + " is experiencing CDJ Rage <br>");
  } else if (num === 5 && this.illness.includes("Insta Fatigue") == false) {
    this.illness.push("Insta Fatigue");
    $(".ongoing-events").prepend(this.name + " got Insta Fatigue <br>");
  }
};

//food checker
Wagon.prototype.resourceChecker = function () {
  if (this.food <= 0) {
    this.food = 0;
    wagon.characters.forEach(function (char) {
      char.health -= 10;
    });
  }
  if (this.bullet <= 0) {
    this.bullet = 0;
  }
};

//Checks for illness, status changes, and character death
Wagon.prototype.statusAdjuster = function () {
  wagon.characters.forEach(function (char) {
    if (char.illness.length === 1) {
      char.health -= 2;
    } else if (char.illness.length === 2) {
      char.health -= 4;
    } else if (char.illness.length >= 3) {
      char.health -= 6;
    }

    if (char.health >= 80) {
      char.status = "Chillin";
    } else if (char.health < 80 && char.health >= 20) {
      char.status = "Lagging";
    } else if (char.health < 20 && char.health > 0) {
      char.status = "Running on Fumes";
    } else {
      char.status = "Done (Just... Done)";
    }
    char.healthBar();

    if (char.health <= 0) {
      var index = wagon.characters.indexOf(char);
      wagon.characters.splice(index, 1);
      char.status = "Done (Just... Done)";
    }
  });
  if (wagon.characters.length === 0) {
    buildEndModal("dead", "death", "That trip sucked");
    $(".button-content").prepend("Yall got too wasted on the way to the rave.");
    $("#myModal").toggle();
  }
};

//calculates potential illnesses
Wagon.prototype.turn = function () {
  this.hunted = 0;
  wagon.eventGrabber();
  wagon.characters.forEach(function (char) {
    char.illnessGenerator();
  });
  wagon.statusAdjuster();
  if (wagon.food > 0) {
    wagon.food -= wagon.characters.length * 5;
  } else if (wagon.food <= 0) {
    wagon.food = 0;
  }
  this.days += 1;
  this.distance += 10;
  landmarkEvent();
  this.completed = this.completed + 2;
  journey(this.completed);
  wagon.resourceChecker();
};

function journey(dist) {
  $("#progressbar").progressbar({
    value: dist,
  });
}

// function for resting -- cure illness, gain some health
Wagon.prototype.rest = function () {
  wagon.characters.forEach(function (char) {
    char.illness.splice(0, 1);
    if (char.health < 99) {
      char.health += 2;
    }
  });
  wagon.statusAdjuster();
  wagon.food -= wagon.characters.length * 5;
  this.days += 1;
  wagon.resourceChecker();
};

//event grabber
Wagon.prototype.eventGrabber = function () {
  var num = Math.floor(Math.random() * Math.floor(100));
  if (
    this.distance === 100 ||
    this.distance === 200 ||
    this.distance === 300 ||
    this.distance === 400 ||
    this.distance === 500
  ) {
  } else if (num >= 80) {
    positiveEvent();
    //call positive event
  } else if (num < 80 && num >= 60) {
    neutralEvent();
    //call neutral event
  } else if (num < 60 && num >= 40) {
    negativeEvent();
    //call negative event
  } else if (num < 40 && num >= 35) {
    deathEvent();
    //call death event
  }
};

//random positiveEvent
function positiveEvent() {
  var num = Math.floor(Math.random() * Math.floor(6));
  var ranSupplyIncrease = Math.floor(Math.random() * (200 - 100) + 100);
  if (num === 1) {
    $(".ongoing-events").prepend(
      "At a rest stop, you miraculously find " +
        ranSupplyIncrease +
        ` ${randomChickenMessage} in an abandoned fanny pack. ${randomAwesomeSlangMessage}. <br>`
    );
    wagon.money += ranSupplyIncrease;
    $(".wagon-money-remaining").text(wagon.money.toFixed(2));
  } else if (num === 2) {
    $(".ongoing-events").prepend(
      `You discover a hidden crate of ${randomChickenMessage} behind the van's busted speaker, ` +
        ranSupplyIncrease +
        ` nuggets restored. ${randomAwesomeSlangMessage}. <br>`
    );
    wagon.food += ranSupplyIncrease;
    $(".wagon-food-remaining").text(wagon.food.toFixed(2));
  } else if (num === 3) {
    $(".ongoing-events").prepend(
      "Someone's cousin texts a working discount code for gas. You figure out a Raspberry Pi hack that converts the code into Bitcoins. Pumped, you stop at a gas station to buy snacks with the crypto gains, resulting in " +
        ranSupplyIncrease +
        ` more ${randomChickenMessage} in your bucket. ${randomAwesomeSlangMessage}. <br>`
    );
    wagon.food += ranSupplyIncrease;
    $(".wagon-food-remaining").text(wagon.food.toFixed(2));
  } else if (num === 4) {
    $(".ongoing-events").prepend(
      "You run into a micro-festival at a truck stop: free snacks, and the old-school head gets to rant about 'real underground'. Then you find " +
        ranSupplyIncrease +
        ` ${randomChickenMessage} hidden behind a toilet. ${randomAwesomeSlangMessage}! <br>`
    );
    wagon.money += ranSupplyIncrease;
    $(".wagon-money-remaining").text(wagon.money.toFixed(2));
  } else if (num === 5) {
    $(".ongoing-events").prepend(
      "You barter three coney dogs for a USB full of unreleased tracks along with some nuggets. The DJ is suspicious but also intrigued. <br> You got " +
        ranSupplyIncrease +
        ` ${randomChickenMessage} and ` +
        ranSupplyIncrease / 2 +
        ` crypto tokens. ${randomAwesomeSlangMessage}. <br>`
    );
    wagon.money += ranSupplyIncrease / 2;
    wagon.food += ranSupplyIncrease;
    $(".wagon-money-remaining").text(wagon.money.toFixed(2));
    $(".wagon-food-remaining").text(wagon.food.toFixed(2));
  } else if (num === 6) {
    $(".ongoing-events").prepend(
      "Under the driver seat, " +
        wagon.characters[index].name +
        "finds a rare Front 242 lazerdisc and " +
        ranSupplyIncrease +
        ` ${randomChickenMessage} from the day before. ${randomAwesomeSlangMessage}. <br>`
    );
    wagon.money += ranSupplyIncrease;
    $(".wagon-money-remaining").text(wagon.money.toFixed(2));
  }
}
//random neutralEvent
function neutralEvent() {
  var num = Math.floor(Math.random() * Math.floor(6));
  if (num === 0) {
    $(".ongoing-events").prepend(
      `The van's GPS reroutes you through four extra tolls in ${randomTownsMessage}. Nobody notices tho. <br>`
    );
  } else if (num === 1) {
    $(".ongoing-events").prepend(
      "An X post goes minor-viral. Nobody gains followers, and everyone argues about the hashtags. <br>"
    );
  } else if (num === 2) {
    $(".ongoing-events").prepend(
      `The Influencer insists you detour thru ${randomTownsMessage} for the perfect selfie spot. Three hours and one dead phone battery later, you're back on I-80. <br>`
    );
  } else if (num === 3) {
    $(".ongoing-events").prepend(
      `A 'pop-up rave' in a ${randomTownsMessage} rest stop ends with a polite but firm talk from a mall cop. But he ended up smoking us out. ${randomAwesomeSlangMessage}. <br>`
    );
  } else if (num === 4) {
    $(".ongoing-events").prepend(
      `Someone ${randomThingsNotToDoMessage} but everyone is trippin too hard. The result: a four hour existential debate about vibe etiquette, timing, and friendship. <br>`
    );
  } else if (num === 5) {
    $(".ongoing-events").prepend(
      "The van is starting to stank like feet again. <br>"
    );
  }
}
//random negativeEvent
function negativeEvent() {
  var num = Math.floor(Math.random() * Math.floor(6));
  var ranSupplyDecrease = Math.floor(Math.random() * (200 - 100) + 100);
  var index = Math.floor(Math.random() * Math.floor(wagon.characters.length));
  if (num === 1) {
    $(".ongoing-events").prepend(
      `Flat tire in ${randomTownsMessage}. 12 hours lost ${randomStuckDoingMessage}. <br>` +
        wagon.characters[index].name +
        " is over it. <br>"
    );
    wagon.characters[index].health -= 10;
  } else if (
    num === 2 &&
    wagon.characters[index].illness.includes("Rave Anxiety") == false
  ) {
    $(".ongoing-events").prepend(
      `Meal break in ${randomTownsMessage}: discover you've eaten only gas station taquitos and Tic Tacs. Wasted too much time ${randomStuckDoingMessage}. Quietly, ` +
        wagon.characters[index].name +
        " is having a moment, and " +
        wagon.characters[index + 1].name +
        " has Rave Anxiety.<br>"
    );
    wagon.characters[index].illness.push("Rave Anxiety");
  } else if (num === 3) {
    $(".ongoing-events").prepend(
      `${randomTownsMessage}. Hope is lost. Stuck ${randomStuckDoingMessage} and the DJ insists on playing a 40-minute modular set. The rest of the crew tries hitchhiking home and a cop takes ` +
        ranSupplyDecrease +
        " of your nuggets for himself and his own crew. <br>"
    );
    wagon.food -= ranSupplyDecrease;
    wagon.days += index;
    $(".wagon-food-remaining").text(wagon.food.toFixed(2));
  } else if (num === 4) {
    $(".ongoing-events").prepend(
      `Van breaks down outside ${randomTownsMessage}. A crowdfunding campaign raises no crypto. Posse considers trading the VR headset for a tow. 9 hours held-up ${randomStuckDoingMessage}. Was fucked. <br>`
    );
    wagon.days += 5;
    wagon.food -= wagon.characters.length * 5 * 5;
    document.getElementById("jesusSnatch").play();
    $("#wheel-1").fadeIn(500);
    $("#wheel-2").delay(300).fadeIn(500);
    $("#wheel-1").fadeOut(500);
    $("#wheel-3").delay(400).fadeIn(500);
    $("#wheel-2").fadeOut(500);
    $("#wheel-4").delay(500).fadeIn(500);
    $("#wheel-3").fadeOut(500);
    $("#wheel-5").delay(600).fadeIn(500);
    $("#wheel-4").fadeOut(500);
    $("#wheel-6").delay(700).fadeIn(500);
    $("#wheel-5").fadeOut(500);
    $("#jesus").delay(1100).fadeIn(100);
    $("#wheel-6").slideUp(5000).fadeOut(500);
    $("#jesus").slideUp(5000).fadeOut(500);
    $("#star").delay(5250).fadeIn("puff").fadeOut();
  } else if (num === 5) {
    $(".ongoing-events").prepend(
      `Passing thru ${randomTownsMessage} you realize all your chargers are USB-C. Thats whack cuz everyone else has Lightning ones. Arguments ensue. Then a Red Bull gets knocked over into the bucket of chicken. ` +
        ranSupplyDecrease +
        " of the nuggets rot and " +
        wagon.characters[index].name +
        ` gets super fucken pissed. ${randomBadSlangMessage}. <br>`
    );
    wagon.food -= ranSupplyDecrease;
    $(".wagon-food-remaining").text(wagon.food.toFixed(2));
  } else if (num === 6) {
    $(".ongoing-events").prepend(
      `You realize you left two USB sticks in the CDJs at the last stop. ${randomBadSlangMessage}! The van comes to a screetching halt as ` +
        ranSupplyDecrease +
        ` nuggets tumble out of the bucket and onto the floor. ` +
        wagon.characters[index].name +
        ` keeps repeating they are 'tripping balls rn' but everyone keeps quietly to themselves. ${randomBadSlangMessage}. <br>`
    );
    wagon.food -= ranSupplyDecrease;
    $(".wagon-food-remaining").text(wagon.food.toFixed(2));
  }
}
//landmarkEvent for distance traveled

function storeModal() {
  $(".modal-child").html(
    '<div id="popup-text"><h2>Gear list</h2><span id="wagon-food-remaining"></span></div>' +
      wagon.money.toFixed(2) +
      '<span id="back-button" class="btn btn-danger">Bail</span></div>'
  );
}

function buildModal(value) {
  $(".modal-child").html(
    '<div id="popup-text" class="ongoing-events">' +
      "</div>" +
      '<img src="img/' +
      value +
      '.jpg" alt="an image">'
  );
}

function buildEndModal(value, btnID1, btn1Name) {
  $(".modal-child").html(
    '<img src="img/' +
      value +
      '.jpg" alt="an image">' +
      '<div id="popup-text" class="button-content">' +
      '<div class="buttons">' +
      '<span id="' +
      btnID1 +
      'Button" class="btn btn-success">' +
      btn1Name +
      "</span>" +
      "</div>" +
      "</div>"
  );
}

function buildLandmarkModal(value, btnID1, btnID2, btn1Name, btn2Name) {
  $(".modal-child").html(
    '<div id="popup-text" class="button-content">' +
      '<div class="buttons">' +
      '<span id="' +
      btnID1 +
      'Button" class="btn btn-success">' +
      btn1Name +
      '</span> <span id="' +
      btnID2 +
      'Button" class="btn btn-success">' +
      btn2Name +
      "</span>" +
      "</div>" +
      "</div>" +
      '<img src="img/' +
      value +
      '.jpg" alt="an image">'
  );
}

Wagon.prototype.buildScore = function () {
  var finalScore = 10000;
  finalScore -=
    (this.days - 50) * 20 +
    (5 - this.characters.length) * 2000 -
    this.food * 0.2 -
    this.money * 0.3 -
    this.bullets * 0.1;
  return finalScore.toFixed();
};
//Push text to class .button-content
//Option 1 button - id #option1-button
//Option 2 button - id #option2-button
function landmarkEvent() {
  var num = wagon.distance;
  if (num === 50) {
    buildLandmarkModal(
      num,
      "sacrifice",
      "flee",
      "Lets trip and eat chicken burgers",
      "Nope"
    );
    $(".button-content").prepend(
      `While ${randomStuckDoingMessage}, we stumbled upon this sick AF camp spot in ${randomTownsMessage}. ${randomAwesomeSlangMessage}. Should we stay? <br>`
    );
    $("#buttonModal").toggle();
  } else if (num === 100) {
    buildLandmarkModal(num, "crossRiver", "detourRiver", "Jersey", "Scenery");
    $(".button-content").prepend(
      "You've reached the Jersey Turnpike. Do you risk cutting through Newark for speed, or take the scenic route? <br>"
    );
    $("#buttonModal").toggle();
  } else if (num === 150) {
    buildLandmarkModal(
      num,
      "sacrifice",
      "flee",
      "Lets trip and eat chicken burgers",
      "Nope"
    );
    $(".button-content").prepend(
      `While ${randomStuckDoingMessage}, we stumbled upon this sick AF camp spot in ${randomTownsMessage}. ${randomAwesomeSlangMessage}. Should we stay? <br>`
    );
    $("#buttonModal").toggle();
  } else if (num === 200) {
    buildModal("campStore");
    $(".ongoing-events").prepend(
      `Pop-up record shop ahead! Mandatory stop for rare vinyl and nuggets. ${randomAwesomeSlangMessage}. <br>`
    );
    $("#myModal").toggle();
    $("#gameMainScreen").fadeOut(500);
    $("#store").delay(500).fadeIn(500);
    $("#back-button").hide();
  } else if (num === 250) {
    buildLandmarkModal(
      num,
      "sacrifice",
      "flee",
      "Lets trip and eat chicken burgers",
      "Nope"
    );
    $(".button-content").prepend(
      `While ${randomStuckDoingMessage}, we stumbled upon this sick AF camp spot in ${randomTownsMessage}. ${randomAwesomeSlangMessage}. Should we stay? <br>`
    );
    $("#buttonModal").toggle();
  } else if (num === 300) {
    buildLandmarkModal(
      num,
      "sacrifice",
      "flee",
      "Trip and listen to house",
      "Bail"
    );
    $(".button-content").prepend(
      `${randomTownsMessage}: Cell service drops and we ${randomStuckDoingMessage}. ${randomBadSlangMessage}. The DJ insists on listening to Chicago house classics, but they been trippin all day complaining about seeing fractals so WTF do we do? <br>`
    );
    $("#buttonModal").toggle();
  } else if (num === 350) {
    buildLandmarkModal(
      num,
      "sacrifice",
      "flee",
      "Lets trip and eat chicken burgers",
      "Nope"
    );
    $(".button-content").prepend(
      `While ${randomStuckDoingMessage} in ${randomTownsMessage} we stumbled upon this sick AF camp spot. ${randomAwesomeSlangMessage}. Should we stay? <br>`
    );
    $("#buttonModal").toggle();
  } else if (num === 400) {
    buildModal("generalStore");
    $(".ongoing-events").prepend(
      `Stumbled on this burner store. ${randomAwesomeSlangMessage}! Entry fee: 1 fake wristband. We stop for more FLAC files. <br>`
    );
    $("#myModal").toggle();
    $("#gameMainScreen").fadeOut(500);
    $("#store").delay(500).fadeIn(500);
    $("#back-button").hide();
  } else if (num === 450) {
    buildLandmarkModal(
      num,
      "sacrifice",
      "flee",
      "Lets trip and eat chicken burgers",
      "Nope"
    );
    $(".button-content").prepend(
      `While ${randomStuckDoingMessage} in ${randomTownsMessage} stumbled upon sick AF camp spot. ${randomAwesomeSlangMessage}. Should we stay? <br>`
    );
    $("#buttonModal").toggle();
  } else if (num === 500) {
    buildEndModal(num, "win", "Play Again");
    var endScore = wagon.buildScore();
    $(".button-content").prepend(
      "<h4>DETROIT</h4>You made it to the rave! That shit was hella tight and hella sick. Your score is: " +
        endScore
    );
    $("#buttonModal").addClass("confetti");
    $("#buttonModal").toggle();
  }
}
//landmark 1 button events
function detourRiver() {
  for (i = 0; i < 8; i++) {
    wagon.days += 1;
    wagon.food -= wagon.characters.length * 5;
    wagon.resourceChecker();
    wagon.statusAdjuster();
  }
  $(".ongoing-events").prepend(
    "You spent seven days taking the safe route. More time, but fewer regrets. <br>"
  );
  wagon.statusAdjuster();
}
function crossRiver() {
  var num = Math.floor(Math.random() * Math.floor(100));
  var index = Math.floor(Math.random() * Math.floor(wagon.characters.length));
  if (num > 50) {
    wagon.characters[index].health -= 30;
    wagon.food -= wagon.food * 0.4;
    wagon.money -= wagon.money * 0.2;
    buildModal("riverFail");
    $(".ongoing-events").prepend(
      "Van breaks down after a bold shortcut. " +
        wagon.characters[index].name +
        " has to negotiate with some Phish fans about DJ mixes and DAWless setups. You chill with them and set up a sick camp, but they end up demanding shit for wasted time. You give up " +
        (wagon.food * 0.4).toFixed(0) +
        " chicken and " +
        (wagon.money * 0.2).toFixed(0) +
        ` crypto tokens. ${randomBadSlangMessage}. <br>`
    );
    $("#myModal").toggle();
    for (i = 0; i < 4; i++) {
      wagon.statusAdjuster();
      wagon.days += 1;
      wagon.food -= wagon.characters.length * 5;
    }
  } else {
    buildModal("riverWin");
    $(".ongoing-events").prepend(
      "Shortcut pays off! Skipped hours of traffic and set up camp near a rest-stop. <br>"
    );
    $("#myModal").toggle();
    wagon.days += 1;
    wagon.food -= wagon.characters.length * 5;
  }

  wagon.resourceChecker();
  wagon.statusAdjuster();
}
// landmark 3 button events
function sacrifice() {
  var index = Math.floor(Math.random() * Math.floor(wagon.characters.length));
  wagon.characters[index].health = 0;
  $(".ongoing-events").prepend(
    wagon.characters[index].name +
      " gets lost in an existential crisis. The rest of your crew powers thru. <br>"
  );
  wagon.statusAdjuster();
}
function flee() {
  var num = Math.floor(Math.random() * Math.floor(100));
  var index = Math.floor(Math.random() * Math.floor(wagon.characters.length));
  if (num > 50) {
    wagon.characters[index].health = 0;
    buildModal("fleeFail");
    $(".ongoing-events").prepend(
      wagon.characters[index].name + ` bailed. ${randomBadSlangMessage}. <br>`
    );
    $("#myModal").toggle();
    wagon.statusAdjuster();
    wagon.days += 1;
    wagon.food -= wagon.characters.length * 5;
  } else {
    $(".ongoing-events").prepend("Everyone was very lucky this time. <br>");
    wagon.days += 1;
    wagon.food -= wagon.characters.length * 5;
  }
  wagon.statusAdjuster();
  wagon.resourceChecker();
}
function deathEvent() {
  var num = Math.floor(Math.random() * Math.floor(5));
  var index = Math.floor(Math.random() * Math.floor(wagon.characters.length));
  if (num === 0 && wagon.characters[index].health < 65) {
    buildModal(num);
    $(".ongoing-events").prepend(
      wagon.characters[index].name +
        " attempts to freestyle in park, but eveyone is trippin and a modular rig gets stolen from the van. Whack.<br>"
    );
    $("#myModal").toggle();
    wagon.characters[index].health = 0;
    wagon.characters[index].status = "Done (Just... Done)";
  } else if (
    num === 1 &&
    wagon.characters[index].illness.includes("Acid Crash")
  ) {
    buildModal(num);
    $(".ongoing-events").prepend(
      wagon.characters[index].name +
        " collapses after a catastrophic Acid Crash. They hunch over and fall to the ground. " +
        wagon.characters[0].name +
        " tries to revive them with techno and more acid. <br>" +
        wagon.characters[index].name +
        " is out."
    );
    $("#myModal").toggle();
    wagon.characters[index].health = 0;
    wagon.characters[index].status = "Done (Just... Done)";
    wagon.characters[0].health -= 15;
    wagon.characters[0].illness.push("Insta Fatigue");
  } else if (num === 2 && wagon.characters[index].health < 65) {
    buildModal(num);
    $(".ongoing-events").prepend(
      wagon.characters[index].name +
        " spends the last $20 on a rare italo record. <br>"
    );
    $("#myModal").toggle();
    wagon.money -= wagon.money * 0.25;
    $(".wagon-money-remaining").text(wagon.money.toFixed(2));
    wagon.characters[index].health = 0;
    wagon.characters[index].status = "Done (Just... Done)";
  } else if (
    num === 3 &&
    wagon.characters[index].illness.includes("CDJ Rage")
  ) {
    buildModal(num);
    $(".ongoing-events").prepend(
      wagon.characters[index].name +
        ` got stupid high the night before, then ${randomThingsNotToDoMessage} at the afterparty. Security is not amused. You're ejected then wander and rant before sleeping in a bush. ${randomBadSlangMessage}. But you managed to find ` +
        (wagon.food * 0.5).toFixed(2) +
        ` chicken strips. ${randomAwesomeSlangMessage}. <br>`
    );
    $("#myModal").toggle();
    wagon.food -= wagon.food * 0.5;
    $(".wagon-food-remaining").text(wagon.food.toFixed(2));
  } else if (num === 4 && wagon.characters[index].illness == "Insta Fatigue") {
    buildModal(num);
    $(".ongoing-events").prepend(
      wagon.characters[index].name +
        ` ${randomThingsNotToDoMessage} and security is unimpressed. ${randomBadSlangMessage}. <br>`
    );
    $("#myModal").toggle();
    wagon.characters[index].health = 0;
    wagon.characters[index].status = "Done (Just... Done)";
  }
}

//Hunting
Wagon.prototype.huntingTime = function () {
  var failChance = 0.4; // 40% chance to fail
  var hunt;

  if (Math.random() < failChance) {
    hunt = 0; // fail
  } else {
    hunt = Math.floor(Math.random() * 150) + 1; // succeed with 1–150
  }

  if (this.hunted == 1) {
    var num = 1;
    document.getElementById("shotgun-dry").play();
    buildModal(num);
    $(".ongoing-events").prepend(
      `You played too many ${randomTracksMessage}. ${randomCaresMessage} so you must drive further for new listeners. ${randomBadSlangMessage}. <br>`
    );
    $("#myModal").toggle();
  } else if (this.hunted == 0 && wagon.bullets > 0) {
    if (hunt === 0) {
      buildModal("huntFail");
      $(".ongoing-events").prepend(
        `Trippin too hard you only play ${randomTracksMessage} for two hours. Came back with only trail mix. Crew is unimpressed. ${randomBadSlangMessage}. <br>`
      );
      $("#myModal").toggle();
    } else {
      this.food += hunt;
      $(".ongoing-events").prepend(
        `${randomScoreSlangMessage} ${hunt} ${randomChickenMessage}. <br>${randomGoodVibesMessage}. ${randomAwesomeSlangMessage}. <br>`
      );
      document.getElementById("shotgun-fire").play();
    }

    this.bullets -= 1;
    wagon.statusAdjuster();
    this.hunted += 1;
  }

  if (wagon.bullets <= 0) {
    wagon.bullets = 0;
  }
  $("#wagon-bullets-remaining").text(wagon.bullets);
};

//Profession checker
Wagon.prototype.profession = function (input) {
  if (input == 1) {
    this.money += 500;
  } else if (input == 2) {
    this.money += 300;
  } else if (input == 3) {
    this.food += 500;
  } else if (input == 4) {
    this.food += 250;
    this.money += 250;
  } else if (input == 5) {
    this.money += 400;
    this.food += 100;
  } else if (input == 6) {
    this.money += 50;
  }
};

function storeSubTotal(food, bullets) {
  var total = food * 0.2 + bullets * 0.1;
  $(".food-total").text((food * 0.2).toFixed(2));
  $(".bullet-total").text((bullets * 0.1).toFixed(2));
  return total.toFixed(2);
}

function storeBuy(food, bullets) {
  var total = (food * 0.2 + bullets * 0.1).toFixed(2);

  if (
    total == NaN ||
    isNaN(total) ||
    wagon.money < total ||
    food < 0 ||
    bullets < 0
  ) {
    $("#store").effect("shake", { times: 3 }, 700);
  } else {
    wagon.money -= total;
    wagon.food += food;
    wagon.bullets += bullets;
    $("#store").fadeOut(500);
    $("#gameMainScreen").delay(500).fadeIn(500);
    $(".wagon-money-remaining").text(wagon.money.toFixed(2));
    $("#food-fields input, #bullet-fields input").val(0);
    $(".store-total, .bullet-total, .food-total").text("$0");
    return total;
  }
}

function textUpdateUI() {
  $("#player-one-name").text(char1.name);
  $("#player-two-name").text(char2.name);
  $("#player-three-name").text(char3.name);
  $("#player-four-name").text(char4.name);
  $("#player-five-name").text(char5.name);
  $("#player-one-status").text(char1.status);
  $("#player-two-status").text(char2.status);
  $("#player-three-status").text(char3.status);
  $("#player-four-status").text(char4.status);
  $("#player-five-status").text(char5.status);
  $("#player-one-illness").text(char1.illness.length);
  $("#player-two-illness").text(char2.illness.length);
  $("#player-three-illness").text(char3.illness.length);
  $("#player-four-illness").text(char4.illness.length);
  $("#player-five-illness").text(char5.illness.length);
  $("#wagon-food-remaining").text(wagon.food.toFixed(0));
  $(".wagon-money-remaining").text(wagon.money.toFixed(2));
  $("#wagon-bullets-remaining").text(wagon.bullets.toFixed(0));
  $(".current-date").text(wagon.days);
  $(".distance-traveled").text(wagon.distance);
}

function validateNames(
  profession,
  playerOne,
  playerTwo,
  playerThree,
  playerFour,
  playerFive
) {
  if (
    profession === undefined ||
    playerOne === "" ||
    playerTwo === "" ||
    playerThree === "" ||
    playerFour === "" ||
    playerFive === ""
  ) {
    $("#charNameInput").effect("shake", { times: 3 }, 700);
    $("#profession").effect("shake", { times: 3 }, 700);
  } else {
    $("#characterInput").fadeOut(500);
    $("#store").delay(500).fadeIn(500);
  }
}

function enableSubmit(ele) {
  if (ele == "#continue-button") {
    $(ele).css({
      "pointer-events": "auto",
      "background-color": "#28a745",
      "border-color": "#28a745",
    });
  } else if (ele == "#rest-button") {
    $(ele).css({
      "pointer-events": "auto",
      "background-color": "#17a2b8",
      "border-color": "#17a2b8",
    });
  }
}

$(document).ready(function () {
  var x = 1;
  $("#wagon-images").addClass("sky1");

  // modal that closes with click anywhere
  var modal = document.getElementById("myModal");
  var span = document.getElementById("myModal");
  span.onclick = function () {
    modal.style.display = "none";
  };

  $("#startBTN").click(function () {
    document.getElementById("openingSong").play();
    $("#start").fadeOut(500);
    $("#characterInput").delay(500).fadeIn(500);
  });
  $("#characterBTN").click(function () {
    var playerOneName = $("#char1").val();
    var playerTwoName = $("#char2").val();
    var playerThreeName = $("#char3").val();
    var playerFourName = $("#char4").val();
    var playerFiveName = $("#char5").val();
    var professionValue = $("input:radio[name=profession]:checked").val();

    validateNames(
      professionValue,
      playerOneName,
      playerTwoName,
      playerThreeName,
      playerFourName,
      playerFiveName
    );
    char1 = new Character(playerOneName);
    char2 = new Character(playerTwoName);
    char3 = new Character(playerThreeName);
    char4 = new Character(playerFourName);
    char5 = new Character(playerFiveName);
    wagon = new Wagon();
    journey(0);
    char1.healthBar();
    wagon.characters.push(char1, char2, char3, char4, char5);
    wagon.profession(professionValue);
    textUpdateUI();
  });

  $("#subtotal").click(function () {
    var buyFood = parseInt($("#food-fields input").val());
    var buyBullets = parseInt($("#bullet-fields input").val());
    $(".store-total").text("$ " + storeSubTotal(buyFood, buyBullets));
  });

  $("#storeBTN").click(function () {
    var buyFood = parseInt($("#food-fields input").val());
    var buyBullets = parseInt($("#bullet-fields input").val());
    storeBuy(buyFood, buyBullets);
    $("#wagon-food-remaining").text(wagon.food);
    $(".wagon-money-remaining").text(wagon.money.toFixed(2));
    $("#wagon-bullets-remaining").text(wagon.bullets);
    document.getElementById("openingSong").pause();
  });

  $("#preCheckout").click(function () {
    storeModal();
    $("#myModal").toggle();
  });

  $("#back-button").click(function () {
    $("#store").fadeOut(500);
    $("#characterInput").delay(500).fadeIn(500);
  });

  $("#continue-button").click(function () {
    $("#continue-button").css({
      "pointer-events": "none",
      "background-color": "lightgreen",
      "border-color": "lightgreen",
    });
    setTimeout(function () {
      enableSubmit("#continue-button");
    }, 500);
    wagon.turn();
    wagon.statusAdjuster();
    textUpdateUI();

    if (x < 6) {
      $("#wagon-" + x).toggle();
      $("#wagon-images").removeClass("sky" + x);
      x++;
      $("#wagon-" + x).toggle();
      $("#wagon-images").addClass("sky" + x);
    } else {
      $("#wagon-" + x).toggle();
      $("#wagon-images").removeClass("sky" + x);
      x = 1;
      $("#wagon-" + x).toggle();
      $("#wagon-images").addClass("sky" + x);
    }
  });

  $("#rest-button").click(function () {
    $("#rest-button").css({
      "pointer-events": "none",
      "background-color": "lightblue",
      "border-color": "lightblue",
    });
    setTimeout(function () {
      enableSubmit("#rest-button");
    }, 500);
    wagon.rest();
    textUpdateUI();
  });

  $("#hunt-button").click(function () {
    wagon.huntingTime();
    wagon.resourceChecker();
    textUpdateUI();
  });

  $(document).on("click", "#deathButton", function () {
    history.go(0);
  });

  $(document).on("click", "#winButton", function () {
    history.go(0);
  });

  $(document).on("click", "#sacrifice", function () {
    history.go(0);
  });

  $(document).on("click", "#crossRiverButton", function () {
    crossRiver();
    textUpdateUI();
    $("#buttonModal").hide();
  });
  $(document).on("click", "#detourRiverButton", function () {
    detourRiver();
    textUpdateUI();
    $("#buttonModal").hide();
  });
  $(document).on("click", "#sacrificeButton", function () {
    sacrifice();
    textUpdateUI();
    $("#buttonModal").hide();
  });
  $(document).on("click", "#fleeButton", function () {
    flee();
    textUpdateUI();
    $("#buttonModal").hide();
  });
});
