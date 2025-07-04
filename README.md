Coding Exercise 
 
Situation: 
The group has been asked to develop software to score bowling games. 
The hardware team is working on integrating with the pinsetter. The graphics team is 
hard at work on some cheesy 3D animations. 
 
The dev team has decided to split up the work. Alice will be working on a module that 
counts up the pins knocked down in the individual rolls and indicates fouls, splits, etc. 
Bob will be working on displaying the scorecard. 
 
Your Task: 
You've been asked to write a calculator to sum an individual player's rolls 
and  return  their  score  for  each  frame.  The  method  should  accept  an  array  of  rolls. 
Possible  values  include  zero  through  nine,  a  "/"  indicating  a  spare,  and  an  "X" 
indicating a strike. The return value should be an array of scores for the frames the 
player has bowled. 
 
Scoring:
The scoring method will be used to calculate a player's running score during 
the game, so it's important that the method works for games in progress. For example, 
[4,  5,  "X",  8]  should  return  [9,  nil,  nil],  since  the  second  and  third  frames  can't  be 
calculated  yet.  
When  the  second  roll  of  the  third  frame  comes  in,  all  three  frames 
should be returned, e.g. [4, 5, "X", 8, 1] would return [9, 19,  9]. (Note that these are 
the scores for the frames, not the running score).

## Setup
This repo contains my solution for the given task. The solution includes corresponding `rspec` tests. 
To run the tests and check the solution after cloning, you can run:
```
bundle install
rspec
```
