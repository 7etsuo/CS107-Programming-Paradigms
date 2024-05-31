Posted-Date: Thu, 25 Apr 1996 19:06:19 -0700 (PDT)
Date: Thu, 25 Apr 1996 19:08:45 -0700
From: Matthew Franklin <startled@leland.Stanford.EDU> 
X-Mailer: Mozilla 2.0 (Win95; I)
To: zelenski@cs.Stanford.EDU
Subject: grammar file
X-Url: ,http://www-cse.stanford.edu/classes/cs107/current/index.html

It had to be done: it's the random CIV Introductory Paragraph 
Generator.  I wasn't quite ambitious enough to make it generate an 
entire paragraph, but I'm sure if someone completed this grammar it 
would get a B+ every time.

It was rather large, so I attached it in the file "civ.g".

Oh, and by the way, I put in your name, but had a little bit of
trouble with gender-specific words, so sometimes it says, "Mr.
Zelenski."  Just assume it's talking about someone else. :)

---
Frightened?  No, I think startled is a better word.
startled@leland.stanford.edu
It's the Random CIV Introduction Paragraph Grammar!  If I was ambitious
enough to make it do an entire paper, it'd get a B+ every time.  However,
hopefully this will give you a good start next time you're stuck.

by Matt Franklin

{
<start> 
<intro> ;
}

<body1> 
<body2> 
<conclusion> ;

{
<intro> 
<FirstSentence> <Funnel> <Thesis> ;
}

{
<FirstSentence> 
<StartingClause> <Group> <PastAction> . ;
<Quotation> -- <Author> <QuoteEnd> <QuoteTransition> . ;
As <Author> once said, <Quotation> <QuoteTransition> . ;
<Anecdote> . <AnecdoteTransition> ;
}

{
<Thesis> 
<PlainAuthor> uses <BigCIVNoun> in <Work> to <DoCIVThing> <Group> with <Group> . ;
In fact, the <PluralCIVItem> serve as symbols for the <Adjective> life of the <Group> . ;
<PlainAuthor> uses <PluralCIVItem> and <PluralCIVItem> to bring a <CIVAdjective> perspective to thinkers during the <TimePeriod> . ;
Both <Work> and <Work> use <CIVAdjective> <PluralCIVItem> , albeit in <Adverb> contrasting ways. ;
<PlainAuthor> , though of a wildly different opinion than <Author> , uses <PluralCIVItem> in almost exactly the same <CIVAdjective> manner as the latter author in <Work> . ;
The author uses a <CIVAdjective> rhetoric, different from the standard <CIVAdjective> rhetoric of the <TimePeriod> , to present a different, <Adjective> perspective on <Group> . ;
}

{
<DoCIVThing> 
contrast ;
compare ;
juxtapose ;
stick ;
<Adverb> put ;
}

{
<PluralCIVItem> 
Florentines ;
circles of hell ;
angels ;
daemons ;
social contracts ;
sprites ;
gods ;
Zeus and friends ;
Miranda Rights ;
allegories ;
Far Side comics ;
dresses ;
Sufis ;
monotheists ;
birds ;
}

{
<CIVAdjective> 
distinct ;
liberal ;
concise ;
convoluted ;
unique ;
homosexual ;
heterosexual ;
bisexual ;
male ;
female ;
transexual ;
feminist ;
chauvinist ;
Calvinist ;
diminished ;
musical ;
}

{
<QuoteTransition> 
Just like <Person> , many other <TimePeriod> thinkers believed in the purity of the <Group> -- <Author> was no different ;
But ever since those famous words, the <Group> as well as the <Group> have contested such theories, calling them <Adjective> .  <PlainAuthor> expounds on such views in <Work> ;
This should not apply to such a limited, <Adjective> context-- it can be applied to <PluralNoun> , <PluralNoun> , and <Work> ;
Obviously, <Author> felt similarly-- he wrote about things as varied as <PluralNoun> to <PluralNoun> , from the <Group> to the <Group> ;
Those words permeate many important <Adjective> literary works, none moreso than <Work> ;
}

