#Auth : vladimir geytman               DATE: 10/4/15

.data
                             
           array              : .space 40 # num * Place= 20*4 
           num                : .word 0
           the_options_are    : .asciiz  " 1. add a number \n 2. DEL a number \n 3. Find a number in arryay \n 4. Find average \n 5. Find max  \n 6. Num of elements in the Array \n 7. Print Array \n 8. END \n "
           print_help         : .asciiz  "\t"
           print_help2        : .asciiz  "\n"
           full               : .asciiz  "@@@@@@@@@@@@@@@@@ -1 arr is full sorry.. @@@@@@@@@@@@@@@@@@@ \n "
           your_num           : .asciiz  "@@@@@@@@@ What number you want to add ? @@@@@@@@@@@@@@ \n "
           in_array           : .asciiz  "@@@@@@@@@@@@@@@@@ -1 The number has been in array sorry @@@@@@@@@@@@ \n"
           Empty              : .asciiz  "@@@@@@@@@@@@@@@@@ -1 arr is empty sorry..  @@@@@@@@@@@@@@@@@@@ \n "
           no_in_arr          : .asciiz  "@@@@@@@@@@@@@@@@@ -1 the num is not in arr sorry ..  @@@@@@@@@@@@@@@@@@@ \n "
           what_dale          : .asciiz  "@@@@@@@@@@@@@@@@@ What number to delete ? ..  @@@@@@@@@@@@@@@@@@@ \n "
           average_print      : .asciiz  " The average value of the number is.. "
           find_num           : .asciiz  "  What number to find ? \n"
           num_is_find          : .asciiz  "  The num is find,he is in idx.. "
           number_not_found      : .asciiz  " -1 sorry The num is not find he is not in arr \n "
           max_in_max         : .asciiz  " The max num in array is.... "
              
.text
.globl main
       main:
             
             
             li $v0 ,4
             la $a0 ,the_options_are
             syscall
             li $v0 ,5
             syscall           # call num 1-8
             move $t0 ,$v0     #you'r num = t0\
            
                 ### switch (t0) 1-8###
             beq $t0 ,1 ,add_namber  # if (t0=1) go to add_namber 
             beq $t0 ,2 ,DEL         # if (t0=2) go to del num
             beq $t0 ,3 ,find        # if (t0=3) find num in  arr
             beq $t0 ,4 ,average     # if (t0=4) go to average 
             beq $t0 ,5 ,Max         # if (t0=5) go to    MAX
             beq $t0 ,6 ,print_6     # if (t0=6) Number of elements in the array will be printed
             beq $t0 ,7 ,print       # if (t0=7) go to print arr
             beq $t0 ,8 ,Exit        # if (t0=8) go to exit! , thx 
             j  main

####################################  add_namber ############################################################                       
#############################################################################################################             
add_namber:
            lw $t1 ,num 
            beq $t1 ,40,full_arr  # if t1=80 go full_arr ( sorry ) 
            
             
            li $v0 ,4
            la $a0 ,your_num
            syscall
            li $v0 ,5
            syscall
            
                   move $t2 ,$v0  #t2 =you'r num
            
                   addi $t0 ,$zero ,0 # arr [idx] =t0
                   lw   $t3 ,array($t0)
            
loop_add:          bne $t3,$t2 ,check  #if t3!=t2 go check else go on..
            
                   li $v0 ,4
                   la $a0 , in_array
                   syscall
                   j  main
            
                           
check  :
                  beq $t0 , 40,add_arry_nam  #t0=80 add num eles t0++ 
                
                  addi  $t0,$t0,4
                  lw    $t3 ,array($t0)
                  j loop_add
                
add_arry_nam :    
                   lw $t6 ,num                  
                   sw $t2,array($t6)               
                   addi $t6,$t6,4
                   sw $t6,num
                   j main
                             
               
            
full_arr:
                li $v0 ,4
                la $a0 , full
                 syscall
                 j main
               
####################################  print _namber #########################################################                       
############################################################################################################# 
 print:    
        
                addi $t0 $zero ,0     #   sure 4 zero in t0 4 idx 
                lw $t1 ,num           # t1=num
                     
loop_print :    beq $t0 ,$t1 exit_print  #if t1=t0 go end else go on..
                lw  $t7 ,array($t0)   #   t7 = arr[idx]
                addi $t0 ,$t0,4       #   idx ++ 
                move $a0 ,$t7         #   a= t7
                li $v0 ,1          
                syscall
                
                la $a0 ,print_help
                li $v0 ,4             # print \t
                syscall
                
                j loop_print         # loop to print
                
              
exit_print: 
                li $v0 ,4             # print \n
                la $a0 ,print_help2
                syscall
              
                j main
