-----------------------------------------------------------

Note from Julie: The <blank> non-terminal in this grammar requires that
your program handle the possibility of the empty production- a production with
zero words. Your program is supposed to deal with this, it just means that
the non-terminal then expands to nothing, this allows for an optional
expansion. If you have trouble with grammar and not others, it might be
because you didn't handle this case correctly.



------------------------------------------------------------
From: hughescr@leland.Stanford.EDU (Craig R. Hughes)

Here's a grammar I essentially transcribed from a nifty Mac GNUware
program.  I haven't checked it very thoroughly, so it may be that it has a
bunch of typos, etc. in it.  Anyway, it's GNUware, so I guess maybe I
should say that at the top....

This grammar is extracted from the STR# resources of a GNUware program for
the Mac called Kant Generator.  (source available on info-mac and its
mirrors).  Feel free as heck to copy/reuse/etc. any or all of this, because
that is what it is for.  The only condition if you do use it is that this
same condition apply to anything you use it in.  Check the GNU licence for
details.

{
<conjunction> 
and	;
but	;
yet	;
}

{
<quantity> 
all of	;
some of	;
none of	;
}

{
<philosopher> 
Aristotle	;
Hume	;
Galileo	;
Locke	;
}

{
<reason-type> 
pure	;
practical	;
human	;
natural	;
}

{
<knowledge-type> 
a priori	;
a posteriori	;
possible	;
actual	;
}

{
<object-type> 
intelligible	;
transcendental	;
empirical	;
abstract	;
}

{
<logic-type> 
general	;
applied	;
pure	;
formal	;
first order	;
transcendental	;
}

{
<rule-type> 
universal	;
necessary	;
practical	;
contradictory	;
sufficient	;
}

{
<start> 
<paragraph> 
<paragraph> 
<paragraph> 
<paragraph> 
<section-ext> 	;
}

{
<section-ext> 
<paragraph> 	;
<section-ext> 
<paragraph> 	;
}

{
<judgement-type> 
hypothetical	;
problematic	;
analytic	;
synthetic	;
ampliative	;
deductive	;
inductive	;
speculative	;
disjunctive	;
<knowledge-type> 	;
}

{
<sentence>
<opt-intro-clause>  <opt-certainty-clause>  <main-clause>  <opt-proof>  .	;
<opt-two-proof>  <opt-certain-throw-clause>  <main-clause>  <opt-additional-main>  .	;
<opt-two-proof>  <opt-certainty-clause>  <main-clause>  .	;
}

{
<opt-intro-clause> 
<intro-clause>  , 	;
<blank> 	;
}

{
<opt-certainty-clause> 
<certainty-clause>  	;
<blank> 	;
}

{
<opt-two-proof> 
<proof>  , 	;
<blank> 	;
}

{
<opt-certain-throw-clause> 
<certainty-clause>  , <throwaway-clause>  , 	;
<blank> 	;
}

{
<opt-additional-main> 
, <conjunction>  <main-clause> 	;
<blank> 	;
}

This is the production that requires special handling.  It expands to
nothingness, so an empty production.  This may require a little re-writing
of your RSG.

{
<blank> 
	;
}

{
<intro-clause> 
in all theoretical sciences	;
in view of these considerations	;
thus	;
by means of <Ns> 	;
in the study of <Ns> 	;
therefore
with the sole exception of <Ns> 	;
certainly	;
still	;
as I have elsewhere shown	;
on the other hand	;
for these reasons	;
in the case of <Ns> 	;
however	;
in natural theology	;
consequently	;
}

{
<Vpt> 
are what first give rise to	;
have lying before them	;
constitute the whole content for	;
would thereby be made to contradict	;
can not take account of	;
have nothing to do with	;
stand in need to	;
are the clue to the discovery of	;
prove the validity of	;
are just as <rule-type>  as	;
are a representation of	;
exclude the possibility of	;
}

{
<Np> 
the Antinomies	;
the paralogisms	;
the paralogisms of <reason-type>  reason	;
the Categories	;
our sense perceptions	;
our faculties	;
our <judgement-type>  judgements	;
our judgements	;
the objects in space and time	;
the things in themselves	;
natural causes	;
our ideas	;
our <knowledge-type>  concepts	;
our concepts	;
the <object-type>  objects in space and time	;
the objects in spacee and time	;
the noumena	;
the phenomena	;
}

