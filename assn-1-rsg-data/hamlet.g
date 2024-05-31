
A REALLY random sentence generator.  It's been said that if you put
the monkeys in the room with the typewriter, eventually Hamlet comes
out but it will take a lot of RSG runs before you get there :-)

This grammars seems to want spaces between tokens off during output,
but that isn't the way the program specs read....

X-Mailer: Microsoft Outlook Express for Macintosh - 4.01 (295) 
Date: Sat, 24 Oct 1998 14:05:05 -0700
Subject: Grammar file: Hamlet 0.1
From: "JCN" <jcn@stanford.edu>
To: zelenski@CS.Stanford.EDU
X-Priority: 3

Run this enough times and it will print out Hamlet.
{
<start>
HAMLET by a random monkey:
0000000000 Act I: <act>
0000000000 Act II: <act>
0000000000 Act III: <act>
0000000000 Act IV: <act>
0000000000 Act V: <act> ;
}
{
<act>
00000 Scene 1: <scene>  00000 Scene 2: <scene>  00000 Scene 3: <scene>  00000 Scene 4: <scene>  00000 Scene 5: <scene> ;
00000 Scene 1: <scene>  00000 Scene 2: <scene>  00000 Scene 3: <scene>  00000 Scene 4: <scene> ;
00000 Scene 1: <scene>  00000 Scene 2: <scene>  00000 Scene 3: <scene>  00000 Scene 4: <scene> ;
00000 Scene 1: <scene>  00000 Scene 2: <scene>  00000 Scene 3: <scene>  00000 Scene 4: <scene> ;
00000 Scene 1: <scene>  00000 Scene 2: <scene>  00000 Scene 3: <scene> ;
00000 Scene 1: <scene>  00000 Scene 2: <scene>  00000 Scene 3: <scene> ;
00000 Scene 1: <scene>  00000 Scene 2: <scene>  00000 Scene 3: <scene> ;
00000 Scene 1: <scene>  00000 Scene 2: <scene>  00000 Scene 3: <scene> ;
00000 Scene 1: <scene>  00000 Scene 2: <scene> ;
00000 Scene 1: <scene>  00000 Scene 2: <scene> ;
00000 Scene 1: <scene>  00000 Scene 2: <scene> ;
00000 Scene 1: <scene>  00000 Scene 2: <scene> ;
00000 Scene 1: <scene>  00000 Scene 2: <scene> ;
}
{
<scene>
<char> <lines> <scene> ;
<char> <lines> <scene> ;
<char> <lines> ;
}
{
<lines>
<begin_line> <lines> ;
<begin_line> ;
}
{
<begin_line>
<capital_word> <line> ;
}
{
<capital_word>
<capital_letter> <rest_of_word> ;
}
{
<capital_letter>
A ;
B ;
C ;
D ;
E ;
F ;
G ;
H ;
I ;
J ;
K ;
L ;
M ;
N ;
O ;
P ;
Q ;
R ;
S ;
T ;
U ;
V ;
W ;
X ;
Y ;
Z ;
}

{
<line>
<word> <line> ;
<word> <line> ;
<word> <line> ;
<word> <line> ;
<word> <line> ;
<word> . ;
}
{
<char>
Hamlet: ;
Ophelia: ;
Claudius: ;
Polonius: ;
Fortinbras: ;
}
{
<word>
<begin_letter> <rest_of_word> ;
}
{
<rest_of_word>
<letter> <rest_of_word> ;
<letter> ;
}
{
<letter>
a ;
b ;
c ;
d ;
e ;
f ;
g ;
h ;
i ;
j ;
k ;
l ;
m ;
n ;
o ;
p ;
q ;
r ;
s ;
t ;
u ;
v ;
w ;
x ;
y ;
z ;
}
{
<begin_letter>
a ;
b ;
c ;
d ;
e ;
f ;
g ;
h ;
i ;
j ;
k ;
l ;
m ;
n ;
o ;
p ;
q ;
r ;
s ;
t ;
u ;
v ;
w ;
x ;
y ;
z ;
}