#################################### find num in  array #############################################################                       
#############################################################################################################
find :        
                  li $v0 ,4
                  la $a0 ,find_num
                  syscall
                  li $v0 ,5
                  syscall
                
                  move $t3,$v0            # t3 = my num to find 
                  lw  $t4 , num           #  i=num  
                  lw  $t1 ,num            # num = t1 (num in arr)
                  lw  $t2 ,array($t1)     # t2 = arr [idx] 
                
loop_find  :      beq  $t4  , -4 , no_find_in_arry
                  beq $t2 ,$t3 ,find_num_in_arr
                  subi $t1 ,$t1 ,4
                  lw  $t2 ,array($t1)
                  subi $t4 ,$t4 ,4                 
                  j loop_find
                  
find_num_in_arr:

                  div $t5 , $t1,4
                  li $v0 ,4
                  la $a0 , num_is_find 
                  syscall
                  move $a0, $t5
                  li   $v0,1
                  syscall
                  li $v0 ,4
                  la $a0 , print_help2 
                  syscall
                  
                  j main
no_find_in_arry:    
                  li $v0 ,4
                  la $a0 , number_not_found
                  syscall              
                  j main
                  
                  
#################################### DEL_namber #############################################################                       
#############################################################################################################
DEL :                       
                lw $t1 ,num
                lw $t6 ,num
                lw $t2 ,num
                beq $t1 , -1 ,exit_del
                li $v0 , 4            
                la $a0 , what_dale
                syscall 
                li $v0 ,5
                syscall  
                move $t3 ,$v0                     # t3=v0
                lw   $t4 ,array($t1)              #t4= arr[idx]
loop_del:       beq  $t1 ,-4 ,no_in_arr_del    # if t1 =0  del num els loop idx--
                beq  $t4 ,$t3 ,del_num_in_arr              
                subi $t1,$t1,4
                lw   $t4 ,array($t1) 
                j loop_del
del_num_in_arr:
                subi $t6,$t6 ,4
                lw $t5 ,array($t6)
                move $t4 ,$t5
                sw $t4 ,array($t1)
                move $t7 , $zero
                sw $t7 ,array($t6)
                subi $t2 ,$t2 ,4
                sw   $t2 ,num
                             
                j main
no_in_arr_del:
                li $v0 , 4            
                la $a0 , no_in_arr 
                syscall 
                j main


exit_del:
                li $v0 , 4            
                la $a0 , Empty 
                syscall
           
                j main
####################################  Number of elements in the array #######################################                      
#############################################################################################################
print_6:
              lw $t1 ,num   #t1=num
              li $t2 ,4 
              div $t6,$t1,$t2 
              move $a0 ,$t6
              li $v0 ,1
              syscall
               
              la $a0 ,print_help2  # print \n
              li $v0 ,4
              syscall
              j main
####################################- MAX IN ARR- ###########################################################                       
#############################################################################################################
Max:
                lw $t1 , num          # i
                lw $t2 ,array($t1)   # t2= arr[ixd]
               addi $t3 ,$zero,0    #max  
loop_max :     
               beq $t1 ,-4 ,max_num_is  # t1 != -4 go 
               
               blt $t3,$t2 ,else_max    # if(t3<t2) go els go else_max                       
               subi $t1,$t1,4           # i--
               lw $t2 ,array($t1)       # t2= arr[ixd]
               j loop_max
               
               
else_max:                
               move $t3 , $t2         #t3=t2               
               subi $t1,$t1,4         # idx --
               lw $t2 ,array($t1)     # t2= arr[ixd] 
               j loop_max
               
max_num_is:     
                li $v0 ,4
                la $a0 , max_in_max 
                syscall         
                move $a0 ,$t3
                li $v0 ,1
                syscall
                li $v0 ,4
                la $a0 , print_help2 
                syscall      
                j main
                                       
####################################    average   ###########################################################                       
#############################################################################################################
             
average:
           addi $t2 ,$zero,0   # i=0
           addi $t5 ,$zero,0   # idx arr
           addi $t4 ,$zero,0   # max
           lw   $t1 ,num       # t1=num           
           move $t3 ,$t1       #t3= t1
loop_average :
           beq  $t2 ,$t3 ,end_average  # if (t2=t3)go end average
           lw   $t6,array($t5)   # t6= idx in arr
           add  $t4 ,$t4,$t6     #t4= t4+arr[idx]
           addi $t5 ,$t5,4       # idx ++
           addi $t2 ,$t2,4      #i++
           
           j loop_average 
  
end_average: 
             div $t0,$t1,4
             div $t7,$t4,$t0
             
             la $a0 ,average_print
             li $v0 ,4
             syscall
             
             move $a0 ,$t7
             li $v0 ,1
             syscall
             
             la $a0 ,print_help2
             li $v0 ,4
             syscall
             j main
  

#################################### exit _program ##########################################################                       
#############################################################################################################             
  Exit: 
                li $v0 ,10
                 syscall  
             
