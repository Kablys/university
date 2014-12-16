	.file	"split.c"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"r"
.LC1:
	.string	"%d%s"
.LC2:
	.string	"w"
.LC3:
	.string	"%s\n"
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
.LFB21:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movq	%rsi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	xorl	%ebx, %ebx
	subq	$1056, %rsp
	.cfi_def_cfa_offset 1104
	movq	16(%rsi), %rdi
	movl	$.LC0, %esi
	movq	%fs:40, %rax
	movq	%rax, 1048(%rsp)
	xorl	%eax, %eax
	call	fopen
	movq	8(%r13), %rdi
	movq	%rax, %rbp
	call	atoi
	movl	%eax, %r14d
.L4:
	movq	16(%r13), %r9
	leaq	12(%rsp), %rdi
	movl	%ebx, %r8d
	movl	$.LC1, %ecx
	movl	$12, %edx
	movl	$1, %esi
	xorl	%eax, %eax
	call	__sprintf_chk
	leaq	12(%rsp), %rdi
	movl	$.LC2, %esi
	call	fopen
	leaq	24(%rsp), %rdi
	movq	%rbp, %rcx
	movl	%r14d, %edx
	movl	$1024, %esi
	movq	%rax, %r12
	call	__fgets_chk
	movq	%rbp, %rdi
	call	feof
	testl	%eax, %eax
	je	.L2
	movq	%r12, %rdi
	call	fclose
	jmp	.L3
.L2:
	leaq	24(%rsp), %rcx
	movl	$.LC3, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	xorl	%eax, %eax
	incl	%ebx
	call	__fprintf_chk
	movq	%r12, %rdi
	call	fclose
	cmpl	$100, %ebx
	jne	.L4
.L3:
	movq	%rbp, %rdi
	call	fclose
	xorl	%eax, %eax
	movq	1048(%rsp), %rdx
	xorq	%fs:40, %rdx
	je	.L5
	call	__stack_chk_fail
.L5:
	addq	$1056, %rsp
	.cfi_def_cfa_offset 48
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE21:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 4.8.2-19ubuntu1) 4.8.2"
	.section	.note.GNU-stack,"",@progbits