{
<AnecdoteTransition> 
Such incidents are not rare, but are rather an essential and <Adjective> part of human life-- <Author> believed so, and <Adverb> wrote about it in <Work> . ;
Obviously, <Author> must have had a similar incident, or at least a <Adverb> <Adjective> one, in order to write so <Adverb> about it in <Work> . ;
Perhaps <Author> drew from such unusual experiences-- obvious in his use of <BigCIVNoun> and <BigCIVNoun> are his influences from <Group> , and his love of <PluralNoun> . ;
}

{
<Funnel> 
In <Author> 's <Work> , we see striking examples of <Adjective> <PluralNoun> , and <Adjective> <Group> .  The author proves such views using the favorite tools of the <TimePeriod> : <BigCIVNoun> and <BigCIVNoun> . ;
While <Author> 's most famous work was <Work> , <Work> is perhaps more strikingly philosophical-- and doubtless, more <Adjective> .  In fact, the <PluralNoun> in the text reach beyond mere <BigCIVNoun> -- they extend to <BigCIVNoun> . ;
Similarly, <Author> 's striking insights about the <BigCIVNoun> inherent in <Group> <Adverb> permeated the <TimePeriod> .  Now, though, scholars focus on <BigCIVNoun> -- it proves both more <Adjective> and relevant to modern times. ;
Despite the claims in <Work> , however, and excessive use of <BigCIVNoun> , one thing is apparent-- the <Adjective> and <Adjective> activities of <Group> .  The text, however, proves this uniquely. ;
Such thoughts should not be taken at face value, however.  Rather, one should <Verb> , and not accept too <Adverb> the conclusions drawn in <Work> without understanding its most important tool: <BigCIVNoun> . ;
}

{
<StartingClause> 
During the <TimePeriod> , ;
A long time ago, ;
Perhaps <Adverb> , ;
Contrary to popular belief, ;
Although <PlainAuthor> thought otherwise, ;
Much like the <Group> during the <TimePeriod> , ;
}

{
<Quotation> 
"The <Group> <PastAction> for <QuantityEds> of years." ;
"I have often <PastAction> , to the <PersonReaction> of <Group> ." ;
"Ask not what your country can <Verb> for you, ask what you can <Verb> for your country." ;
" <Group> , left by nature to instincts alone..., begin with purely <Adjective> functions." ;
"Uh... <Exclamation> " ;
"And in all seriousness: I see such new <Group> coming up." ;
"To <Verb> , or not to <Verb> ?" ;
"Religion is the <Noun> of the people." ;
"'I thought you were dead-- heard you fell off your horse and broke your bloody neck.'  'I heard that one too, Bob.  I even thought I was dead, until I found out it was only I was in <Place> .'" ;
}

{
<Author> 
<PersonDescribe> Kant ;
<PersonDescribe> Rousseau ;
<PersonDescribe> Nietsche ;
<PersonDescribe> Bill Gates ;
<PersonDescribe> D.L. Demorest ;
<PersonDescribe> Zelenski ;
<PersonDescribe> Albert Beguin ;
<PersonDescribe> Sigmund Freud ;
<PersonDescribe> Charles Augustine Sainte-Beuve ;
<PersonDescribe> W. Vaughan Wartburg ;
<PersonDescribe> Marx ;
<PersonDescribe> St. Augustine ;
<PersonDescribe> Skinny Puppy ;
<PersonDescribe> Beavis ;
my frisbee ;
my father ;
}

{
<PlainAuthor> 
Kant ;
Rousseau ;
Nietsche ;
Bill Gates ;
D.L. Demorest ;
Julie Zelenski ;
Albert Beguin ;
Sigmund Freud ;
Charles Augustine Sainte-Beuve ;
W. Vaughan Wartburg ;
Marx ;
St. Augustine ;
Beavis ;
Skinny Puppy ;
}

