/*
  CS programming assignment grading grammar
  Hiroshi Ishii <hishii@cs.stanford.edu> CS193d TA Summer 2000
  2000-jul-9 created
*/


{
<start>
  Hey there, <intro> <correctness> <style> <final-grade> <final-comments> ;
}

{
<intro>
  I looked over your assignment and the README file. ;
}

{
<correctness>
  <your-program-sucks> <why-it-sucks> <take-off-points> <correctness> ;
  <your-program-sucks> <why-it-sucks> <take-off-points> ;
}


{
<your-program-sucks>
  Your program is incomplete. ;
  Your program doesn't compile. ;
  Your program doesn't work at all. ;
  Your program doesn't work on the boundary cases. ;
  Your program crashes. ;
  Your program crashes X-windows. ;
  Your program crashes the operating system. ;
  Your program crashes the entire cluster. ;
  <where-in-program> you're dereferencing a null pointer. ;
  <where-in-program> you're returning a reference to a local variable. ;
  <where-in-program> you're binding a member reference variable to a temporary object. ;
  <where-in-program> you're using the copy constructor incorrectly. ;
  <where-in-program> you're not freeing memory. ;
  <where-in-program> you're attempting to free memory on the stack. ;
}

{
<where-in-program>
  In the function <function> , ;
  In the file <file> , line <line> , ;
  In the <class> <method> , ;
}

{
<function>
  main() ;
  setupGlobalVariables() ;
  printGreeting() ;
  getAllElements() ;
  getFirst() ;
  doLoop() ;
}

{
<file>
  main.cc ;
  ListNode.h ;
  Parser.cc ;
}

{
<line>
  1 ;
  2 ;
  3 ;
  10 ;
}

{
<class>
  DArray ;
  MyString ;
  ListNode ;
  RBTree ;
  Parser ;
  ParserFactory ;
  Shape ;
  Color ;
}

{
<method>
  default constructor ;
  copy constructor ;
  destructor ;
  assignment operator ;
  input operator ;
  output operator ;
}

{
<style>
  <your-style-sucks> <why-it-sucks> <take-off-points> <style> ;
  <your-style-sucks> <why-it-sucks> <take-off-points> ;
}

{
<your-style-sucks>
  Your comments are too sparse. ;
  Your identifier names are not descriptive. ;
  Your naming convention is cryptic. ;
  All your code is in one function. ;
  Your classes are exposing too much of their implementation. ;
}

{
<why-it-sucks>
  This is a pretty serious error. ;
  This means that you're not understanding the concepts covered in class. ;
  This doesn't really matter but I believe it is bad. ;
  This was not covered in class but you are responsible for reading up on it on your own. ;
  This is something you should have learned in CS106. ;
}


{
<take-off-points>
  For this, I'm taking off <points> points. ;
}

{
<points>
  1 ;
  2 ;
  3 ;
  4 ;
  5 ;
  10 ;
  20 ;
  a lot of ;
}

{
<final-grade>
  Therefore, I'm giving you a final grade of <grade> /100. ;
}

{
<grade>
  45 ;
  50 ;
  55 ;
  60 ;
}

{
<final-comments>
  <beat-dead-horse> <soften-the-blow> <uncalled-for-insult> ;
}

{
<soften-the-blow>
  Before you get too depressed about your grade, keep in mind that <shallow-sympathy> . ;
}

{
<shallow-sympathy>
  at least five other submissions received a grade under 60/100 ;
  not everyone is cut out to be a programmer ;
  programming is a skill which takes years to develop ;
  it's never too late to be a <easy-major> major ;
  at least you'll be making much more money than those <useless-major> majors ;
  I'm sure <sympathetic-party> will give you credit for effort ;
}

{
<sympathetic-party>
  Jerry ;
  the other TAs ;
  your parents ;
  your advisor ;
}

{
<easy-major>
  communications ;
  economics ;
  pre-law ;
  pre-med ;
  biology ;
  chemistry ;
}

{
<useless-major>
  philosophy ;
  literature ;
  history ;
  geology ;
  art ;
  physics ;
  mathematics ;
}


{
<beat-dead-horse>
  Judging from your submission, I think that <criticize-programming-skills> . ;
}

{
<criticize-programming-skills>
  you don't understand pointers ;
  you don't understand copy constructors ;
  you don't understand the concept of OOP ;
  you don't understand the concept of modular programming ;
  you should go back and study C again ;
  there are fundamental flaws in the design of your program ;
  you need to improve your debugging skills ;
  you never tested your program on UNIX ;
  your code looks like badly-written Fortran code ;
  we're failing to teach you properly ;
}

{
<uncalled-for-insult>
  Just to let you know, <insult> . ;
}

{
<insult>
  sometimes it's easier to look things up in a book than to ask the TAs ;
  they sell cell phones that vibrate instead of beep ;
  some questions are best asked after class instead of during ;
  personal hygiene is important when you deal with people ;
  not everyone likes to hear about your personal problems ;
  the other students have asked if you could watch the lectures from home instead of coming into class ;
}

