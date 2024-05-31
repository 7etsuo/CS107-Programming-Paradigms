Terry Jones "how they met" grammar
----------------------------------------------------------------------

From cs107-request@cs.Stanford.EDU Sat Apr 27 14:42:20 1996
Return-Path: <cs107-request@cs.Stanford.EDU>
Received: from Sunburn.Stanford.EDU by monolith.Stanford.EDU (NX5.67e/NX3.0M)
        id AA28759; Sat, 27 Apr 96 14:42:18 -0700
Received: from anduin.ocf.llnl.gov (anduin.ocf.llnl.gov [134.9.49.1]) by Sunburn.Stanford.EDU (8.7.1/8.7.1) with SMTP id OAA23954 for <cs107@cs.stanford.edu>; Sat, 27 Apr 1996 14:42:09 -0700 (PDT)
Posted-Date: Sat, 27 Apr 1996 14:42:09 -0700 (PDT)
Received: from odin.ocf.llnl.gov.ocf by anduin.ocf.llnl.gov (4.1/SMI-4.0)
        id AA00330; Sat, 27 Apr 96 14:42:23 PDT
Received: by odin.ocf.llnl.gov.ocf (4.1/SMI-4.1)
        id AA11230; Sat, 27 Apr 96 14:42:21 PDT
Date: Sat, 27 Apr 96 14:42:21 PDT
From: trj@odin.ocf.llnl.gov (Terry R. Jones)
Message-Id: <9604272142.AA11230@odin.ocf.llnl.gov.ocf>
To: cs107@cs.Stanford.EDU
Subject: how_they_met.g
Status: RO


Hello,

Here's a new grammar -- it sometimes produces a cute result...

-terry
##########################################################################
#
#   Grammar: How they met
#   Author:  Terry Jones (trj@cs.stanford.edu, trj@llnl.gov)
#
#   Please copy freely. If you make any additions or have any suggestions,
#   please send them to me.
#
##########################################################################

{
<start>
<Present-day-meeting> . <Predictable-result> . <Proving-the-saying>  <saying> ;
<Present-day-meeting> . <Predictable-result> . <Proving-the-saying>  <saying> ;
<1960s-day-meeting> . <Predictable-result> . <Proving-the-saying>  <saying> ;
<1950s-day-meeting> . <Predictable-result> . <Proving-the-saying>  <saying> ;
<1920s-day-meeting> . <Predictable-result> . <Proving-the-saying>  <saying> ;
<1800s-day-meeting> . <Predictable-result> . <Proving-the-saying>  <saying> ;
<Only-in-Hollywood> . <Predictable-result> . <Proving-the-saying>  <saying> ;
}

{
<Predictable-result>
<Seizing-the-moment> , <that-sly-dog> <made-an-impression>      ;
}

{
<Present-day-meeting> 
<Living-Female> was working as <questionable-present-day-career> , and <Living-Male> was <just-visiting> . <Present-day-cross-paths>    ;
}

{
<1960s-day-meeting> 
<1960s-Female> was working as <questionable-1960s-career> , and <1960s-Male> was <just-visiting> . <1960s-cross-paths>  ;
}

{
<1950s-day-meeting> 
<1950s-Female> was working as <questionable-1950s-career> , and <1950s-Male> was <just-visiting> . <1950s-cross-paths>  ;
}

{
<1920s-day-meeting> 
<1920s-Female> was working as <questionable-1920s-career> , and <1920s-Male> was <just-visiting> . <1920s-cross-paths>  ;
}

{
<1800s-day-meeting> 
<1800s-Female> was working as <questionable-1800s-career> , and <1800s-Male> was <just-visiting> . <1800s-cross-paths>  ;
}

{
<Only-in-Hollywood> 
In a sequel sure to please, Hollywood will match <Movies-Female> with <Movies-Male> . The stars blaze across the silverscreen as he, who is <just-visiting> , finds the love of his dreams quite unexpectedly. <Present-day-cross-paths>        ;
}

