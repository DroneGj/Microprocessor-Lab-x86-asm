;#################################################################################################################################
;## Title:  program for water level controler                                                                                   ## 
;## Author: GunjanShuvro                                                                                                        ##
;## Date:   25 May 2020                                                                                                         ## 
;## Repo:   https://github.com/dronegj                                                                                          ##
;#################################################################################################################################

DATA SEGMENT
    msg1 db 10,13,"The water level is: $"
    msg2 db 10,13,"Switch ON motor. $"
    msg3 db 10,13,"Switch OFF motor. $"
    msg4 db 10,13,"Water overflow! $"
DATA ENDS

CODE SEGMENT
    ASSUME DS:DATA,CS:CODE

START: mov AX,@data ;intialize data segment
       mov DS,AX
       
       mov CL,1H

L1:    lea DX,msg1  ;displaying water level message
       mov AH,9H
       int 21H
       
       add CL,30H   ;ASCII adjust before displaying
       mov DL,CL
       mov AH,2H    ;display
       int 21H
       sub CL,30H   ;ASCII adjust after displaying

       cmp CL,8H    ;switch off motor
       je off       ;jump to off if = 8
       
       cmp CL,1H    ;switch on motor
       je on        ;jump to on if = 1
       
back:  inc CL       ;increase water level by 1
       cmp CL,8H    ;check if water level is overflowing
       jle l1
       
       jmp exit
       
on:    lea DX,msg2
       mov AH,9h
       int 21H
       jmp back
       
off:   lea DX,msg3
       mov AH,9h
       int 21H
       lea DX,msg4  ;displaying overflow 
       mov AH,9H
       int 21H
       jmp back


exit:  mov AH,4CH
       int 21H              
       
CODE ENDS
END START