{
<paragraph> 
        <sentence>   <sentence> <opt-sentence> 
<sentence> <opt-question> <opt-sentence> <opt-sentence> <opt-sentence> 
<sentence> <opt-throwaway> 	;
        <sentence>   <sentence> <opt-sentence>   <sentence>   ( <sentence> )
<sentence>   <sentence> <opt-throwaway> 	;
        <sentence>   <sentence> <opt-sentence> 
<sentence> <opt-sentence> <opt-sentence> <opt-sentence>   <sentence> 	;
}

{
<opt-sentence> 
  <sentence> 	;
<blank> 	;
}

{
<opt-throwaway> 
  <throwaway-sentence> 	;
<blank> 	;
}

{
<opt-question> 
  <question> 	;
<blank> 	;
}

{
<opt-confirm> 
 (and <certainty-clause>  this is true),	;
, <throwaway-clause>  ,	;
<blank> 	;
}

{
<opt-throw-intro> 
<throwaway-clause>  ,	;
<intro-clause>  ,	;
<blank> 	;
}

{
<opt-two-throw-intro> 
, <throwaway-clause>  ,	;
, <intro-clause>  ,	;
<blank> 	;
}

{
<main-clause> 
<Ns> <opt-confirm>  <Vst>  <NsNp> 	;
<Ns>  <Vst> <opt-throw-intro>  <NsNp> 	;
<Ns> <opt-two-throw-intro>  <Vsi> 	;
<Np> <opt-confirm>  <Vpt>  <NsNp> 	;
<Np>  <Vpt> <opt-throw-intro>  <NsNp> 	;
<Np> <opt-two-throw-intro>  <Vpi> 	;
}

{
<NsNp> 
<Ns> 	;
<Np> 	;
}

{
<certainty-clause> 
it must not be supposed that	;
there can be no doubt that	;
we can deduce that	;
it is not at all certain that	;
<philosopher>  tells us	;
it remains a mystery why	;
I assert that	;
to avoid all misapprehension, it is necessary to explain that	;
let us suppose that	;
it is obvious that	;
the reader should be careful to observe that	;
what we have alone been able to show is that	;
}

{
<throwaway-clause> 
in so far as this expounds the <rule-type>  rules of <NsNp> 	;
when treated as <NsNp> 	;
in other words	;
in the full sense of these terms	;
insomuch as <Ns>  relies on <Np> 	;
indeed	;
then	;
that is to say	;
even as this relates to <Ns> 	;
in respect of the intelligible character	;
so regarded	;
for example	;
irrespective of all empirical conditions	;
so far as regards <Ns> 	;
so far as regards <Ns>  and <Np> 	;
on the contrary	;
in accordance with the principles of <NsNp> 	;
in reference to ends	;
in particular	;
so far as I know	;
}

{
<proof> 
because of our necessary ignorance of the conditions	;
as is shwon in the writings of <philosopher> 	;
as is proven in the ontological manuals	;
as any dedicated reader can clearly see	;
as is evident upon close examination	;
as will easily be shown in the next section	;
since knowledge of <Np>  is <knowledge-type> 	;
by virtue of <reason-type>  reason	;
as we have already seen	;
since <quantity>  <Np>  are <judgement-type> 	;
because of the relationship between <Ns>  and <Np> 	;
by means of analysis	;
by means of analytic unity	;
}

{
<question> 
Whence comes <Ns>  , the solution of which involves the relation between
<NsNp>  and <NsNp> ?	;
<opt-intro-clause> is it the case that <Ns>  <Vst>  <NsNp>  , or is the real
question whether <Np>  <Vpi> ?	;
Has it ever been suggested the <opt-proof>  <certainty-clause>  there is a
causal connection between <NsNp>  and <NsNp> ?	;
In which of our cognitive faculties are <NsNp>  and <NsNp>  connected together?	;
<conjunction>  can I entertain <Ns>  in thought, or does it present itself to me?	;
}

{
<opt-proof> 
, <proof>  ,	;
<blank> 	;
}

{
<pure-practical> 
pure	;
practical	;
}