{
<Living-Female>
Diana, her royal divorcee of Windsor,   ;
Julie Zelenski  ;
Cher    ;
Margaret Thatcher       ;
Madonna         ;
Mother Teresa   ;
Sharon Stone    ;
Hillary Clinton         ;
Zsa Zsa Gabor   ;
Julia Roberts   ;
Sally Ride      ;
Priscilla Presley       ;
}

{
<Living-Male>
Yassar Arafat   ;
Pee Wee Herman  ;
Woody Allen     ;
Sadam Hussein   ;
Oliver North    ;
Jack Nicholson  ;
Pat Buchannan   ;
Sam Donaldson   ;
Bill Gates      ;
Michael Douglass        ;
Stephan Hawking         ;
Fabio   ;
Jesse Jackson   ;
Jessie Helms    ;
Howard Stern    ;
Axel Rose       ;
Michael Jackson         ;
the artist that is sometimes known as Prince    ;
Rob Lowe        ;
}

{
<1960s-Female>
Jane Fonda      ;
Ursula Andress  ;
Gloria Steinem  ;
Barbara Carrera         ;
Raquel Welch    ;
Charo   ;
Grace Slick     ;
Sandra Dee      ;
Joan Baez       ;
Barbara Eden    ;
Grace Kelly     ;
Patty Hearst    ;
Janis Joplin    ;
}

{
<1960s-Male>
John F. Kennedy         ;
George Wallace  ;
Barry Goldwater         ;
Prince Ranier   ;
Jimi Hendrix    ;
Joe Namath      ;
Richard Feynman         ;
Elvis Presley   ;
John Lennon     ;
Timothy Leary   ;
Muhammad Ali    ;
Fidel Castro    ;
Henry Kissinger         ;
Nikita Khruschev        ;
}

{
<1950s-Female>
Marilyn Monroe  ;
Mae West        ;
Jane Russell    ;
Elizabeth Taylor        ;
Ingrid Bergman  ;
Lauren Bacall   ;
Katherine Hepburn       ;
Sophia Loren    ;
Bridgette Bardot        ;
Donna Reed      ;
Doris Day       ;
Queen Beatrix , just in from the Netherlands , ;
}

{
<1950s-Male>
Albert Einstein         ;
Laurence Olivier        ;
Frank Sinatra   ;
Joseph McCarthy         ;
Jawaharlal Nehru        ;
James Dean      ;
Howard Hughes   ;
John Edgar Hoover       ;
Vivien Leigh    ;
Alfred Hitchcock        ;
Will Rogers     ;
Clark Gable     ;
Humphrey Bogart         ;
James Stewart   ;
Tony Curtis     ;
}

{
<1920s-Female>
Agatha Christie         ;
Marie Curie     ;
Greta Garbo     ;
Mary Astor      ;
Amelia Earhart  ;
Mary Pickford   ;
Jean Harlow     ;
Carole Lombard  ;
Coco Chanel     ;
Lilian Gish     ;
}

{
<1920s-Male>
Bertrand Russell        ;
Douglas Fairbanks       ;
Rudolph Valentino       ;
Enrico Caruso   ;
Winston Churchill       ;
Cole Porter     ;
Charlie Chaplin         ;
Sigmund Freud   ;
Babe Ruth       ;
Ernest Hemingway        ;
Mohandas Gandhi         ;
Carl Jung       ;
Pablo Picasso   ;
Enrico Fermi    ;
Maurice Chevalier       ;
}

{
<1800s-Female>
Jane Austen     ;
Charlotte Bronte        ;
Elizabeth Barret        ;
Florence Nightingale    ;
Emily Dickinson         ;
Louisa May Alcott       ;
Fannie Farmer   ;
Mary Todd       ;
Mary Cassatt    ;
}

{
<1800s-Male>
Auguste Rodin   ;
Vincent van Gogh        ;
Samuel Clemens  ;
Robert Browning         ;
Lewis Carol     ;
Abraham Lincoln         ;
Crazy Horse     ;
Karl Marx       ;
Claude Monet    ;
Louis Pasteur   ;
Edgar Allen Poe         ;
}

