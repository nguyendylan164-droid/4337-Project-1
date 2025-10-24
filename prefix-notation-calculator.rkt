#lang racket

(define interactive?
 (let ([args (vector->list (current-command-line-arguments))])
  (not (or (member "-b" args)
           (member "--batch" args))))
  )

; helper function to skip whitespace characters from the front of the list
(define (skip-whitespace chars)
  (cond
    ; if the list is empty then return an empty list
    [(null? chars) '()]
    ; if the character is a whitespace then skip it and recursively check the rest
    [(char-whitespace? (car chars))
     (skip-whitespace (cdr chars))]
    ; else return the list 
    [else chars]))
  

; parse a number
; returns a pair
(define (parse-number chars)
  (let loop ([chars chars]
             [acc '()])
    (cond
      ; Case 1: we ran out of characters
      [(null? chars) 
       ; if we collected nothing, parsing failed
       (if (null? acc) 
           #f 
           ; else try to convert accumulated chars to a number
           (let ([num (string->number (list->string (reverse acc)))])
             (if num (cons num '()) #f)))]
      
      ; Case 2: first character is minus
      [(and (null? acc) (char=? (car chars) #\-))
       ; minus to accumulator
       (loop (cdr chars) (cons #\- acc))]
      
      ; Case 3: current character is a number
      [(char-numeric? (car chars))
       (loop (cdr chars) (cons (car chars) acc))]
      
      ; Case 4: current character is a decimal point
      [(char=? (car chars) #\.)
       (loop (cdr chars) (cons #\. acc))]
      
      ; Case 5: current character is nothing
      [else
       ; end loop
       (if (null? acc)
           #f
           ; convert what we have to a number
           (let ([num (string->number (list->string (reverse acc)))])
             (if num (cons num chars) #f)))])))
    

; history reference
; returns history-value and remaining-chars or #f for error
(define (parse-history chars history)
  ; check if we have $
  (if (and (not (null? chars)) (char=? (car chars) #\$))
      (let ([result (parse-number (cdr chars))])
        (if result ; we got a number
            ; extract the id and remaining chars
            (let ([id (car result)] ; the history id num
                  [remaining (cdr result)]) ; remaining after id
              ; id has to be a positive int
              (if (and (integer? id) (positive? id))
                  ; reverse history list b/c most recent is first b/c of cons
                  (let ([hist-list (reverse history)])
                    ; check if id is valid
                    (if (<= id (length hist-list))
                        ; get the value at pos id-1
                        (cons (list-ref hist-list (- id 1)) remaining)
                        #f)) ; id out of bounds
                  #f)) ; id isn't a positive int
            #f)) ; couldn't parse a num after $
      #f)) ; first char wasn't $
  
; parse and evaluate prefix expression recursively
; prefix notation: operator comes first, then operands
; returns result-value and remaining-chars or #f for error
(define (parse-expression chars history)
  (let ([chars (skip-whitespace chars)]) ; skip any leading ws
    (cond
      [(null? chars) #f] ; if no character left
      ; case: addition
      [(char=? (car chars) #\+)
       ; parse first expression
       (let* ([expr1 (parse-expression (cdr chars) history)])
         (if expr1 ; if successful
             ; parse second expression
             (let ([expr2 (parse-expression (cdr expr1) history)])
               (if expr2
                   ; return sum and remaining chars
                   (cons (+ (car expr1) (car expr2)) (cdr expr2))
                   #f))
             #f))]
      ; case: multiplication
      [(char=? (car chars) #\*)
       (let* ([expr1 (parse-expression (cdr chars) history)])
         (if expr1
             (let ([expr2 (parse-expression (cdr expr1) history)])
               (if expr2
                   (cons (* (car expr1) (car expr2)) (cdr expr2))
                   #f))
             #f))]

      ; case: division
      [(char=? (car chars) #\/)
       (let* ([expr1 (parse-expression (cdr chars) history)])
         (if expr1
             (let ([expr2 (parse-expression (cdr expr1) history)])
               (if expr2
                   (if (zero? (car expr2))
                       #f
                       (cons (quotient (car expr1) (car expr2)) (cdr expr2)))
                   #f))
             #f))]

      ; case: subtraction
      ; does both unary negation and the start of the negative number
      [(char=? (car chars) #\-)
       ; look at next char after skipping ws
       (let ([peek-next (skip-whitespace (cdr chars))])
         ; if next char is a digit or another minus
         (if (and (not (null? peek-next))
                  (or (char-numeric? (car peek-next))
                      (and (char=? (car peek-next) #\-))))
             ; could be a number like -5 or -3.14
             ; we try parsing as a number first
             (let ([num-result (parse-number chars)])
               (if num-result ; parsed as a number sucessfully
                   num-result
                   ; not valid number then treat as unary 
                   (let ([expr (parse-expression (cdr chars) history)])
                     (if expr
                         (cons (- (car expr)) (cdr expr))
                         #f))))
             ; has to be unary negation
             (let ([expr (parse-expression (cdr chars) history)])
               (if expr
                   ; return negated value and remaining chars
                   (cons (- (car expr)) (cdr expr))
                   #f))))]

      ; case: history reference
      [(char=? (car chars) #\$)
       (parse-history chars history)]

      ; case: must be a number b/c no operator matched
      [else (parse-number chars)])))
      
                     
             
  

; evaluate the prefix expression from a string by parsing
; returns result or #f for error
(define (evaluate-expression str history)
  ; convert string into list of characters
  (let* ([chars (string->list str)]
         [result (parse-expression chars history)]) ; parse the expression
    ; check if parsing worked
    (if result
        (let ([remaining (skip-whitespace (cdr result))])
          (if (null? remaining)
              (car result) ; success
              #f))
        #f)))
  

; main loop
(define (repl history)
  (when interactive? (display "> ")) ; when interactive is true
  (let ([input (read-line)])
    (cond
      [(eof-object? input) (void)] ; if input is end of file then return void
      [(equal? input "quit") (void)] ; if user types quit then return void
      [else
       (let ([result (evaluate-expression input history)])
         (if result
             ; assign variables
             (let* ([new-history (cons result history)]
                    [id (length new-history)]
                    [output (real->double-flonum result)])
               ; display results
               (display id)
               (display ": ")
               (displayln output)
               (repl new-history))
             (begin
               (displayln "Error: Invalid Expression")
               (repl history))))])))

; start program begin with empty list
(repl '())