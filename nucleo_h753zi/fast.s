=> 0x0800076c <+0>:	movs	r3, #0
   0x0800076e <+2>:	ldr	r1, [pc, #56]	; (0x80007a8 <tm_basic_processing_thread_0_entry+60>)
   0x08000770 <+4>:	mov	r2, r3
   0x08000772 <+6>:	push	{r4, r5}
   0x08000774 <+8>:	str.w	r2, [r1, r3, lsl #2]
   0x08000778 <+12>:	adds	r3, #1
   0x0800077a <+14>:	cmp.w	r3, #1024	; 0x400
   0x0800077e <+18>:	bne.n	0x8000774 <tm_basic_processing_thread_0_entry+8>
   0x08000780 <+20>:	ldr	r5, [pc, #40]	; (0x80007ac <tm_basic_processing_thread_0_entry+64>)
   0x08000782 <+22>:	movs	r3, #0
   0x08000784 <+24>:	ldr.w	r2, [r1, r3, lsl #2]
   0x08000788 <+28>:	ldr	r4, [r5, #0]
   0x0800078a <+30>:	ldr.w	r0, [r1, r3, lsl #2]
   0x0800078e <+34>:	add	r2, r4
   0x08000790 <+36>:	eors	r2, r0
   0x08000792 <+38>:	str.w	r2, [r1, r3, lsl #2]
   0x08000796 <+42>:	adds	r3, #1
   0x08000798 <+44>:	cmp.w	r3, #1024	; 0x400
   0x0800079c <+48>:	bne.n	0x8000784 <tm_basic_processing_thread_0_entry+24>
   0x0800079e <+50>:	ldr	r3, [r5, #0]
   0x080007a0 <+52>:	adds	r3, #1
   0x080007a2 <+54>:	str	r3, [r5, #0]
   0x080007a4 <+56>:	b.n	0x8000782 <tm_basic_processing_thread_0_entry+22>
   0x080007a6 <+58>:	nop
   0x080007a8 <+60>:	lsls	r0, r3, #28
   0x080007aa <+62>:	movs	r4, #0
   0x080007ac <+64>:	asrs	r0, r3, #28
   0x080007ae <+66>:	movs	r4, #0
End of assembler dump.