{
<Movies-Female>
Julia Roberts as Vivian, the hooker with a heart of gold from "Pretty Woman",   ;
Glenn Close, who gives us an earlier view of Alex Forrest from "Fatal Attraction",      ;
Sandra Bullock, who reprises her role as Annie from "Speed",    ;
Jodie Foster, who returns as the bright young FBI agent Clarice Starling from "Silence of the Lambs",   ;
Marisa Tomei, who returns as Mona Lisa Vito from "My Cousin Vinny",     ;
Sean Young, who returns as Rachel the replicant from "Blade Runner",    ;
Kathleen Turner, who returns as Matty Walker, a woman with a past from "Body Heat",     ;
Kelly McGillis, who returns as Rachel the Amish woman from "Witness",   ;
}

{
<Movies-Male>
Michael Douglas as that single president on the prowl from The American President       ;
Peter Sellers, who returns as Chance from Being There   ;
Dudley Moore who plays Arthur, the underachieving billionaire   ;
Peter Sellers who plays Dr. Stangelove  ;
Chevy Chase, who returns as "Fletch"    ;
David Naughton, who reprises his role as David Kessler from "An American Werewolf in London"    ;
Bond, James Bond        ;
Eddie Murphy, who plays Axel Foley the out of town law enforcer from "Beverly Hill Cop"         ;
Jon Voight, who reprises Joe Buck from "Midnight Cowboy"        ;
}

{
<questionable-present-day-career>
<present-day-jobtitle> for <present-day-company>        ;
the speech writer for Ted Kennedy       ;
the television executive that brought us Baywatch       ;
an animal groomer (specializing in iguanas)     ;
}

{
<questionable-1960s-career>
<1960s-day-jobtitle> for <1960s-day-company>    ;
the president of the June Cleaver fan club      ;
a runner for the local television newsroom      ;
a goat cheese dairy farmer      ;
}

{
<questionable-1950s-career>
<1950s-day-jobtitle> for <1950s-day-company>    ;
a social worker who made headlines denouncing rock-n-roll       ;
a baggage attendant for Burlington Rail Lines   ;
a voice actor for a western radio show  ;
a customs inspector at the airport      ;
}

{
<questionable-1920s-career>
<1920s-day-jobtitle> for <1920s-day-company>    ;
a flapper       ;
a bank teller   ;
a bootlegger    ;
an art deco interior designer   ;
}

{
<questionable-1800s-career>
<1800s-day-jobtitle> for <1800s-day-company>    ;
a nurse maid    ;
a mountain-climber and explorer         ;
a U.S. ambassador       ;
a stagehand for the wild west show      ;
the assistant to a blind dentist        ;
}

{
<present-day-jobtitle>
<not-time-specific-jobtitle>    ;
a body model for knee caps      ;
an overpriced management consultant     ;
an overpriced advertising consultant    ;
}

{
<1960s-day-jobtitle>
<not-time-specific-jobtitle>    ;
a hula dancer   ;
an earthworm trainer    ;
a logistical strategist         ;
}

{
<1950s-day-jobtitle>
<not-time-specific-jobtitle>    ;
an inspector    ;
a cashier       ;
the brains behind       ;
}

{
<1920s-day-jobtitle>
<not-time-specific-jobtitle>    ;
a machete handler       ;
a gymnast       ;
an entomologist         ;
}

{
<1800s-day-jobtitle>
<not-time-specific-jobtitle>    ;
a milliner      ;
a carriage crafter      ;
a journalist    ;
}

{
<not-time-specific-jobtitle>
a poster child  ;
an undergarment model   ;
an outhouse inspector   ;
a belly dancer  ;
an attorney on retainer to      ;
}

{
<present-day-company>
OSH-GOSH by gosh        ;
an animal rights activist group         ;
a nuclear weapons laboratory    ;
the flat earth society  ;
Stanford University     ;
the men in Bravo battalion during Operation Desert Getting-Cloudy       ;
}

