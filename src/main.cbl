       IDENTIFICATION DIVISION.
       PROGRAM-ID. CRUNCH.
       AUTHOR. theluqmn.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT POSITION-FILE ASSIGN TO "position"
               ORGANIZATION IS INDEXED
               ACCESS IS DYNAMIC
               RECORD KEY IS POSITION-ID
               FILE STATUS IS FS-POSITION.

       DATA DIVISION.
       FILE SECTION.
       FD POSITION-FILE.
       01 POSITION-RECORD.
           05 POSITION-ID PIC X(10).
           05 POSITION-NAME PIC X(20).
           05 POSITION-SALARY PIC 9(10).
       WORKING-STORAGE SECTION.
       01 CLI-INPUT PIC X(32).
       01 FS-POSITION PIC XX.
       01 COUNTER PIC 9(5).

       PROCEDURE DIVISION.
       DISPLAY "CRUNCH - human resource management done right".
       DISPLAY " ".
       DISPLAY "run 'help' for list of available commands.".
       DISPLAY "run 'setup' if this is the first time.".
       PERFORM PROCEDURE-MAIN.
       CLI-HANDLER.
           DISPLAY "---------------------------------------------".
           DISPLAY "> " WITH NO ADVANCING.
           ACCEPT CLI-INPUT.
           IF CLI-INPUT = "setup" THEN
               PERFORM PROCEDURE-SETUP
           ELSE IF CLI-INPUT = "position" THEN
               PERFORM PROCEDURE-POSITION
           ELSE IF CLI-INPUT = "position-add" THEN
               PERFORM POSITION-ADD
           ELSE IF CLI-INPUT = "position-list" THEN
               PERFORM POSITION-LIST
           ELSE IF CLI-INPUT = "exit" THEN
               DISPLAY "exiting..."
           ELSE
               DISPLAY "unknown command entered"
           END-IF.
       PROCEDURE-SETUP.
           DISPLAY "---------------------------------------------".
           DISPLAY "SETUP CRUNCH".
           DISPLAY " ".

           OPEN OUTPUT POSITION-FILE.
           CLOSE POSITION-FILE.

           DISPLAY "(1/1) position file created".
           DISPLAY "setup complete".
       PROCEDURE-POSITION.
           DISPLAY "---------------------------------------------".
           DISPLAY "POSITION OVERVIEW".
           DISPLAY " ".
           DISPLAY "[position-add]     add a new position.".

           POSITION-ADD.
           DISPLAY "---------------------------------------------".
           DISPLAY "ADD A NEW POSITION".
           DISPLAY " ".
           DISPLAY "(1/3) id:          " WITH NO ADVANCING.
           ACCEPT POSITION-ID.
           DISPLAY "(2/3) name:        " WITH NO ADVANCING.
           ACCEPT POSITION-NAME.
           DISPLAY "(3/3) base salary: " WITH NO ADVANCING.
           ACCEPT POSITION-SALARY.

           OPEN I-O POSITION-FILE.
           WRITE POSITION-RECORD.
           CLOSE POSITION-FILE.

           DISPLAY " ".
           DISPLAY "position added successfully.".

           POSITION-LIST.
           DISPLAY "---------------------------------------------".
           DISPLAY "LIST ALL POSITIONS".
           DISPLAY " ".

           DISPLAY 
           "NUM   | "
           "ID         | "
           "NAME                 | "
           "SALARY".
           DISPLAY
           "------|"
           "------------|"
           "----------------------|"
           "------------"
           MOVE 0 TO COUNTER.
           OPEN INPUT POSITION-FILE
           PERFORM UNTIL FS-POSITION NOT = '00'
               READ POSITION-FILE NEXT
                   AT END MOVE '99'TO FS-POSITION
               NOT AT END
                   ADD 1 TO COUNTER
                   DISPLAY
                   COUNTER " | "
                   POSITION-ID " | "
                   POSITION-NAME " | "
                   POSITION-SALARY
               END-READ
           END-PERFORM
           CLOSE POSITION-FILE.
           DISPLAY " ".
       PROCEDURE-MAIN.
           PERFORM CLI-HANDLER UNTIL CLI-INPUT = "exit".
           STOP RUN.

       END PROGRAM CRUNCH.
