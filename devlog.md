Session 0 - 
10/13/2025
11:54 AM 

As far as I understand, this project is creating a prefix-notation calculator using Racket, which is a functional programming language. I can choose to run the program in two modes: interactive and batch. Currently, I plan on running the program in interactive mode first, in order to test expressions. Once interactive mode works, I plan to switch to batch mode.


Session 1 - 
10/14/2025
3:48 PM

I plan to lay out the functions I will need and work on them one by one. I'm choosing to start with implementing the main loop and "evaluate-expression" function, which will do the actual calculations.

11:12 PM

This session, I failed to meet my goal of implementing the main loop and "evaluate-expression" function. Transitioning from programming in imperative languages to a functional language is proving difficult, because they are more different than I thought. Next session, I plan to better familiarize myself with racket by watching videos and following the Racket guide.


Session 2 - 
10/15/2025
10:51 AM

This session, I plan to better familiarize myself with Racket before I actually start working on the project.
At the same time, I am going to brainstorm my functions.

2:15 PM

I watched some videos on racket and I was able to finished my main loop even though it wasn't a part of the goal. Next, I plan to implement the calculation functions, which I think will be the hardest part.


Session 3
10/16/2025
3:45 PM

I am going to start implementing the calculation functions. I'm starting with the "evaluate-expression" and then laying out the other functions that I will need with "evaluate-expression".

10/16/2025
8:47 PM

I finished the "evaluate-expression" function and laid out more functions: "parse-expression" and "skip-whitespace". Next session, I will finish the "parse-expression" and "skip-whitespace" functions.


Session 4
10/17/2025
7:04 PM

I am going to start on the "parse-expression", which will actually do the calculations, and finish "skip-whitespace". I am also going to layout my final functions "parse-number" and "history". So far, my project has been coming along smoothly, and it seems that the end is nearing.

10:41 PM

I finished my "skip-whitespace" function, but I didn't finish my "parse-expression", because I think it would be a better idea to do "parse-number" first, because "parse-expression" relies on "parse-number". Therefore, next session I plan to finish my "parse-number" function and then start on "parse-expression".


Session 5
10/20/2025
7:41 PM

I am nearing the end of the project, and so far it has gone smoothly. For this session, I'm going to finish "parse-number" and start on "parse-expression". I also want to run tests before I start the "parse-history" function in order to ensure everything is working properly.

10/21/2025
1:42 PM

I finished "parse-number", however I only got started on "parse-expression". "parse-expression" will take me a whole section to finish since it has a lot of cases (+,-,*,/). Next session I am going to finish "parse-expression" and run tests. If I have enough time, I will finish up “parse-history”. 


Session 6
10/23/2025
5:55 PM

This should be my final session, since the due date is tomorrow. Today, I plan on finishing the whole project (I only have "parse-expression and "parse-history" left) and running tests to ensure everything works. If necessary, I will set aside some time to debug in case I run into any bugs while testing. 

6:07 PM

So far, I've completed addition, multiplication, and division for "parse-expression" since they follow the same structure and logic with minor changes. I've held off on subtraction until the end because "-" could mean unary negation or the start of a negative number. I am going to work on a solution where the subtraction case will do both. 

6:48 PM

My way of doing subraction is by adding a negative number, EX: "+ 3 -1 = 2". Now, my "parse-expression" function is finished, but I have yet to implement the history reference. I tested the program without history, and I had some syntax errors, but now it seems to be working well with the expected outputs. Finally, I will finish the history reference and run tests. 

9:25 PM

I have finished "parse-history" and run tests. My program is now complete. All that's left for me is to create the README. My closing thoughts are that this project has taught me a lot about coding in a functional language. In the beginning, I had a lot of trouble implementing the prefix notation calculator logic functionally. However, once I got a better understanding by watching videos and reading books, I was able to finish this project.