{
<1960s-day-company>
Bob Hope's USO show     ;
the Peace Corps         ;
a toy company that made hula-hoops      ;
a radical anti-war group        ;
}

{
<1950s-day-company>
Studebaker Motors       ;
a small diner   ;
a drive-in theater      ;
Western Union   ;
the Motorola radio company      ;
}

{
<1920s-day-company>
a company that specialized in formal attire for flappers        ;
a luxury cruise line    ;
an east coast furrier   ;
Packard Motorcars       ;
J.P. Morgan and Co.     ;
Stanley Steamer Motors  ;
}

{
<1800s-day-company>
a large equestrian concern      ;
a travel agency that arranged for expeditions to the Amazon     ;
a Boston based cartography concern      ;
Atlantic Telegraph      ;
}

{
<just-visiting>
checking out the nearby tongue depressor exhibit        ;
in town for a little payola from the CIA        ;
trying out for a part in <dubious-film> , which thankfully never saw the light of day   ;
in town to promote his new hemorrhoid ointment  ;
in town for a new tattoo        ;
in town for a <Group> convention        ;
by a happy coincidence, buying some liver and onions across the street  ;
just back from <improbable-place>       ;
}

{
<dubious-film>
Revenge of the Killer Tomatoes Part II  ;
"The Ten Commandments Part II: The Egyptians Strike Back"       ;
Gone With The Wind Part II      ;
"Casablanca Part II: Ok I'll Leave The Bum"     ;
}

{
<improbable-place>
an uncharted jungle in the Amazon       ;
a 10 day pilgrimage to Mecca    ;
a poaching safari in Kenya      ;
a three month swim down the Yangtze river       ;
}

{
<Group>
National Rifle Association      ;
Americans for Hampsters         ;
Ukelele Muscisians      ;
political       ;
}

