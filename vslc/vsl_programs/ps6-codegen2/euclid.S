.section .rodata
.intout: .string "%ld "
.strout: .string "%s "
.errout: .string "Wrong number of arguments"
.STR0: .string "Greatest common divisor of"
.STR1: .string "and"
.STR2: .string "is"
.STR3: .string "and"
.STR4: .string "are relative primes"
.section .data
.globl main
.section .text
main:
	pushq   %rbp
	movq    %rsp, %rbp
	subq	$1,%rdi
	cmpq	$2,%rdi
	jne	ABORT
	cmpq	$0,%rdi
	jz	SKIP_ARGS
	movq	%rdi,%rcx
	addq $16, %rsi
PARSE_ARGV:
	pushq %rcx
	pushq %rsi
	movq	(%rsi),%rdi
	movq	$0,%rsi
	movq	$10,%rdx
	call	strtol
	popq %rsi
	popq %rcx
	pushq %rax
	subq $8, %rsi
	loop PARSE_ARGV
	popq	%rdi
	popq	%rsi
SKIP_ARGS:
	call	_euclid
	jmp	END
ABORT:
	movq	$.errout, %rdi
	call puts
END:
	movq    %rax, %rdi
	call    exit
_gcd:
	pushq   %rbp
	movq    %rsp, %rbp
	pushq	%rdi
	pushq	%rsi
	subq $8, %rsp
	pushq	$0 /* Stack padding for 16-byte alignment */
	movq	-16(%rbp), %rax
	pushq	%rax
	movq	$0, %rax
	popq	%r10
	cmp	%rax, %r10
	jle	.ELSE0
	movq	-8(%rbp), %rax
	pushq	%rax
	pushq	%rdx
	movq	-16(%rbp), %rax
	pushq	%rax
	pushq	%rdx
	movq	-16(%rbp), %rax
	pushq	%rax
	movq	-8(%rbp), %rax
	cqo
	idivq	(%rsp)
	popq	%rdx
	popq	%rdx
	mulq	(%rsp)
	popq	%rdx
	popq	%rdx
	subq	%rax, (%rsp)
	popq	%rax
	movq	%rax, %rsi
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call _gcd
	movq	%rax, -24(%rbp)
	jmp	.END_IF0
	.ELSE0:
	movq	-8(%rbp), %rax
	movq	%rax, -24(%rbp)
	.END_IF0:
	movq	-24(%rbp), %rax
	leave
	ret
	movq	%rbp, %rsp
	movq	$0, %rax
	popq	%rbp
	ret
_euclid:
	pushq   %rbp
	movq    %rsp, %rbp
	pushq	%rdi
	pushq	%rsi
	movq	-8(%rbp), %rax
	pushq	%rax
	movq	$0, %rax
	popq	%r10
	cmp	%rax, %r10
	jge	.END_IF1
	movq	-8(%rbp), %rax
	negq	%rax
	movq	%rax, -8(%rbp)
	.END_IF1:
	movq	-16(%rbp), %rax
	pushq	%rax
	movq	$0, %rax
	popq	%r10
	cmp	%rax, %r10
	jge	.END_IF2
	movq	-16(%rbp), %rax
	negq	%rax
	movq	%rax, -16(%rbp)
	.END_IF2:
	movq	-16(%rbp), %rax
	movq	%rax, %rsi
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call _gcd
	pushq	%rax
	movq	$1, %rax
	popq	%r10
	cmp	%rax, %r10
	jle	.ELSE3
	movq	$.STR0, %rsi
	movq	$.strout, %rdi
	movq	$0, %rax
	call	printf
	movq	-8(%rbp), %rsi
	movq	$.intout, %rdi
	movq	$0, %rax
	call	printf
	movq	$.STR1, %rsi
	movq	$.strout, %rdi
	movq	$0, %rax
	call	printf
	movq	-16(%rbp), %rsi
	movq	$.intout, %rdi
	movq	$0, %rax
	call	printf
	movq	$.STR2, %rsi
	movq	$.strout, %rdi
	movq	$0, %rax
	call	printf
	movq	-16(%rbp), %rax
	movq	%rax, %rsi
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call _gcd
	movq	%rax, %rsi
	movq	$.intout, %rdi
	movq	$0, %rax
	call	printf
	movq	$0x0A, %rdi
	call	putchar
	jmp	.END_IF3
	.ELSE3:
	movq	-8(%rbp), %rsi
	movq	$.intout, %rdi
	movq	$0, %rax
	call	printf
	movq	$.STR3, %rsi
	movq	$.strout, %rdi
	movq	$0, %rax
	call	printf
	movq	-16(%rbp), %rsi
	movq	$.intout, %rdi
	movq	$0, %rax
	call	printf
	movq	$.STR4, %rsi
	movq	$.strout, %rdi
	movq	$0, %rax
	call	printf
	movq	$0x0A, %rdi
	call	putchar
	.END_IF3:
	movq	$0, %rax
	leave
	ret
	movq	%rbp, %rsp
	movq	$0, %rax
	popq	%rbp
	ret
