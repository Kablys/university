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
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB39:
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
	movl	$10, %edx
	xorl	%esi, %esi
	movq	%rax, %r12
	call	strtol
	movl	%eax, %r14d
	jmp	.L4
	.p2align 4,,10
	.p2align 3
.L2:
	leaq	16(%rsp), %rcx
	movl	$.LC3, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	addl	$1, %ebx
	call	__fprintf_chk
	movq	%rbp, %rdi
	call	fclose
	cmpl	$100, %ebx
	je	.L3
.L4:
	movq	16(%r13), %r9
	movl	%ebx, %r8d
	movl	$.LC1, %ecx
	movl	$12, %edx
	movl	$1, %esi
	movq	%rsp, %rdi
	xorl	%eax, %eax
	call	__sprintf_chk
	movl	$.LC2, %esi
	movq	%rsp, %rdi
	call	fopen
	leaq	16(%rsp), %rdi
	movq	%r12, %rcx
	movl	%r14d, %edx
	movl	$1024, %esi
	movq	%rax, %rbp
	call	__fgets_chk
	movq	%r12, %rdi
	call	feof
	testl	%eax, %eax
	je	.L2
	movq	%rbp, %rdi
	call	fclose
.L3:
	movq	%r12, %rdi
	call	fclose
	xorl	%eax, %eax
	movq	1048(%rsp), %rbx
	xorq	%fs:40, %rbx
	jne	.L11
	addq	$1056, %rsp
	.cfi_remember_state
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
.L11:
	.cfi_restore_state
	call	__stack_chk_fail
	.cfi_endproc
.LFE39:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 4.8.2-19ubuntu1) 4.8.2"
	.section	.note.GNU-stack,"",@progbits
