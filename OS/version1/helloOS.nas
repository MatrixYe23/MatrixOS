; hello-os
; TAB=4

		ORG		0x7c00			; 这个项目会被写入哪里?

; 以下这段是标准TAT12格式软盘专用的代码

		DB		0xeb, 0x4e, 0x90
		DB		"HELLOIPL"		; 启动区的名称可以是任意的字符串（8字节）
		DW		512				; 每个扇区（sector）的大小（必须为512字节）
		DB		1				; 簇（cluster）的大小（必须为1个扇区）
		DW		1				; FAT的起始位置（一般从第一个扇区开始）
		DB		2				; FAT 的个数（必须为2）
		DW		224				; 根目录大小（一般设置成224项）
		DW		2880			; 该磁盘大小（必须是2880扇区）
		DB		0xf0			; 磁盘的种类（必须是0xf0）
		DW		9				; FAT的长度（必须是9扇区）
		DW		18				; 1个磁道有几个扇区（必须是18）
		DW		2				; 磁头数（必须是2）
		DD		0				; 不使用分区，必须是0
		DD		2880			; 重写一次磁盘大小
		DB		0,0,0x29		; 意义不明，固定
		DD		0xffffffff		; （可能是）卷标号码
		DB		"HELLO-OS   "	; 磁盘的名字（11字节）
		DB		"FAT12   "		; 磁盘格式名称（8字节）
		RESB	18				; 先空出18字节

; 程序主体

entry:
		MOV		AX,0			; 寄存器初始化
		MOV		SS,AX
		MOV		SP,0x7c00
		MOV		DS,AX
		MOV		ES,AX

		MOV		SI,msg
putloop:
		MOV		AL,[SI]
		ADD		SI,1			; 在SI上加1
		CMP		AL,0
		JE		fin
		MOV		AH,0x0e			; 一字型方程式无法显示
		MOV		BX,15			; 彩色代码
		INT		0x10			; 视频BIOS调用
		JMP		putloop
fin:
		HLT						; 把CPU停到有什么事为止
		JMP		fin				; 无边循环

msg:
		DB		0x0a, 0x0a		; 改行两件
		DB		"hello, world"
		DB		0x0a			; 改行
		DB		0

		RESB	0x7dfe-$		; 0x7dfe用0x00埋的命令

		DB		0x55, 0xaa

; 以下是启动区以外部分的输出

		DB		0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
		RESB	4600
		DB		0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
		RESB	1469432
