# PREFIX NOTATION CALCULATOR

This Racket program calculates prefix notations.

## INSTALLATION
Prerequisites
  - Racket/DrRacket
Setup
  - Save the code as calculator.rkt
  - Run from command line or DrRacket

## USAGE
Interactive mode: "racket calculator.rkt"

Batch mode: "racket calculator.rkt -b" or "racket calculator.rkt --batch"

No prompts are shown with batch mode, only results

Exiting the program
  - Type "quit" to exit
  - Press "Ctrl+D" to exit
  - Press "Ctrl+C" to force quit 

## Supported Operations 
"+" - Addition: + 1 2 = 3

"-" - Negation: - 5 = - 5

"*" - Multiplication: * 2 3 = 6

"/" - Division: / 4 2 = 2

## History References
History references using $n syntax

History IDs:
  - Start at 1
  - Increment with each successful calculation
  - Not affected by errors

## Examples
Basic Usage

\> + 1 2

1: 3.0

\> * 5 6

2: 30.0

Using History

\> + 10 20

1: 30.0

\> * $1 2

2: 60.0

Nested Expressions

\> + * 2 3 4

1: 10.0