{
<Present-day-cross-paths>
<Not-time-specific-cross-paths>         ;
<Not-time-specific-cross-paths>         ;
He spilled a <Fruit-and-vegetables> drink onto her favorite dress       ;
He noticed her as he bumped a street performer juggling swords (it's OK I think the juggler lived)      ;
}

{
<1960s-cross-paths>
<Not-time-specific-cross-paths>         ;
<Not-time-specific-cross-paths>         ;
He noticed her at a war protest         ;
He noticed her at a Stones concert      ;
He noticed her at a new Brando flick    ;
He was trying to pickup co-eds at the University when he noticed her    ;
}

{
<1950s-cross-paths>
<Not-time-specific-cross-paths>         ;
<Not-time-specific-cross-paths>         ;
He noticed her while attending the premiere of a Rock Hudson movie      ;
They met on a crowded Paris street      ;
They met at a football game     ;
}

{
<1920s-cross-paths>
<Not-time-specific-cross-paths>         ;
<Not-time-specific-cross-paths>         ;
He noticed her new Stutz Bearcat first, then he noticed the cars driver         ;
They had both just lost a bundle in the crash of '29    ;
}

{
<1800s-cross-paths>
<Not-time-specific-cross-paths>         ;
<Not-time-specific-cross-paths>         ;
He was seated behind her at an oratory  ;
He was seated behind her at a recital   ;
}

{
<Not-time-specific-cross-paths>
They were vacationing at the same hotel in <improbable-place>   ;
They were both visiting the home of a well-known <Group> leader         ;
He bumped her into a mens Turkish bath house    ;
He bumped into the table where she was dining, spilling Mama Matarazzo's pasta all over the Mayor       ;
Just returning from the beach, he noticed the gulls circling what turned out to be her dining alone     ;
He noticed her as he bumped a waiter preparing Cherries Jubilee, causing a fire. (It should be noted that the cafe owner was able to rebuild on the same spot.)         ;
}

{
<Seizing-the-moment>
Seizing the moment      ;
Aware of his opportunity        ;
Never the one to miss a chance for sex  ;
Overcome with the situation     ;
Baffled by her je ne sais quoi  ;
}

{
<that-sly-dog>
Snookims, that what she called him,     ;
that sly dog    ;
he, possessing a deafening shrill-like voice,   ;
he, with that overpowering breath he is known to have,  ;
}

{
<made-an-impression>
<made-his-move> <with-the-expected-results>     ;
}

{
<made-his-move>
told her they were meant to be lovers.  ;
asked her for her hand and what ever other parts she could spare.       ;
gave her his corny pickup line.         ;
looked her in the face and burped.      ;
asked her if she wanted to see his private collection.  ;
bent down to one knee and started reciting bad poetry to her.   ;
swept her off her feet.         ;
}


{
<with-the-expected-results>
This had the desired affect of melting her heart , which as everyone knows , melted for somebody new about once a week  ;
Pandemonium ensued as they begin to ravage each other wildly. In reality it was never meant to be       ;
Her flame sparked, he moved her to an heretofore unknown passion for older men with thinning hair       ;
In short order, he managed to move her deeply in the depths of her intestines   ;
The snare was set and she had no escape, she was caught like a deer looking into the headlights of his love     ;
Quick to assess the situation, she jumped him and wrapped her legs around him.  ;
She turned back around and ignored him completely, making him more determine to win her heart   ;
The intoxicating liquor of his words poured into her love-empty mind, opening her eyes to the futility of her existence without him . At least for the ensuing two weeks        ;
}

{
<Proving-the-saying>
All of which just proves the old Yiddish saying,        ;
It's just as the Zuni Indians like to say,      ;
It happened as was written in the Old Testament,        ;
The aboriginal Austrailians having a saying for it,     ;
The nomadic tribes of the African grasslands had it right when they said,       ;
<Culture-Language> give us a charming idiom,    ;
<Culture-Language> have a saying of the heart,  ;
}

{
<Culture-Language>
Latin vase craftsmen    ;
Ancient Tibetan Monks   ;
Irish fisherman         ;
The students of Plato's teachings       ;
Gaelic fishermen        ;
Writings found on ancient papyri        ;
Egyptian hieroglyphics  ;
}

{
<saying>
" Two <animals> will <do-wacky-things> . "      ;
" <Fruit-and-vegetables> <make-a-drink> . "     ;
" <Famous-saying-beginnings> <famous-saying-endings> . "        ;
" It takes more than <ingredients> to build a <object> . "      ;
" <Opposites> <attract> . "     ;
}

{
<animals>
small ungulates         ;
elephants with diarrhea         ;
ostriches courting      ;
ferrets in heat         ;
}

{
<do-wacky-things>
carry no dead   ;
argue only until sunset         ;
fall off the mountain and into a huge pile of bat guano         ;
fight until love, or death, or they get tired   ;
}

{
<Fruit-and-vegetables>
Pickles and watermelons         ;
Celery and spinach      ;
Mint and bean curd      ;
Kumquat and wheat germ  ;
Potato and citrus       ; 
}

{
<make-a-drink>
make a drink, but who will drink it     ;
make a drink that always quenches       ;
make a drink that cures all ills        ;
make a drink that sweetens the bladder  ;
}

{
<Famous-saying-beginnings>
A rolling stone         ;
One in the hand         ;
A fool and his money    ;
Foolishness is bound in the heart of a child, but the rod of correction         ;
}

{
<famous-saying-endings>
has a silver lining     ;
is good for eating      ;
is my best friend       ;
}

{
<ingredients>
Two hands of sand and a plan    ;
Donkey droppings and water      ;
All the trees in the forest     ;
Old bones and the stench of rotting flesh       ;
}

{
<object>
lovely home     ;
great ox yoke   ;
useful toiletries       ;
fine clothes    ;
}

{
<Opposites>
Hot and cold    ;
Night and day   ;
The yin and the yang    ;
Romance and fighting    ;
}

{
<attract>
fuse together with the heat of many suns        ;
draw out the bad gas from each other    ;
splash upon the beach of life   ;
}

