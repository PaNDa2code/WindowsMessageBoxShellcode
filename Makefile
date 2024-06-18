CC=x86_64-w64-mingw32-gcc
CF=-w -O3 -masm=intel
MESSAGE:=HelloWorld!
TITLE:=Shellcode

bin/MBShellText.exe: src/c/shellcode.c
	@$(CC) $(CF) -o $@ $<

bin/MBShellText.o: src/asm/shellcode.S 
	@nasm -f elf64 -o $@ $<

src/asm/shellcode.S: src/c/shellcode.c
	@sed -i 's/CHAR Message\[\] = .*;/CHAR Message[] = "$(MESSAGE)";/' $<
	@sed -i 's/CHAR Title\[\] = .*;/CHAR Title[] = "$(TITLE)";/' $<
	@$(CC) $(CF) -S -o $@ $<
	@python gas2nasm.py $@

bin/MBShellText.bin: bin/MBShellText.o
	@objcopy -O binary $< $@

shellcode: bin/MBShellText.bin 
	@python bin2str.py $<

clean:
	rm -f bin/* src/asm/shellcode.S

.PHONY: shellcode clean
