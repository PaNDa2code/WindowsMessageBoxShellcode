global main
main:
	push	r14
	push	r13
	push	r12
	push	rbp
	push	rdi
	push	rsi
	push	rbx
	sub	rsp, 0x60
	mov	ebp, 0x2
	lea	rsi, 0x30[rsp]
	lea	r9, 0x53[rsp]
	mov	rax, 0x7262694c64616f4c
	mov	QWORD 0x53[rsp], rax
	lea	rbx, 0x3b[rsp]
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
	mov	DWORD 0x4f[rsp], 0x21646c
	mov	WORD 0x2e[rsp], ax
	mov	DWORD 0x43[rsp], 0x41786f
	mov rax, gs:[0x60]
  mov	rax, QWORD 0x18[rax]
	mov	rax, QWORD 0x20[rax]
	mov	rax, QWORD [rax]
	mov	rax, QWORD [rax]
	mov	r10, QWORD 0x20[rax]
.L2:
	movsx	rax, DWORD 0x3c[r10]
	mov	eax, DWORD 0x88[r10+rax]
	add	rax, r10
	mov	r14d, DWORD 0x18[rax]
	mov	edx, DWORD 0x20[rax]
	mov	r12d, DWORD 0x1c[rax]
	mov	r13d, DWORD 0x24[rax]
	test	r14d, r14d
	je	.L11
	xor	r11d, r11d
	lea	rdi, [r10+rdx]
.L9:
	mov	r8d, DWORD [rdi+r11*0x4]
	xor	eax, eax
	add	r8, r10
	movzx	edx, BYTE [r8]
	test	dl, dl
	jne	.L4
	jmp	.L5
.L22:
	cmp	cl, dl
	jne	.L8
	add	rax, 0x1
	movzx	edx, BYTE [r8+rax]
	test	dl, dl
	je	.L5
.L4:
	movzx	ecx, BYTE [r9+rax]
	test	cl, cl
	jne	.L22
.L8:
	add	r11, 0x1
	cmp	r11, r14
	jne	.L9
.L11:
	xor	r10d, r10d
	jmp	.L3
.L5:
	cmp	BYTE [r9+rax], 0x0
	jne	.L8
	lea	rax, [r10+r11*0x2]
	movzx	eax, WORD [rax+r13]
	lea	rax, [r10+rax*0x4]
	mov	eax, DWORD [rax+r12]
	add	r10, rax
.L3:
	cmp	ebp, 0x1
	je	.L10
	mov	rcx, rsi
	mov	ebp, 0x1
	call	r10
	mov	r9, rbx
	mov	r10, rax
	jmp	.L2
.L10:
	lea	rdx, 0x47[rsp]
	xor	r9d, r9d
	lea	r8, 0x26[rsp]
	xor	ecx, ecx
	call	r10
	xor	eax, eax
	add	rsp, 0x60
	pop	rbx
	pop	rsi
	pop	rdi
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	ret
