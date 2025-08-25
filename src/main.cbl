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
           SELECT EMPLOYEE-FILE ASSIGN TO "employee"
               ORGANIZATION IS INDEXED
               ACCESS IS DYNAMIC
               RECORD KEY IS EMPLOYEE-IC
               FILE STATUS IS FS-EMPLOYEE.

       DATA DIVISION.
       FILE SECTION.
       FD POSITION-FILE.
       01 POSITION-RECORD.
           05 POSITION-ID          PIC X(10).
           05 POSITION-NAME        PIC X(20).
           05 POSITION-SALARY      PIC 9(10).
       FD EMPLOYEE-FILE.
       01 EMPLOYEE-RECORD.
           05 EMPLOYEE-IC          PIC X(16).
           05 EMPLOYEE-NAME        PIC X(32).
           05 EMPLOYEE-POSITION    PIC X(10).
       WORKING-STORAGE SECTION.
      *logic variables
       01 COUNTER                  PIC 9(5).
       01 CLI-INPUT                PIC X(32).
      *file status variables
       01 FS-POSITION              PIC XX.
       01 FS-EMPLOYEE              PIC XX.
      *temporary str variables
       01 TEMPSTR-A                PIC X(16).
       01 TEMPSTR-B                PIC X(16).
      *temporary num variables
       01 TEMPNUM-A                PIC X(16).
       01 TEMPNUM-B                PIC X(16).

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
           ELSE IF CLI-INPUT = "help" THEN
               PERFORM PROCEDURE-HELP
           ELSE IF CLI-INPUT = "exit" THEN
               DISPLAY "exiting..."
      *    position
           ELSE IF CLI-INPUT = "pos" THEN
               PERFORM PROCEDURE-POSITION
           ELSE IF CLI-INPUT = "pos add" THEN
               PERFORM POSITION-ADD
           ELSE IF CLI-INPUT = "pos list" THEN
               PERFORM POSITION-LIST
           ELSE IF CLI-INPUT = "pos edit" THEN
               PERFORM POSITION-EDIT
           ELSE IF CLI-INPUT = "pos delete" THEN
               PERFORM POSITION-DELETE
      *    employee
           ELSE IF CLI-INPUT = "emp" THEN
               PERFORM PROCEDURE-EMPLOYEE
           ELSE IF CLI-INPUT = "emp add" THEN
               PERFORM EMPLOYEE-ADD
           ELSE IF CLI-INPUT = "emp list" THEN
               PERFORM EMPLOYEE-LIST
           ELSE
               DISPLAY "unknown command entered"
           END-IF.
       PROCEDURE-SETUP.
           DISPLAY "---------------------------------------------".
           DISPLAY "SETUP CRUNCH".
           DISPLAY " ".

           OPEN OUTPUT POSITION-FILE.
           CLOSE POSITION-FILE.
           DISPLAY "(1/2) position file created".
           
           OPEN OUTPUT EMPLOYEE-FILE.
           CLOSE EMPLOYEE-FILE.
           DISPLAY "(2/2) employee file created"

           DISPLAY "setup complete".
       PROCEDURE-HELP.
           DISPLAY "---------------------------------------------".
           DISPLAY "HELP WITH CRUNCH".
           DISPLAY "github: https://github.com/theluqmn/crunch".
           DISPLAY " ".
           DISPLAY "available commands:".
           DISPLAY "[pos]              overview of company positions".
           DISPLAY "[emp]              overview of complay employeees".
           DISPLAY "-".
           DISPLAY "[setup]            setup crunch (first-time only)".
           DISPLAY "[exit]             exit crunch".
       PROCEDURE-POSITION.
           DISPLAY "---------------------------------------------".
           DISPLAY "POSITION MANAGEMENT OVERVIEW".
           DISPLAY " ".
           DISPLAY "[pos list]         list all positions".
           DISPLAY "[pos add]          add a new position".
           DISPLAY "[pos edit]         edit a position".
           DISPLAY "[pos delete]       delete a position".

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
           DISPLAY "total: " COUNTER.

           POSITION-EDIT.
           DISPLAY "---------------------------------------------".
           DISPLAY "EDIT A POSITION".
           DISPLAY " ".
           DISPLAY "properties:".
           DISPLAY "[name]             name of the position".
           DISPLAY "[salary]           salary of the position".
           DISPLAY " ".

           DISPLAY "(1/3) id:          " WITH NO ADVANCING.
           ACCEPT POSITION-ID.
           DISPLAY "(2/3) property:    " WITH NO ADVANCING.
           ACCEPT TEMPSTR-A.
           DISPLAY "(3/3) new value:   " WITH NO ADVANCING.
           ACCEPT TEMPSTR-B.

           IF TEMPSTR-A = "name" THEN
               OPEN I-O POSITION-FILE
               READ POSITION-FILE KEY IS POSITION-ID
                   INVALID KEY
                       DISPLAY "invalid position id"
                   NOT INVALID KEY
                       MOVE TEMPSTR-B TO POSITION-NAME
                       REWRITE POSITION-RECORD
                       DISPLAY "position name updated"
               END-READ
               CLOSE POSITION-FILE
           ELSE IF TEMPSTR-A = "salary" THEN
               OPEN I-O POSITION-FILE
               READ POSITION-FILE KEY IS POSITION-ID
                   INVALID KEY
                       DISPLAY "invalid position id"
                   NOT INVALID KEY
                       MOVE TEMPSTR-B TO POSITION-SALARY
                       REWRITE POSITION-RECORD
                       DISPLAY "position salary updated"
               END-READ
               CLOSE POSITION-FILE
           ELSE
               DISPLAY "invalid property name"
           END-IF.

           POSITION-DELETE.
           DISPLAY "---------------------------------------------".
           DISPLAY "DELETE A POSITION".
           DISPLAY " ".

           DISPLAY "(1/2) id:          " WITH NO ADVANCING.
           ACCEPT POSITION-ID.
           DISPLAY "(2/2) confirm? 'y':" WITH NO ADVANCING.
           ACCEPT TEMPSTR-A.

           IF TEMPSTR-A = "y" THEN
               OPEN I-O POSITION-FILE
               DELETE POSITION-FILE
                   INVALID KEY DISPLAY 
                   "position not found"
                   NOT INVALID KEY DISPLAY 
                   "position deleted successfully"
               END-DELETE
               CLOSE POSITION-FILE
           ELSE
               DISPLAY "operation cancelled".
       PROCEDURE-EMPLOYEE.
           DISPLAY "---------------------------------------------".
           DISPLAY "EMPLOYEE MANAGEMENT OVERVIEW".
           DISPLAY " ".
           DISPLAY "[emp list]         list all the employees".
           DISPLAY "[emp add]          add a new employee".

           EMPLOYEE-ADD.
           DISPLAY "---------------------------------------------".
           DISPLAY "ADD A NEW EMPLOYEE".
           DISPLAY " ".
           DISPLAY "(1/3) ic:          " WITH NO ADVANCING.
           ACCEPT EMPLOYEE-IC.
           DISPLAY "(2/3) name:        " WITH NO ADVANCING.
           ACCEPT EMPLOYEE-NAME.
           DISPLAY "(3/3) position:    " WITH NO ADVANCING.
           ACCEPT EMPLOYEE-POSITION.

           OPEN I-O POSITION-FILE.
           MOVE EMPLOYEE-POSITION TO POSITION-ID.
           READ POSITION-FILE KEY IS POSITION-ID
               INVALID KEY
                   DISPLAY "invalid position id"
               NOT INVALID KEY
                   OPEN I-O EMPLOYEE-FILE
                   WRITE EMPLOYEE-RECORD
                   CLOSE EMPLOYEE-FILE
                   DISPLAY "employee added successfully."
           END-READ.
           CLOSE POSITION-FILE.

           EMPLOYEE-LIST.
           DISPLAY "---------------------------------------------".
           DISPLAY "LIST ALL EMPLOYEES".
           DISPLAY " ".

           DISPLAY 
           "NUM   | "
           "ID               | "
           "NAME                             | "
           "POSITION".
           DISPLAY
           "------|"
           "------------------|"
           "----------------------------------|"
           "-----------"
           MOVE 0 TO COUNTER.
           OPEN INPUT EMPLOYEE-FILE
           PERFORM UNTIL FS-EMPLOYEE NOT = '00'
               READ EMPLOYEE-FILE NEXT
                   AT END MOVE '99'TO FS-EMPLOYEE
               NOT AT END
                   ADD 1 TO COUNTER
                   DISPLAY
                   COUNTER " | "
                   EMPLOYEE-IC " | "
                   EMPLOYEE-NAME " | "
                   EMPLOYEE-POSITION
               END-READ
           END-PERFORM
           CLOSE EMPLOYEE-FILE.
           DISPLAY " ".
           DISPLAY "total: " COUNTER.
       PROCEDURE-MAIN.
           PERFORM CLI-HANDLER UNTIL CLI-INPUT = "exit".
           STOP RUN.
       END PROGRAM CRUNCH.