{
<PersonDescribe> 
the esteemed ;
the widely popular ;
the brilliant ;
the somewhat dull-witted, but nonetheless reputable ;
Mr. ;
monsieur ;
Senor ;
the poignantly well-spoken ;
the peaceful ;
the marked opponent of <Group> , yet otherwise nice, ;
the ubiquitous ;
the devoted supporter of <Group> , yet otherwise nice, ;
}

{
<QuoteEnd> 
was a person of firmly-held convictions. ;
sacrificed endlessly for what he believed in. ;
was a full-fledged, <Adjective> member of <Group> . ;
lived life to its fullest. ;
most aptly described popular opinion at the time with these words. ;
often <Adverb> spoke his mind, regardless of popular opinion. ;
<Adverb> supported rights for <Group> . ;
authored the controversial text, <Work> . ;
}

{
<Anecdote> 
<TimePeriodAgo> , <Person> <PastAction> .  To <Person> 's <PersonReaction> , however, <Group> <PastAction> to avoid <PluralNoun> !  I now know <Person> <FutureThingy> <Verb> , <PostCommaEnd> ;
<TimePeriodAgo> , <Person> <PastAction> .  Because of that, to this day <Group> do not know what happened to their holy <Noun> ;
Once, when I was little, I saw <Person> <Verb> .  Because of my age, however, I didn't even recognize <PersonDescribe> author of <Work> ;
We all love to chase the <Noun> as children.  But <Adverb> enough, I knew a kid on my block who preferred <PluralNoun> ;
We all watched on TV when <Person> <PastAction> .  No one can forget that date-- but who remembers when <Person> <PastAction> , or the exploits of <Group> ?  Very few, indeed ;
<TimePeriodAgo> , I couldn't think up an idea for my CIV paper.  But, while listening to <Group> , I saw a <Noun> , and inspiration hit ;
}

{
<PastAction> 
attacked <Group> ;
persecuted <Group> ;
compared <Group> to <Group> ;
oppressed <Group> ;
tweaked <Group> ;
taxed <Group> ;
jumped over tall <PluralNoun> in single bounds ;
ate <Adverb> ;
utilized <PluralNoun> ;
drank <Soda> ;
thought about <PluralNoun> ;
burned in hell for eternity ;
philosophized existentially ;
flailed <Adverb> ;
encroached on <Group> 's territory ;
}

{
<Group> 
SPEBSQSA ;
Village People ;
members of Skinny Puppy ;
crazed groupies of <Group> ;
peasants ;
native-born Italians ;
Greeks ;
Communists ;
Mafioso ;
Florentines ;
women ;
men ;
drag queens ;
computer geeks ;
followers of Socrates ;
Sophists ;
Platonists ;

philosophers ;
wild monkey-men ;
stunt doubles in Planet of the Apes ;
eaters of the sacred <Noun> ;
monks ;
nuns ;
Wiccans ;
}

{
<Noun> 
ice cream truck ;
taco ;
dog ;                       
cow ;
lotus ;
butterfly ;
can of soda ;
fruit of knowledge ;
Skittle ;
3-D CAD program ;
fully <Adverb> <Adjective> programming environment ;
governing body ;
deck of cards ;
manifesto ;
duck of death ;
CIV track ;
}

{
<PluralNoun> 
ducks of death ;
CIV tracks ;
fruits of knowledge ;
cows ;
bags of hashish ;
bones ;
opiates ;
pomegranates ;
authors ;
quotations ;
goblets ;
punk rock bands ;
bags of Top Ramen ;
}


{
<BigCIVNoun> 
juxtaposition ;
faith ;
society ;
espousal ;
paradox ;
dialectic ;
duality ;
teleology ;
tabula rasa ;
law ;
multimedia ;
technology ;
futurism ;
realism ;
naturalism ;
pessimism ;
Communism ;
Marxism ;
capitalism ;
euphemism ;
euphony ;
telephony ;
digital telephony ;
}

{
<Adverb> 
philosophically ;
quickly ;
stridently ;
religiously ;
impudently ;
demonically ;
omnisciently ;
democratically ;
fully ;
paradoxically ;
independently ;
calculatingly ;
pithily ;
pedantically ;
didactically ;
}

