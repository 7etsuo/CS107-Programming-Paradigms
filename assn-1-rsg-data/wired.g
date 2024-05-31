Posted-Date: Wed, 16 Oct 1996 22:51:50 -0700 (PDT)
X-Sender: offsky@pobox1.stanford.edu
In-Reply-To: <199610162248.PAA09289@monolith.Stanford.EDU>
Date: Wed, 16 Oct 1996 22:52:04 -0800
To: zelenski@CS.Stanford.EDU
From: Jake Olefsky <offsky@leland.Stanford.EDU>
Subject: New Grammar

I found a grammar on the internet by Dawson Dean.  It makes random Wired
phrases.  They sound just like they're coming out of the actual magazine.
If you've ever read the magazine, then this will make sense.  I had to
reformat the entire grammar to conform to the cs107 grammar files.  I also
took out a bunch of productions that didn't work, and I added a few as
well.  Enojoy!

-Jake Olefsky
offsky@leland.stanford.edu

-----------Start Grammar-----------

{
<start>
<ADJECTIVE> <TRENDY-TECH-THING> the <ADJECTIVE> <ROLE> of <PLACE> . ;
<ADJECTIVE> <TRENDY-TECH-THING> <CHANGE-VERB> the <ADJECTIVE> <ROLE> of
<PLACE> . ;
}

{
<ADJECTIVE>
wired    			;
wild    			;
hot    				;
cool    			;
vital    			;
optical    			;
up-to-the-nanosecond    	;
technologically unrivalled    	;
way new    			;
grunge    			;
radical    			;
decentralized    		;
immersive    			;
planetwide    			;
speech-driven    		;
savvy    			;
incandescent    		;
cross-cultural    		;
cyber    			;
techno    			;
cutting-edge    		;
silicon    			;
interactive    			;
integrated    			;
object-oriented    		;
world-beat    			;
innovative    			;
constantly evolving    		;
ultra modern    		;
cellular    			;
ubiquituous    			;
fiber    			;
tribal    			;
holographic    			;
online    			;
wireless    			;
cable    			;
}

{
<TRENDY-TECH-THING>
<TRENDY-TECH-THING-SINGULAR> is    	;
<TRENDY-TECH-THING-PLURAL> are    	;
}

{
<TRENDY-TECH-THING-SINGULAR>
3D animation    				;
virtual reality    				;
video    					;
cash    					;
wavelet compression    				;
fractal encryption    				;
middleware    					;
content   					;
media    					;
bandwidth    					;
intranetworking    				;
TV    						;
data    					;
CDROM    					;
VRML    					;
spamming    					;
telecommuting    				;
look and feel    				;
haptic holography    				;
embroidered circuitry    			;
}

{
<TRENDY-TECH-THING-PLURAL>
nano-robots    					;
zines    					;
MUDs    					;
set-top boxes    				;
PDAs    					;
applets    					;
neural nets    					;
PCs    						;
content providers    				;
viruses    					;
content streams    				;
prototypes    					;
wearable networks    				;
internet firewalls    				;
neighborhood nets    				;
remembrance agents    				;
augmented realities    				;
genetic algorithms    				;
}

{
<ROLE>
fringe    					;
future    					;
frontier   				 	;
medium    					;
discourse    					;
cyberstation    				;
genetic blueprint    				;
real-time nervous system    			;
reinterpretation    				;
BPM    						;
mothership    					;
espresso    					;
dynamic    					;
signpost    					;
}

{
<PLACE>
the infobahn    		;
cyberspace    			;
technopolis    			;
Hollywired    			;
the <PLACE-ADJ> <PLACE-NAME>   	;
the <PLACE-ADJ> <PLACE-NAME>   	;
the <PLACE-ADJ> <PLACE-NAME>   	;
the <PLACE-ADJ> <PLACE-NAME>   	;
the <PLACE-ADJ> <PLACE-NAME>   	;
the <PLACE-ADJ> <PLACE-NAME>   	;
}

{
<PLACE-ADJ>
digital    					;
next <ADJECTIVE>    				;
global    					;
hyper    					;
information    					;
massively parallel    				;
dub    						;
virtual    					;
broadband    					;
knowledge    					;
}

{
<PLACE-NAME>
space    					;
renaissance    					;
revolution    					;
millennium    					;
village    					;
highway    					;
horizon    					;
rave    					;
chill-out room    				;
modalities    					;
environment    					;
community    					;
third wave    					;
consciousness    				;
world    					;
net    						;
web    						;
cybertribe    					;
piazza    					;
paradigm    					;
fashion    					;
zeitgeist    					;
millenium    					;
metamorphosis    				;
}

{
<CHANGE-VERB>
surfing    					;
riffing    					;
spinning    					;
trailblazing    				;
illuminating    				;
channeling    					;
evolving into    				;
morphing into    				;
mutating into    				;
jacking into    				;
rebooting    					;
exploding into    				;
hacking    					;
transforming    				;
flowing into    				;
fast-tracking    				;
streaming into    				;
transcending    				;
wiring    					;
downloaded into    				;
}


