
Scott Kleper's "Microsoft press announcement" grammar
------------------------------------------------------

Posted-Date: Fri, 26 Apr 1996 03:48:13 -0700 (PDT)
Subject: micropress.g
Date: Fri, 26 Apr 96 03:47:39 +0100
From: <klep@leland.Stanford.EDU>
To: "Julie Zelenski" <zelenski@cs.Stanford.EDU>

Here's a grammar I used to test my program. I should mention that my 
program has slight problems with output, although it works fine with this 
grammar. I had planned on expanding this, but ran out of time so it's not 
all that interesting, but kind of cute.

-Scott
--------------------------------------------------------------------------
Microsoft Press Release Grammar
by Scott J. Kleper (klep@leland.stanford.edu)
{
<start>
<attention-getter> <product> <info>	;
}

{
<attention-getter>
<headline> <catch-phrase> ;
<headline> For immediate release. ;
}

{
<headline>
Microsoft Revolutionizes the Computer Industry! ;
Bill Gates Does it Again! ;
Attention Stockholders! ;
}

{
<catch-phrase>
Have you ever wanted to <something-glorifying> ? ;
Microsoft will let you <something-glorifying> . ;
}

{
<something-glorifying>
surf the internet  ;
explore strange new worlds ;
abuse the power of your computer ;
explore the limitations of the human mind ;
go spelunking on the lunatic fringe ;
}

{
<product>
Microsoft announces <pname> <pversion> for <psys> . ;
Bill Gates today demonstrated the all new <pname> <pversion> for <psys> . ;
}

{
<pname>
Microsoft Word ;
Microsoft Zeus ;
MS-DOS ;
Microsoft Project ;
Microsoft Excel ;
}

{
<pversion>
2.0 ;
55.0.1 ;
3.1.2.3dr7 ;
0.0.0.1r ;
}

{
<psys>
Windows ;
Macintosh ;
UNIX ;
VAX/VMS ;
UNIVAC ;
IBM PC Jr. ;
Atari ;
BeBox ;
}

{
<info>
The software will enter beta testing in 1999. ;
The release date has been extended until the next millenium. ;
Bill Gates expects it to be the best thing since Microsoft Bob. ;
}


------
Scott J. Kleper                              Don't Panic!
klephacks@kagi.com                           ,http://htc.rit.edu/scott.html

Author of HTML Markup, the complete text-to-html experience:
<,http://htc.rit.edu/klephacks/markup.html> 
<,ftp://htc.rit.edu/pub/HTML-Markup-current.hqx>


