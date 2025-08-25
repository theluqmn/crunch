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
           05 POSITION-ID      PIC X(10).
           05 POSITION-NAME    PIC X(20).
           05 BASE-SALARY      PIC 9(10).
       WORKING-STORAGE SECTION.
       01 CLI-INPUT PIC X(32).
       01 FS-POSITION PIC XX.

       PROCEDURE DIVISION.
       PERFORM PROCEDURE-MAIN.
       CLI-HANDLER.
           DISPLAY "------------------------------------------".
           DISPLAY "> " WITH NO ADVANCING.
           ACCEPT CLI-INPUT.
           IF CLI-INPUT = "setup" THEN
               PERFORM PROCEDURE-SETUP
           ELSE
               DISPLAY "unknown command entered"
           END-IF.
       PROCEDURE-SETUP.
           DISPLAY "------------------------------------------".
           DISPLAY "[ SETUP CRUNCH ]".
           DISPLAY " ".
           OPEN OUTPUT POSITION-FILE.
           CLOSE POSITION-FILE.
           DISPLAY "(1/1) position file created".
           DISPLAY "setup complete".
       PROCEDURE-MAIN.
           PERFORM CLI-HANDLER UNTIL CLI-INPUT = "exit".
           DISPLAY "exiting crunch...".
           STOP RUN.

       END PROGRAM CRUNCH.
