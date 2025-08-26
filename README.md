# crunch

human resource management done right

**crunch** is built as an effective HR management system built for businesses of all scale, powered by COBOL and the supreme command line.

## features

> [!NOTE]
> this project is a work-in-progress.

- manage company positions
- manage employee data

## how to use

> [!WARNING]
> the release only offers an executable compiled for Ubuntu. if you are not on the same distro or operating system, please refer to the [compiling it yourself](#compiling-it-yourself) guide.

1. go to [releases](https://github.com/theluqmn/crunch/releases/latest), download the latest release.
2. navigate to the directory of the executable and simply run `./main`.

### compiling it yourself

the following are the steps for Ubuntu.

1. install `gnucobol` using your package manager (download gnucobol).
2. clone this repository.
3. run `cobc src/main.cbl` in the project directory.
4. run `./main` to run the program.

## how this works

this program is written in cobol and is compiled using `gnucobol`. it is a simple CLI-based program, where managers can add/edit/remove employees, manage company positions and perform payroll processing.

### database design

- `POSITION(position-id TEXT PRIMARY KEY, name TEXT, base-salary INT)`
- `EMPLOYEE(ic INT PRIMARY KEY, name TEXT, position-id FOREIGN KEY)`
- `LOGS(id INT PRIMARY KEY, time INT, event TEXT)`

### to-do

- [x] manage company positions - v1.0
- [x] manage employee data - v1.0
- [ ] comprehensive logging system
- [ ] payroll processing
- [ ] track employee performance

## extras

i wanted to work on a slightly more complicated project than my previous one, [wareball](https://github.com/theluqmn/wareball) (an inventory management system), so i started crunch. i named this project 'crunch' because my girlfriend was eating fried chicken and i heard the crunch sounds - so yeah.

this project is licensed under the [MIT license](https://github.com/theluqmn/crunch/blob/main/LICENSE).
