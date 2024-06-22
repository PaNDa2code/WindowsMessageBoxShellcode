global main
main:
	push	rbp
	push	rdi
	push	rsi
	push	rbx
	sub	rsp, 0x68

	mov	DWORD 0x4f[rsp], 0x21646c
	mov	rax, 0x7262694c64616f4c
	mov	QWORD 0x53[rsp], rax
	mov	rax, 0x41797261726269
	mov	QWORD 0x58[rsp], rax
	mov	rax, 0x426567617373654d
	mov	QWORD 0x3b[rsp], rax
	mov	rax, 0x642e323372657375
	mov	QWORD 0x30[rsp], rax
	mov	rax, 0x726f576f6c6c6548
	mov	QWORD 0x47[rsp], rax
	mov	rax, 0x646f636c6c656853
	mov	QWORD 0x26[rsp], rax
	mov	eax, 0x65
	mov	DWORD 0x37[rsp], 0x6c6c64
	mov	WORD 0x2e[rsp], ax
	mov	DWORD 0x43[rsp], 0x41786f

 
	mov rax, gs:[0x60]
 

	mov	rax, QWORD 0x18[rax]
	mov	rax, QWORD 0x20[rax]
	mov	rax, QWORD [rax]
	mov	rax, QWORD [rax]
	mov	r10, QWORD 0x20[rax]
	movsx	rax, DWORD 0x3c[r10]
	mov	eax, DWORD 0x88[r10+rax]
	add	rax, r10
	mov	esi, DWORD 0x18[rax]
	mov	edx, DWORD 0x20[rax]
	mov	edi, DWORD 0x1c[rax]
	mov	ebp, DWORD 0x24[rax]
	test	esi, esi
	je	.L17
	xor	r11d, r11d
	lea	rbx, [r10+rdx]
.L8:
	mov	r8d, DWORD [rbx+r11*0x4]
	xor	eax, eax
	lea	r9, 0x53[rsp]
	add	r8, r10
	movzx	edx, BYTE [r8]
	test	dl, dl
	jne	.L3
	jmp	.L4
.L38:
	cmp	cl, dl
	jne	.L7
	add	rax, 0x1
	movzx	edx, BYTE [r8+rax]
	test	dl, dl
	je	.L4
.L3:
	movzx	ecx, BYTE [r9+rax]
	test	cl, cl
	jne	.L38
.L7:
	add	r11, 0x1
	cmp	r11, rsi
	jne	.L8
.L17:
	xor	r10d, r10d
	jmp	.L2
.L4:
	cmp	BYTE 0x53[rsp+rax], 0x0
	jne	.L7
	lea	rax, [r10+r11*0x2]
	movzx	eax, WORD [rax+rbp]
	lea	rax, [r10+rax*0x4]
	mov	eax, DWORD [rax+rdi]
	add	r10, rax
.L2:
	lea	rcx, 0x30[rsp]
	call	r10
	mov	r10, rax
	movsx	rax, DWORD 0x3c[rax]
	mov	eax, DWORD 0x88[r10+rax]
	add	rax, r10
	mov	esi, DWORD 0x18[rax]
	mov	edx, DWORD 0x20[rax]
	mov	edi, DWORD 0x1c[rax]
	mov	ebp, DWORD 0x24[rax]
	test	esi, esi
	je	.L19
	xor	r11d, r11d
	lea	rbx, [r10+rdx]
.L16:
	mov	r8d, DWORD [rbx+r11*0x4]
	xor	eax, eax
	lea	r9, 0x3b[rsp]
	add	r8, r10
	movzx	edx, BYTE [r8]
	test	dl, dl
	jne	.L10
	jmp	.L11
.L39:
	test	cl, cl
	je	.L14
	add	rax, 0x1
	movzx	edx, BYTE [r8+rax]
	test	dl, dl
	je	.L11
.L10:
	movzx	ecx, BYTE [r9+rax]
	cmp	cl, dl
	je	.L39
.L14:
	add	r11, 0x1
	cmp	r11, rsi
	jne	.L16
.L19:
	xor	r10d, r10d
	jmp	.L9
.L11:
	cmp	BYTE 0x3b[rsp+rax], 0x0
	jne	.L14
	lea	rax, [r10+r11*0x2]
	movzx	eax, WORD [rax+rbp]
	lea	rax, [r10+rax*0x4]
	mov	eax, DWORD [rax+rdi]
	add	r10, rax
.L9:
	lea	rdx, 0x47[rsp]
	xor	r9d, r9d
	lea	r8, 0x26[rsp]
	xor	ecx, ecx
	call	r10
	xor	eax, eax
	add	rsp, 0x68
	pop	rbx
	pop	rsi
	pop	rdi
	pop	rbp
	ret
