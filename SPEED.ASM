
; 80486ìãç⁄ã@éÌÇÃë¨ìxÇê›íËÇµÇ‹Ç∑
; éñëOÇ…BIOSê›íËâÊñ Ç≈CPUÇLowÇ…ê›íËÇµÇƒÇ®Ç¢ÇƒÇ≠ÇæÇ≥Ç¢


.186

CODE  SEGMENT
      ASSUME CS:CODE,DS:CODE,ES:CODE,SS:CODE

      ORG 80H

CMDLN    DB   128 DUP(?)

      ORG 0100H

START:
      CLD
      MOV   AX,CS
      MOV   DS,AX
      MOV   ES,AX

      MOV   SI,OFFSET CMDLN
      MOV   BX,0
      MOV   DX,0
INPUT_ANA:
      MOV   BL,[SI]
      INC   SI
      CMP   BL,0DH
      JE    INPUT_FIN
      CMP   BL,20H
      JE    INPUT_ANA
      CMP   BL,30H
      JB    INPUT_ANA
      CMP   BL,3AH
      JNB   INPUT_ANA
      SUB   BL,30H
      MOV   AX,DX
      MOV   DX,10
      MUL   DX
      ADD   AX,BX
      MOV   DX,AX
      JMP   INPUT_ANA

INPUT_FIN:
      CMP   DX,128
      JB    INPUT_FIN_2
      JMP   SPEED_ERROR

INPUT_FIN_2:
      MOV   SPEED,DX

      MOV   AX,SPEED
      AND   AL,0FH
      MOV   DX,9892H
      OUT   DX,AL
      MOV   AX,SPEED
      SHR   AX,4
      OR    AL,8
      MOV   DX,9894H
      OUT   DX,AL

FIN:
      MOV   DI,OFFSET MES_1
      MOV   AX,SPEED

      MOV   CX,10
      DIV   CL
      ADD   AH,30H
      MOV   [DI+2],AH
      MOV   AH,0
      MOV   CX,10
      DIV   CL
      ADD   AH,30H
      MOV   [DI+1],AH
      ADD   AL,30H
      MOV   [DI],AL

      MOV   AH,9
      MOV   DX,OFFSET MES_2
      INT   21H
      MOV   AX,4C00H
      INT   21H


SPEED_ERROR:
      MOV   AH,9
      MOV   DX,OFFSET MES_ERR
      INT   21H
      MOV   AX,4C00H
      INT   21H


SPEED  DW   0

MES_2   DB   'SPEED = '
MES_1   DB   '000',10,13,'$'

MES_ERR  DB  'SPEED ERROR ! INPUT FROM 0 TO 127 !',10,13,'$'


CODE  ENDS
      END   START

