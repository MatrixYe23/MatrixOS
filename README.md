# MatrixOS

笔者是一个JAVA 程序员，写这个OS纯粹是个人兴趣，笔者一开始打算是根据《30天操作系统这本书》来编写操作系统，但是读完这本书发现，这本书到最终也没有实现文件系统，笔者还是想做出一个带有文件系统的真正的操作系统的，所以这本书前面部分直到键盘，鼠标的输入等内容大多是参考了《30天操作系统》这本书，后面文件系统的部分则是笔者自己找资料拼凑的，如果有什么不对的地方，欢迎指出来。

本OS 采用X86 汇编，使用的是32位寄存器，也就是实现的是32位操作系统。 

目录

一准备工作:
1. 环境搭建
QEMU:https://www.qemu.org/

2. NASM
x86 汇编编译器

3. dd

nasm helloOS.s -o boot.bin

dd if=boot.bin of=boot.img bs=512 count=1

qemu-system-i386 -drive file=boot.img,format=raw,if=floppy