{
<Ns> 
the transcendental aesthetic	;
<logic-type>  logic	;
the Ideal of <reason-type>  reason	;
the architectonic of <reason-type>  reason	;
the discipline of <reason-type>  reason	;
the <pure-practical>  employment of <NsNp> 	;
the Ideal	;
the manifold	;
the Transcendental Deduction	;
our experience	;
philosophy	;
metaphysics	;
the thing in itself	;
our understanding	;
our <knowledge-type>  knowledge	;
<reason-type>  reason	;
reason	;
space	;
time	;
the transcendental unity of apperception	;
necessity	;
the never-ending regress in the series of empirical conditions	;
}

{
<Vst> 
is what first gives rise to	;
can thereby determine in its totality	;
has lying before it	;
constitutes the whole content for	;
may not contradict itself, but it is still possible that it may be in
contradiction with	;
woudl thereby be made to contradict	;
teaches us nothing whatsoever regarding the content of	;
can not take account of	;
has nothing to do with	;
stands in need of	;
is the key to understanding	;
proves the validity of	;
is just as necessary as	;
is the clue to the discovery of	;
is a representation of	;
depends on	;
excludes the possibility of	;
}

{
<Vsi> 
is the mere result of the power of <Ns>  , a blind but indispensable function
of the soul	;
occupies part of the sphere of <Ns>  concerning the existence of <Np>  in general	;
is by its very nature contradictory	;
would be falsified	;
abstracts from all content of <knowledge-type>  knowledge	;
is a body of demonstrated doctrine, and <quantity>  it must be known
<knowledge-type> 	;
can never furnish a true and demonstrated science, because, like <Ns>  , it
<Vst>  <judgement-type>  principles	;
can be treated like <NsNp> 	;
shoudl only be used as a canon for <NsNp> 	;
exists in <NsNp> 	;
}

{
<Vpi> 
are the mere results of the power of <Ns>  , a blind but indispensible
function of the soul	;
occupy part of the sphere of <Ns>  concerning the existence of <Np>  in general	;
are by their very nature contradictory	;
would be falsified	;
abstract from all content of <knowledge-type>  knowledge	;
constitute a body of demonstrated doctrine, and <quantity>  this body must
be known <knowledge-type> 	;
can never, as a whole, furnish a true and demonstrated science, because,
like <Ns>  , they <Vpt>  <judgement-type>  principles	;
can be treated like <NsNp> 	;
should only be used as a canon for <NsNp> 	;
exist in <NsNp> 	;
}

{
<throwaway-sentence> 
But we have fallen short of the necessary interconnection that we have in
mind when we speak of <NsNp> .	;
We thus have a pure synthesis of apprehension.	;
And similarly with all the others.	;
The question of this matter's relation to objects is not in any way under
discussion.	;
This distinction must have some ground in the nature of <NsNp> .	;
The divisions are thus provided, all that is required is to fill them.	;
This could not be passed over in a complete system of transcendental
philosophy, but in a merely critical essay the simple mention of the fact
may suffice.	;
This is not something we are in a position to establish.	;
This is the sense in which it is to be understood in this work.	;
But this need not worry us.	;
Let us apply this to <Ns> .	;
But to this matter no answer is possible.	;
But the proof of this is a task from which we can here be absolved.	;
But at present we shall turn our attention to <Ns> .	;
This may become clear with an example.	;
I feel I have sufficiently shown this to be true.	;
This is what chiefly concerns us.	;
On this matter, what has been said already should in any case suffice by
itself.	;
In my present remarks I am referring to <Ns>  only in so far as it is
founded on <judgement-type>  principles.	;
But this is to be dismissed as random grouping.	;
}

-------------END CUT HERE-----------------

There.  The only down-side to this is that the original program was a
little cleverer than the one in the assignment, and it did things like
capitalise first letters of setences, etc.  It also had a more flexible
grammar structure, so I've had to approximate the original grammar
somewhat, and add a few non-terminals.  Also, it is unclear whether the
assignment's grammar structure allows for empty productions.  I guess they
should be OK, so I'll have to rewrite my current program somewhat.  sigh.
Anyway, if they are/should be allowed, change the production for <blank> 
above accordingly.

Craig.

/-----------------------------------------------------\
|Craig Hughes                    Financial Manager,   |
|PO Box 10496,                   Rm.201, Hammarskjold,|
|Stanford, CA 94309,             Stanford, CA 94305,  |
|USA                             USA                  |
|<A HREF="http://craig.stanford.edu/"> Craig Hughes</A> |
\-----------------Tel: (415) 497-6991-----------------/



