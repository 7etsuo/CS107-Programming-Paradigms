Date: Mon, 28 Apr 1997 20:10:15 -0700 (PDT)
From: Travis James Kopp <tkopp@leland.Stanford.EDU>
Sender: tkopp@leland.Stanford.EDU
To: zelenski@CS.Stanford.EDU
Subject: I have no life (new grammar)

Grammar for a random math expression

{
<start>
( <start> <operator> <start> ) ;
<single> ;
}

{
<operator>
+ ;
- ;
* ;
/ ;
^ ;
}

{
<single>
<variable> ;
<number> ;
}

{
<variable>
x ;
x ;
y ;
y ;
z ;
z ;
a ;
b ;
c ;
}

{
<number>
<constant> ;
<integer> ;
}

{
<constant>
e ;
pi ;
i ;
}

{
<integer>
2 ;
3 ;
4 ;
5 ;
6 ;
7 ;
8 ;
9 ;
<large-int> ;
}

{
<large-int>
17 ;
28 ;
36 ;
49 ;
73 ;
89 ;
187 ;
598 ;
2739918 ;
}

