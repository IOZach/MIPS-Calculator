# calculator.asm -- Assembly language calculator.
# 
# Copyright (c) 2015, IOZack.
#
# Written by Zakaria Abushima <im@zack.today>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# This program is a calculator of various operations has been built using Assembly Language.

# Initialise menu options and result strings set
.data
menu:   .ascii "\n"	
	.ascii "\n\tM E N U\n\n"
	.ascii "\t1,  Enter number 1\n"
	.ascii "\t2,  Enter number 2\n"
	.ascii "\t3,  Display number 1 and number 2\n"
	.ascii "\t4,  Display sum of number 1 and number 2\n"
	.ascii "\t5,  Display product of number 1 and number 2\n"
	.ascii "\t6,  Divide number 1 by number 2\n"
	.ascii "\t7,  Exchange numbers 1 and 2\n"
	.ascii "\t8,  Display numbers between number 1 and number 2\n"
	.ascii "\t9,  Sum numbers between number 1 and number 2\n"
	.ascii "\t10, Raise number 1 to the power of number 2\n"
	.ascii "\t11, Display prime numbers between number 1 and number 2\n"
	.ascii "\t12, Quit The Program\n"
	.ascii "\n"
	.ascii "\t\tPlease enter menu option: "
	.asciiz ""
manmetstr: .asciiz "\n\t\t Manchester Metropolitan University - M I P S Calculator"
quitprogram: .asciiz "\n   The prgram has been successfully ended.\n\n\t\t\t\t\t Good Bye Darren..."
invalidinputstr: .asciiz "\n\tSorry, Invalid input,\n\tThe current available options are from 1 to 12,\n\tSome options require one number to be less than other number,\n\tTherefore exchange numbers via option 7 might solve the issue."
enternumstr: .asciiz "\nEnter Number: "
num1str: .asciiz "\n\tNumber 1 is "
num2str: .asciiz "\n\tNumber 2 is "
sumresultstr: .asciiz "\nSum of number 1 and number 2 = "
mulresultstr: .asciiz "\nProduct of number 1 and number 2 = "
divresultstr: .asciiz "\nNumber 1 divided by number 2 = "
remresultstr: .asciiz " remainder "
numbetweenstr: .asciiz "\nNumbers between number 1 and number 2 ="
sumofnumbersstr: .asciiz "\nSum of numbers between number 1 and number 2 = "
raisednumbersstr: .asciiz "\nRaising number 1 to the power of number 2 = "
primenumbersstr: .asciiz "\nThe prime numbers between number 1 and number 2 ="
.text

# Initialise default value for number 1 and number 2
addi $s0, $zero, 23 
addi $s1, $zero, 1

# Print out program header using service 4
la $a0, manmetstr
addi $v0, $zero, 4
syscall

# Initialise and print out program menu set options
printMenu:

# Assign temporary registers to hold zero value at the start
add $t0, $zero, $zero 
add $t1, $zero, $zero
add $t2, $zero, $zero 
add $t3, $zero, $zero
add $t4, $zero, $zero

# Load and print out the menu options set
la $a0, menu
addi $v0, $zero, 4
syscall     

# Require user to input value
addi $v0, $zero, 5
syscall

# Store user input into $s3 register
add $s3,$zero, $v0

# Initialise the menu set option branches
beq $s3,1,opt1
beq $s3,2 opt2
beq $s3,3,opt3
beq $s3,4,opt4
beq $s3,5,opt5
beq $s3,6,opt6
beq $s3,7,opt7
beq $s3,8,opt8
beq $s3,9,opt9
beq $s3,10,opt10
beq $s3,11,opt11
beq $s3,12,opt12

# Validation proccess prints an error in case invalid input occurs
InvalidInput:
la $a0, invalidinputstr
addi $v0, $zero, 4
syscall

j printMenu

# Option 1 function require to input number 1 and store it in $s0
opt1:
addi $v0, $zero, 4
la $a0, enternumstr 
syscall 
addi $v0, $zero, 5 
syscall 
add $s0, $zero, $v0 
j printMenu

# Option 2 function require to input number 2 and store it in $s1
opt2:
addi $v0, $zero, 4
la $a0, enternumstr 
syscall 
addi $v0, $zero, 5 
syscall 
add $s1, $zero, $v0 
j printMenu

# Option 3 function prints out the stored number 1 and number 2
opt3:
la $a0,  num1str
addi $v0, $zero, 4 
syscall

