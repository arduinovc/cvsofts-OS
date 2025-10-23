<pre>                                                       
                               AW                      
                              ,M' .g8""8q.    .M"""bgd 
                              MV.dP'    `YM. ,MI    "Y 
 ,p6"bo `7M'   `MF',pP"Ybd   AW dM'      `MM `MMb.     
6M'  OO   VA   ,V  8I   `"  ,M' MM        MM   `YMMNq. 
8M         VA ,V   `YMMMa.  MV  MM.      ,MP .     `MM 
YM.    ,    VVV    L.   I8 AW   `Mb.    ,dP' Mb     dM 
 YMbmd'      W     M9mmmP',M'     `"bmmd"'   P"Ybmmd"  
                          MV                           
                         AW                            
</pre>

## Build information
cvs/OS by Vincent Charles @2025  
Build from NASM on macOS 12 (Monterey)  

## How to run

### Needed to build
Following package are required to build this project :  
- NASM.  
- pandoc.  
- make.  
- gcc, clang, cl.  

This command can install on macOS all dependancies :  
    `brew install nasm make pandoc`

### Commands
To build floppy image  
    `make boot.bin` 

To run cvsOS via QEMU  
    `make run`

To build all project including documentation. 
    `make all`

To build documentation  
    `make docs`

## Source
[Blog Vincent](https://blog.vincentcharles.ovh)