{
<Verb> 
conform ;
write ;
eat ;
paint ;
live ;
experience ;
extol ;
preach ;
expunge ;
run naked through <Place> ;
}

{
<Place> 
Nebraska ;
Heaven ;
Hell ;
The Eighth Circle, Ring of the <Group> ;
The Eighth Circle, Ring of the <Group> ;
my living room ;
Rome ;
<Author> 's living room ;
on the map, right next to <Place> ;
Greece ;
Troy ;
the barren Arctic ;
the green glen ;
the grassy knoll ;
France ;
Florence ;
Athens ;
the Symposium ;
Plato's Academy ;
the Coliseum ;
the History Corner ;
the Steam Tunnels ;
}

{
<Person> 
<PlainAuthor> ;
my mother ;
my brother ;
my dog ;
my goldfish ;
George Washington ;
Mr. Bimble ;
Fozzi Bear ;
Ogre ;
Charles Bovary ;
Madame Bovary ;
Dilbert ;
Dogbert ;
Calvin ;
Hobbes ;
Jesus ;
Dante ;
Snoopy ;
Woodstock ;
Gerhard Casper ;
Dinah Shore ;
Jello Biafra ;
}

{
<PersonReaction> 
surprise ;
consternation ;
amazement ;
disgust ;
regret ;
fright ;
garbled babbling ;
brick-throwing anger ;
}

{
<Soda> 
the Juice ;
Coke ;
Pepsi ;
Mr. Pibb ;
Sprite ;
Brainwash ;
espresso ;
lots and lots of espresso ;
crappucino ;
Juice Club ;
perfume ;
}

{
<TimePeriodAgo> 
A long time ago ;
A long, long time ago ;
Yesterday ;
Back when I was a boy ;
Four score and seven years ago ;
When I was your age ;
Just a minute ago ;
Right after listening to the Dead Kennedys ;
Upon the eve of my discontent ;
One bright day in the middle of night ;
The day before next Sunday ;
Three days ago tomorrow ;
}

{
<FutureThingy> 
will never ;
will always ;
will seldom ;
will frighteningly frequently ;
can't wait to ;
will never, not even if hell freezes over, ;
will never, not even over my dead body, ;
}

{
<PostCommaEnd> 
god bless us all ;
god save us all ;
or I'm <Author> ;
at least not without a <Noun> ;
or until warranty expires ;
at least not until the cows come home ;
since punk is dead ;
}

{
<Work> 
the Bible ;
_Civilization and its Discontents_ ;
"Too Dark Park" ;
"Last Rights" ;
_The Essential <PlainAuthor> _ ;
Michelangelo's David ;
the Communist Manifesto ;
the Miranda Rights ;
_Conference of the Birds_ ;
the U.S. Budget ;
the Worms manual ;
the Pacific Bell Yellow Pages ;
the Everything Pages ;
the ESPN Web Page ;
the Roble Directory ;
Doctor Faustus ;
the Odyssey ;
the Aeneid ;
_Il Inferno_ ;
a bunch of Greek classic novels ;
the token non-European novel ;
the token feminist novel ;
the W2 tax form ;
the Far Side ;
}

{
<TimePeriod> 
Enlightenment ;
Rennaissance ;
Middle Ages ;
Industrial Age ;
Restoration ;
Reign of Spain ;
Crusades ;
Classical Period ;
Modern Age ;
publication run of <Work> ;
}

{
<Exclamation> 
What the Hell? ;
Shoot! ;
Good God in <Place> ! ;
Oh, no! ;
Look out! ;
Gezundheit! ;
Wheee! ; 
What!? ;
What are you talking about!? ;
Wha... wha... wha... who? ;
Geronimo! ;
}

{
<Adjective> 
chiastic ;
purple ;
slimy ;
authoritative ;
nefarious ;
egregious ;
gregarious ;
firm ;
rhetorical ;
reasonable ;
}

{
<QuantityEds> 
hundreds ;
thousands ;
tens ;
tons ;
a whole bunch ;
a plethora ;
}
