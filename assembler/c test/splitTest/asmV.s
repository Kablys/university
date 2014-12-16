	.file	"split.c"
	.section	.rodata
.LC0:
	.string	"r"
.LC1:
	.string	"%d%s"
.LC2:
	.string	"w"
.LC3:
	.string	"%s\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$1112, %rsp
	.cfi_offset 3, -24
	movl	%edi, -1108(%rbp)
	movq	%rsi, -1120(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -24(%rbp)
	xorl	%eax, %eax
	movq	-1120(%rbp), %rax
	addq	$16, %rax
	movq	(%rax), %rax
	movl	$.LC0, %esi
	movq	%rax, %rdi
	call	fopen
	movq	%rax, -1088(%rbp)
	movq	-1120(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atoi
	movl	%eax, -1092(%rbp)
	movl	$0, -1096(%rbp)
	jmp	.L2
.L5:
	movq	-1120(%rbp), %rax
	addq	$16, %rax
	movq	(%rax), %rcx
	movl	-1096(%rbp), %edx
	leaq	-1072(%rbp), %rax
	movl	$.LC1, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	sprintf
	leaq	-1072(%rbp), %rax
	movl	$.LC2, %esi
	movq	%rax, %rdi
	call	fopen
	movq	%rax, -1080(%rbp)
	movq	-1088(%rbp), %rdx
	movl	-1092(%rbp), %ecx
	leaq	-1056(%rbp), %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	fgets
	movq	-1088(%rbp), %rax
	movq	%rax, %rdi
	call	feof
	testl	%eax, %eax
	je	.L3
	movq	-1080(%rbp), %rax
	movq	%rax, %rdi
	call	fclose
	jmp	.L4
.L3:
	leaq	-1056(%rbp), %rdx
	movq	-1080(%rbp), %rax
	movl	$.LC3, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	movq	-1080(%rbp), %rax
	movq	%rax, %rdi
	call	fclose
	addl	$1, -1096(%rbp)
.L2:
	cmpl	$99, -1096(%rbp)
	jle	.L5
.L4:
	movq	-1088(%rbp), %rax
	movq	%rax, %rdi
	call	fclose
	movl	$0, %eax
	movq	-24(%rbp), %rbx
	xorq	%fs:40, %rbx
	je	.L7
	call	__stack_chk_fail
.L7:
	addq	$1112, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 4.8.2-19ubuntu1) 4.8.2"
	.section	.note.GNU-stack,"",@progbits