add $a0, $zero, $s0 
addi $v0, $zero, 1
syscall

addi $v0, $zero, 4 
la $a0,  num2str
syscall

addi $v0, $zero, 1 
add $a0, $zero, $s1
syscall
j printMenu

# Option 4 prints out the sum of number 1 and number 2
opt4:
la $a0,  sumresultstr
addi $v0, $zero, 4
syscall 

add $a0, $s1, $s0 
addi $v0, $zero, 1 
syscall
j printMenu

# Option 5 prints out the product of number 1 and number 2
opt5:
la $a0,  mulresultstr
addi $v0, $zero, 4
syscall 

mul $a0, $s1, $s0 
addi $v0, $zero, 1 
syscall
j printMenu

# Option 6 prints out the result of dividing number 1 by number 2
opt6:
la $a0,  divresultstr
addi $v0, $zero, 4
syscall 
div  $a0, $s0, $s1 
addi $v0, $zero, 1 
syscall 
la $a0,  remresultstr
addi $v0, $zero, 4
syscall 
rem  $a0, $s0, $s1
addi $v0, $zero, 1
syscall
j printMenu

# Option 7 exchange number 1 and 2 and prints out the numbers
opt7:

add $t0, $zero, $s0 
add $s0, $zero, $s1 
add $s1, $zero, $t0

la $a0,  num1str 
addi $v0, $zero, 4 
syscall 

add $a0, $zero, $s0
addi $v0, $zero, 1 
syscall

addi $v0, $zero, 4
la $a0,  num2str
syscall

addi $v0, $zero, 1
add $a0, $zero, $s1
syscall
j printMenu

# Option 8 display numbers between number 1 and number 2 using branch loop 
opt8:
bgt $s0, $s1, InvalidInput

addi $v0, $zero, 4
la $a0,  numbetweenstr
syscall

add $t0, $zero, $s0 

loopthrough: 
addi $v0, $zero, 11
li $a0, ' ' 
syscall

add $a0, $zero, $t0
addi $v0, $zero, 1 
syscall

add $t0, $t0, 1 
ble $t0, $s1, loopthrough 
j printMenu

# Option 9 sum numbers between number 1 and number 2 using branch loop
opt9:
bgt $s0, $s1, InvalidInput

add $t0, $zero, $s0 
add $t1, $zero, $s0

addi $v0, $zero, 4
la $a0,  sumofnumbersstr 
syscall

loopAddUp: 
add $t0, $t0, 1 
add $t1, $t1, $t0 
blt $t0, $s1, loopAddUp 

add $a0, $zero, $t1
addi $v0, $zero, 1 
syscall
j printMenu

# Option 10 raise number 1 to the power of number 2 using branch loop
opt10:
addi $t0, $zero, 1 
add $t1, $zero, $s0 

addi $v0, $zero, 4
la $a0,  raisednumbersstr
syscall

beq $s1, 0, Printowerone
beq $s1, 1, Printpowerofnumber

loopToPower:
mul $t1, $t1, $s0 
add $t0, $t0, 1 
blt $t0, $s1, loopToPower

j Printpowerofnumber

Printpowerofnumber:
add $a0, $zero, $t1
addi $v0, $zero, 1
syscall

j printMenu

Printowerone:
add $a0, $zero, 1
addi $v0, $zero, 1
syscall

j printMenu

# Option 11 display the prime numbers between number 1 and number 2
opt11:
bgt $s0, $s1, InvalidInput
add $t0, $zero, $s0 

addi $v0, $zero, 4
la $a0,  primenumbersstr 
syscall

LoopNumbers:
ble $t0,1,jumpnextnum
beq $t0,2,printoutprime
addi $t3, $zero, 2 

EvaluateNumbers:
rem $t1, $t0, $t3 
addi $t3, $t3, 1 
beq $t1,0,jumpnextnum
blt $t3, $t0, EvaluateNumbers 

printoutprime:
addi $v0, $zero, 11 
li  $a0, ' ' 
syscall
add $a0, $zero, $t0 
addi $v0, $zero, 1 
syscall

jumpnextnum: 
add $t0, $t0, 1 
ble $t0, $s1, LoopNumbers

j printMenu

# Option 12 to print out quiting the program message and quit the program
opt12: 
addi $v0, $zero, 4
la $a0,  quitprogram 
syscall

addi $v0, $zero, 17 
syscall
