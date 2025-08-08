=> 0x08000774 <+0>:	movs	r3, #0
   0x08000776 <+2>:	ldr	r1, [pc, #56]	; (0x80007b0 <tm_basic_processing_thread_0_entry+60>)
   0x08000778 <+4>:	mov	r2, r3
   0x0800077a <+6>:	push	{r4, r5}
   0x0800077c <+8>:	str.w	r2, [r1, r3, lsl #2]
   0x08000780 <+12>:	adds	r3, #1
   0x08000782 <+14>:	cmp.w	r3, #1024	; 0x400
   0x08000786 <+18>:	bne.n	0x800077c <tm_basic_processing_thread_0_entry+8>
   0x08000788 <+20>:	ldr	r5, [pc, #40]	; (0x80007b4 <tm_basic_processing_thread_0_entry+64>)
   0x0800078a <+22>:	movs	r3, #0
   0x0800078c <+24>:	ldr.w	r2, [r1, r3, lsl #2]
   0x08000790 <+28>:	ldr	r4, [r5, #0]
   0x08000792 <+30>:	ldr.w	r0, [r1, r3, lsl #2]
   0x08000796 <+34>:	add	r2, r4
   0x08000798 <+36>:	eors	r2, r0
   0x0800079a <+38>:	str.w	r2, [r1, r3, lsl #2]
   0x0800079e <+42>:	adds	r3, #1
   0x080007a0 <+44>:	cmp.w	r3, #1024	; 0x400
   0x080007a4 <+48>:	bne.n	0x800078c <tm_basic_processing_thread_0_entry+24>
   0x080007a6 <+50>:	ldr	r3, [r5, #0]
   0x080007a8 <+52>:	adds	r3, #1
   0x080007aa <+54>:	str	r3, [r5, #0]
   0x080007ac <+56>:	b.n	0x800078a <tm_basic_processing_thread_0_entry+22>
   0x080007ae <+58>:	nop
   0x080007b0 <+60>:	lsls	r0, r1, #25
   0x080007b2 <+62>:	movs	r4, #0
   0x080007b4 <+64>:	asrs	r0, r1, #25
   0x080007b6 <+66>:	movs	r4, #0
End of assembler dump.
