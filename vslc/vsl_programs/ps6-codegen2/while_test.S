.section .rodata
.intout: .string "%ld "
.strout: .string "%s "
.errout: .string "Wrong number of arguments"
.STR0: .string "foobar"
.STR1: .string "Skip..."
.section .data
.globl main
.section .text
main:
	pushq   %rbp
	movq    %rsp, %rbp
	subq	$1,%rdi
	cmpq	$0,%rdi
	jne	ABORT
	cmpq	$0,%rdi
	jz	SKIP_ARGS
	movq	%rdi,%rcx
	addq $0, %rsi
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
SKIP_ARGS:
	call	_while_test
	jmp	END
ABORT:
	movq	$.errout, %rdi
	call puts
END:
	movq    %rax, %rdi
	call    exit
_while_test:
	pushq   %rbp
	movq    %rsp, %rbp
	subq $8, %rsp
	pushq	$0 /* Stack padding for 16-byte alignment */
	movq	$20, %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rsi
	movq	$.intout, %rdi
	movq	$0, %rax
	call	printf
	movq	$0x0A, %rdi
	call	putchar
	movq	-8(%rbp), %rax
	pushq	%rax
	movq	$0, %rax
	popq	%r10
	cmp	%rax, %r10
	jle	.END_IF0
	movq	$.STR0, %rsi
	movq	$.strout, %rdi
	movq	$0, %rax
	call	printf
	movq	$0x0A, %rdi
	call	putchar
	.END_IF0:
	.WHILE0:
	movq	-8(%rbp), %rax
	pushq	%rax
	movq	$0, %rax
	popq	%r10
	cmp	%rax, %r10
	jle	.ENDWHILE0
	movq	-8(%rbp), %rax
	pushq	%rax
	movq	$10, %rax
	popq	%r10
	cmp	%rax, %r10
	jne	.ELSE1
	movq	$1, %rax
	subq	%rax, -8(%rbp)
	movq	$.STR1, %rsi
	movq	$.strout, %rdi
	movq	$0, %rax
	call	printf
	movq	$0x0A, %rdi
	call	putchar
	jmp .WHILE0
	jmp	.END_IF1
	.ELSE1:
	movq	$1, %rax
	subq	%rax, -8(%rbp)
	.END_IF1:
	movq	-8(%rbp), %rsi
	movq	$.intout, %rdi
	movq	$0, %rax
	call	printf
	movq	$0x0A, %rdi
	call	putchar

	jmp	.WHILE0
	.ENDWHILE0:
	movq	$0, %rax
	leave
	ret
	movq	%rbp, %rsp
	movq	$0, %rax
	popq	%rbp
	ret
