
kernel.bin:     file format binary


Disassembly of section .data:

00000000 <.data>:
       0:	00801a3c 	lui	k0,0x8000
       4:	0c195a27 	addiu	k0,k0,6412
       8:	08004003 	jr	k0
       c:	00000000 	nop
	...
    1180:	00801a3c 	lui	k0,0x8000
    1184:	101d5a27 	addiu	k0,k0,7440
    1188:	08004003 	jr	k0
    118c:	00000000 	nop
	...
    17f0:	d0bf093c 	lui	t1,0xbfd0
    17f4:	fc032881 	lb	t0,1020(t1)
    17f8:	01000831 	andi	t0,t0,0x1
    17fc:	03000015 	bnez	t0,0x180c
    1800:	00000000 	nop
    1804:	fd050008 	j	0x17f4
    1808:	00000000 	nop
    180c:	d0bf093c 	lui	t1,0xbfd0
    1810:	f80324a1 	sb	a0,1016(t1)
    1814:	0800e003 	jr	ra
    1818:	00000000 	nop
    181c:	d0bf093c 	lui	t1,0xbfd0
    1820:	fc032881 	lb	t0,1020(t1)
    1824:	02000831 	andi	t0,t0,0x2
    1828:	03000015 	bnez	t0,0x1838
    182c:	00000000 	nop
    1830:	08060008 	j	0x1820
    1834:	00000000 	nop
    1838:	d0bf093c 	lui	t1,0xbfd0
    183c:	f8032281 	lb	v0,1016(t1)
    1840:	0800e003 	jr	ra
    1844:	00000000 	nop
    1848:	ecffbd27 	addiu	sp,sp,-20
    184c:	0000bfaf 	sw	ra,0(sp)
    1850:	0400b0af 	sw	s0,4(sp)
    1854:	0800b1af 	sw	s1,8(sp)
    1858:	0c00b2af 	sw	s2,12(sp)
    185c:	1000b3af 	sw	s3,16(sp)
    1860:	0706000c 	jal	0x181c
    1864:	00000000 	nop
    1868:	25800200 	or	s0,zero,v0
    186c:	0706000c 	jal	0x181c
    1870:	00000000 	nop
    1874:	25880200 	or	s1,zero,v0
    1878:	0706000c 	jal	0x181c
    187c:	00000000 	nop
    1880:	25900200 	or	s2,zero,v0
    1884:	0706000c 	jal	0x181c
    1888:	00000000 	nop
    188c:	25980200 	or	s3,zero,v0
    1890:	ff001032 	andi	s0,s0,0xff
    1894:	ff007332 	andi	s3,s3,0xff
    1898:	ff005232 	andi	s2,s2,0xff
    189c:	ff003132 	andi	s1,s1,0xff
    18a0:	25101300 	or	v0,zero,s3
    18a4:	00120200 	sll	v0,v0,0x8
    18a8:	25105200 	or	v0,v0,s2
    18ac:	00120200 	sll	v0,v0,0x8
    18b0:	25105100 	or	v0,v0,s1
    18b4:	00120200 	sll	v0,v0,0x8
    18b8:	25105000 	or	v0,v0,s0
    18bc:	0000bf8f 	lw	ra,0(sp)
    18c0:	0400b08f 	lw	s0,4(sp)
    18c4:	0800b18f 	lw	s1,8(sp)
    18c8:	0c00b28f 	lw	s2,12(sp)
    18cc:	1000b38f 	lw	s3,16(sp)
    18d0:	1400bd27 	addiu	sp,sp,20
    18d4:	0800e003 	jr	ra
    18d8:	00000000 	nop
    18dc:	00000000 	nop
    18e0:	4d4f4e49 	0x494e4f4d
    18e4:	544f5220 	addi	s2,v0,20308
    18e8:	666f7220 	addi	s2,v1,28518
    18ec:	4d495053 	beql	k0,s0,0x13e24
    18f0:	3332202d 	sltiu	zero,t1,12851
    18f4:	20696e69 	ldl	t6,26912(t3)
    18f8:	7469616c 	ldr	at,26996(v1)
    18fc:	697a6564 	daddiu	a1,v1,31337
    1900:	2e000000 	dneg	zero,zero
    1904:	00007f80 	lb	ra,0(v1)
    1908:	90007f80 	lb	ra,144(v1)
    190c:	7f801a3c 	lui	k0,0x807f
    1910:	00005a27 	addiu	k0,k0,0
    1914:	7f801b3c 	lui	k1,0x807f
    1918:	90007b27 	addiu	k1,k1,144
    191c:	05005b13 	beq	k0,k1,0x1934
    1920:	00000000 	nop
    1924:	000040af 	sw	zero,0(k0)
    1928:	04005a27 	addiu	k0,k0,4
    192c:	fbff0010 	b	0x191c
    1930:	00000000 	nop
    1934:	80801d3c 	lui	sp,0x8080
    1938:	0000bd27 	addiu	sp,sp,0
    193c:	25f0a003 	move	s8,sp
    1940:	7f80083c 	lui	t0,0x807f
    1944:	00000825 	addiu	t0,t0,0
    1948:	7f80093c 	lui	t1,0x807f
    194c:	700028ad 	sw	t0,112(t1)
    1950:	7f80093c 	lui	t1,0x807f
    1954:	740028ad 	sw	t0,116(t1)
    1958:	d0bf083c 	lui	t0,0xbfd0
    195c:	10000934 	li	t1,0x10
    1960:	fc0309a1 	sb	t1,1020(t0)
    1964:	20000834 	li	t0,0x20
    1968:	ffff0825 	addiu	t0,t0,-1
    196c:	fcffbd27 	addiu	sp,sp,-4
    1970:	0000a0af 	sw	zero,0(sp)
    1974:	fcff0015 	bnez	t0,0x1968
    1978:	00000000 	nop
    197c:	7f80083c 	lui	t0,0x807f
    1980:	80000825 	addiu	t0,t0,128
    1984:	00001dad 	sw	sp,0(t0)
    1988:	2570a003 	move	t6,sp
    198c:	20000834 	li	t0,0x20
    1990:	ffff0825 	addiu	t0,t0,-1
    1994:	fcffbd27 	addiu	sp,sp,-4
    1998:	0000a0af 	sw	zero,0(sp)
    199c:	fcff0015 	bnez	t0,0x1990
    19a0:	00000000 	nop
    19a4:	7f80083c 	lui	t0,0x807f
    19a8:	80000825 	addiu	t0,t0,128
    19ac:	04001dad 	sw	sp,4(t0)
    19b0:	7c00ddad 	sw	sp,124(t6)
    19b4:	7f800a3c 	lui	t2,0x807f
    19b8:	84004a25 	addiu	t2,t2,132
    19bc:	00004a8d 	lw	t2,0(t2)
    19c0:	7f80093c 	lui	t1,0x807f
    19c4:	88002aad 	sw	t2,136(t1)
    19c8:	74060008 	j	0x19d0
    19cc:	00000000 	nop
    19d0:	0080103c 	lui	s0,0x8000
    19d4:	e0181026 	addiu	s0,s0,6368
    19d8:	00000482 	lb	a0,0(s0)
    19dc:	01001026 	addiu	s0,s0,1
    19e0:	fc05000c 	jal	0x17f0
    19e4:	00000000 	nop
    19e8:	00000482 	lb	a0,0(s0)
    19ec:	fbff8014 	bnez	a0,0x19dc
    19f0:	00000000 	nop
    19f4:	46100008 	j	0x4118
    19f8:	00000000 	nop
	...
    1a24:	7f060008 	j	0x19fc
    1a28:	00000000 	nop
    1a2c:	00000000 	nop
    1a30:	0706000c 	jal	0x181c
    1a34:	00000000 	nop
    1a38:	52000834 	li	t0,0x52
    1a3c:	26004810 	beq	v0,t0,0x1ad8
    1a40:	00000000 	nop
    1a44:	44000834 	li	t0,0x44
    1a48:	34004810 	beq	v0,t0,0x1b1c
    1a4c:	00000000 	nop
    1a50:	41000834 	li	t0,0x41
    1a54:	46004810 	beq	v0,t0,0x1b70
    1a58:	00000000 	nop
    1a5c:	47000834 	li	t0,0x47
    1a60:	59004810 	beq	v0,t0,0x1bc8
    1a64:	00000000 	nop
    1a68:	54000834 	li	t0,0x54
    1a6c:	03004810 	beq	v0,t0,0x1a7c
    1a70:	00000000 	nop
    1a74:	42070008 	j	0x1d08
    1a78:	00000000 	nop
    1a7c:	1206000c 	jal	0x1848
    1a80:	00000000 	nop
    1a84:	e8ffbd27 	addiu	sp,sp,-24
    1a88:	0000b0af 	sw	s0,0(sp)
    1a8c:	0400b1af 	sw	s1,4(sp)
    1a90:	ffff1024 	li	s0,-1
    1a94:	0c00b0af 	sw	s0,12(sp)
    1a98:	1000b0af 	sw	s0,16(sp)
    1a9c:	1400b0af 	sw	s0,20(sp)
    1aa0:	0c001134 	li	s1,0xc
    1aa4:	0c00b027 	addiu	s0,sp,12
    1aa8:	00000482 	lb	a0,0(s0)
    1aac:	ffff3126 	addiu	s1,s1,-1
    1ab0:	fc05000c 	jal	0x17f0
    1ab4:	00000000 	nop
    1ab8:	01001026 	addiu	s0,s0,1
    1abc:	faff2016 	bnez	s1,0x1aa8
    1ac0:	00000000 	nop
    1ac4:	0000b08f 	lw	s0,0(sp)
    1ac8:	0400b18f 	lw	s1,4(sp)
    1acc:	1800bd27 	addiu	sp,sp,24
    1ad0:	42070008 	j	0x1d08
    1ad4:	00000000 	nop
    1ad8:	f8ffbd27 	addiu	sp,sp,-8
    1adc:	0000b0af 	sw	s0,0(sp)
    1ae0:	0400b1af 	sw	s1,4(sp)
    1ae4:	7f80103c 	lui	s0,0x807f
    1ae8:	78001134 	li	s1,0x78
    1aec:	00000482 	lb	a0,0(s0)
    1af0:	ffff3126 	addiu	s1,s1,-1
    1af4:	fc05000c 	jal	0x17f0
    1af8:	00000000 	nop
    1afc:	01001026 	addiu	s0,s0,1
    1b00:	faff2016 	bnez	s1,0x1aec
    1b04:	00000000 	nop
    1b08:	0000b08f 	lw	s0,0(sp)
    1b0c:	0400b18f 	lw	s1,4(sp)
    1b10:	0800bd27 	addiu	sp,sp,8
    1b14:	42070008 	j	0x1d08
    1b18:	00000000 	nop
    1b1c:	f8ffbd27 	addiu	sp,sp,-8
    1b20:	0000b0af 	sw	s0,0(sp)
    1b24:	0400b1af 	sw	s1,4(sp)
    1b28:	1206000c 	jal	0x1848
    1b2c:	00000000 	nop
    1b30:	25804000 	move	s0,v0
    1b34:	1206000c 	jal	0x1848
    1b38:	00000000 	nop
    1b3c:	25884000 	move	s1,v0
    1b40:	00000482 	lb	a0,0(s0)
    1b44:	ffff3126 	addiu	s1,s1,-1
    1b48:	fc05000c 	jal	0x17f0
    1b4c:	00000000 	nop
    1b50:	01001026 	addiu	s0,s0,1
    1b54:	faff2016 	bnez	s1,0x1b40
    1b58:	00000000 	nop
    1b5c:	0000b08f 	lw	s0,0(sp)
    1b60:	0400b18f 	lw	s1,4(sp)
    1b64:	0800bd27 	addiu	sp,sp,8
    1b68:	42070008 	j	0x1d08
    1b6c:	00000000 	nop
    1b70:	f8ffbd27 	addiu	sp,sp,-8
    1b74:	0000b0af 	sw	s0,0(sp)
    1b78:	0400b1af 	sw	s1,4(sp)
    1b7c:	1206000c 	jal	0x1848
    1b80:	00000000 	nop
    1b84:	25804000 	move	s0,v0
    1b88:	1206000c 	jal	0x1848
    1b8c:	00000000 	nop
    1b90:	25884000 	move	s1,v0
    1b94:	82881100 	srl	s1,s1,0x2
    1b98:	1206000c 	jal	0x1848
    1b9c:	00000000 	nop
    1ba0:	000002ae 	sw	v0,0(s0)
    1ba4:	ffff3126 	addiu	s1,s1,-1
    1ba8:	04001026 	addiu	s0,s0,4
    1bac:	faff2016 	bnez	s1,0x1b98
    1bb0:	00000000 	nop
    1bb4:	0000b08f 	lw	s0,0(sp)
    1bb8:	0400b18f 	lw	s1,4(sp)
    1bbc:	0800bd27 	addiu	sp,sp,8
    1bc0:	42070008 	j	0x1d08
    1bc4:	00000000 	nop
    1bc8:	1206000c 	jal	0x1848
    1bcc:	00000000 	nop
    1bd0:	06000434 	li	a0,0x6
    1bd4:	fc05000c 	jal	0x17f0
    1bd8:	00000000 	nop
    1bdc:	25d04000 	move	k0,v0
    1be0:	7f801f3c 	lui	ra,0x807f
    1be4:	0000ff27 	addiu	ra,ra,0
    1be8:	7800e2af 	sw	v0,120(ra)
    1bec:	7c00fdaf 	sw	sp,124(ra)
    1bf0:	0000e18f 	lw	at,0(ra)
    1bf4:	0400e28f 	lw	v0,4(ra)
    1bf8:	0800e38f 	lw	v1,8(ra)
    1bfc:	0c00e48f 	lw	a0,12(ra)
    1c00:	1000e58f 	lw	a1,16(ra)
    1c04:	1400e68f 	lw	a2,20(ra)
    1c08:	1800e78f 	lw	a3,24(ra)
    1c0c:	1c00e88f 	lw	t0,28(ra)
    1c10:	2000e98f 	lw	t1,32(ra)
    1c14:	2400ea8f 	lw	t2,36(ra)
    1c18:	2800eb8f 	lw	t3,40(ra)
    1c1c:	2c00ec8f 	lw	t4,44(ra)
    1c20:	3000ed8f 	lw	t5,48(ra)
    1c24:	3400ee8f 	lw	t6,52(ra)
    1c28:	3800ef8f 	lw	t7,56(ra)
    1c2c:	3c00f08f 	lw	s0,60(ra)
    1c30:	4000f18f 	lw	s1,64(ra)
    1c34:	4400f28f 	lw	s2,68(ra)
    1c38:	4800f38f 	lw	s3,72(ra)
    1c3c:	4c00f48f 	lw	s4,76(ra)
    1c40:	5000f58f 	lw	s5,80(ra)
    1c44:	5400f68f 	lw	s6,84(ra)
    1c48:	5800f78f 	lw	s7,88(ra)
    1c4c:	5c00f88f 	lw	t8,92(ra)
    1c50:	6000f98f 	lw	t9,96(ra)
    1c54:	6c00fc8f 	lw	gp,108(ra)
    1c58:	7000fd8f 	lw	sp,112(ra)
    1c5c:	7400fe8f 	lw	s8,116(ra)
    1c60:	00801f3c 	lui	ra,0x8000
    1c64:	741cff27 	addiu	ra,ra,7284
    1c68:	00000000 	nop
    1c6c:	08004003 	jr	k0
    1c70:	00000000 	nop
    1c74:	00000000 	nop
    1c78:	7f801f3c 	lui	ra,0x807f
    1c7c:	0000ff27 	addiu	ra,ra,0
    1c80:	0000e1af 	sw	at,0(ra)
    1c84:	0400e2af 	sw	v0,4(ra)
    1c88:	0800e3af 	sw	v1,8(ra)
    1c8c:	0c00e4af 	sw	a0,12(ra)
    1c90:	1000e5af 	sw	a1,16(ra)
    1c94:	1400e6af 	sw	a2,20(ra)
    1c98:	1800e7af 	sw	a3,24(ra)
    1c9c:	1c00e8af 	sw	t0,28(ra)
    1ca0:	2000e9af 	sw	t1,32(ra)
    1ca4:	2400eaaf 	sw	t2,36(ra)
    1ca8:	2800ebaf 	sw	t3,40(ra)
    1cac:	2c00ecaf 	sw	t4,44(ra)
    1cb0:	3000edaf 	sw	t5,48(ra)
    1cb4:	3400eeaf 	sw	t6,52(ra)
    1cb8:	3800efaf 	sw	t7,56(ra)
    1cbc:	3c00f0af 	sw	s0,60(ra)
    1cc0:	4000f1af 	sw	s1,64(ra)
    1cc4:	4400f2af 	sw	s2,68(ra)
    1cc8:	4800f3af 	sw	s3,72(ra)
    1ccc:	4c00f4af 	sw	s4,76(ra)
    1cd0:	5000f5af 	sw	s5,80(ra)
    1cd4:	5400f6af 	sw	s6,84(ra)
    1cd8:	5800f7af 	sw	s7,88(ra)
    1cdc:	5c00f8af 	sw	t8,92(ra)
    1ce0:	6000f9af 	sw	t9,96(ra)
    1ce4:	6c00fcaf 	sw	gp,108(ra)
    1ce8:	7000fdaf 	sw	sp,112(ra)
    1cec:	7400feaf 	sw	s8,116(ra)
    1cf0:	7c00fd8f 	lw	sp,124(ra)
    1cf4:	07000434 	li	a0,0x7
    1cf8:	fc05000c 	jal	0x17f0
    1cfc:	00000000 	nop
    1d00:	42070008 	j	0x1d08
    1d04:	00000000 	nop
    1d08:	8c060008 	j	0x1a30
    1d0c:	00000000 	nop
    1d10:	ffff0010 	b	0x1d10
    1d14:	00000000 	nop
	...
    1d20:	ffff0010 	b	0x1d20
    1d24:	00000000 	nop
	...
    2000:	01004224 	addiu	v0,v0,1
    2004:	0800e003 	jr	ra
    2008:	00000000 	nop
    200c:	0004083c 	lui	t0,0x400
	...
    201c:	ffff0825 	addiu	t0,t0,-1
    2020:	00000934 	li	t1,0x0
    2024:	01000a34 	li	t2,0x1
    2028:	02000b34 	li	t3,0x2
    202c:	fbff0015 	bnez	t0,0x201c
    2030:	00000000 	nop
    2034:	00000000 	nop
    2038:	0800e003 	jr	ra
    203c:	00000000 	nop
    2040:	0001083c 	lui	t0,0x100
    2044:	01000934 	li	t1,0x1
    2048:	02000a34 	li	t2,0x2
    204c:	03000b34 	li	t3,0x3
    2050:	26504901 	xor	t2,t2,t1
    2054:	26482a01 	xor	t1,t1,t2
    2058:	26504901 	xor	t2,t2,t1
    205c:	26586a01 	xor	t3,t3,t2
    2060:	26504b01 	xor	t2,t2,t3
    2064:	26586a01 	xor	t3,t3,t2
    2068:	26482b01 	xor	t1,t1,t3
    206c:	26586901 	xor	t3,t3,t1
    2070:	26482b01 	xor	t1,t1,t3
    2074:	ffff0825 	addiu	t0,t0,-1
    2078:	f5ff0015 	bnez	t0,0x2050
    207c:	00000000 	nop
    2080:	0800e003 	jr	ra
    2084:	00000000 	nop
    2088:	0004083c 	lui	t0,0x400
    208c:	03000015 	bnez	t0,0x209c
    2090:	00000000 	nop
    2094:	0800e003 	jr	ra
    2098:	00000000 	nop
    209c:	29080008 	j	0x20a4
    20a0:	00000000 	nop
    20a4:	ffff0825 	addiu	t0,t0,-1
    20a8:	23080008 	j	0x208c
    20ac:	ffff0825 	addiu	t0,t0,-1
    20b0:	00000000 	nop
    20b4:	0002083c 	lui	t0,0x200
    20b8:	fcffbd27 	addiu	sp,sp,-4
    20bc:	0000a8af 	sw	t0,0(sp)
    20c0:	0000a98f 	lw	t1,0(sp)
    20c4:	ffff2925 	addiu	t1,t1,-1
    20c8:	0000a9af 	sw	t1,0(sp)
    20cc:	0000a88f 	lw	t0,0(sp)
    20d0:	faff0015 	bnez	t0,0x20bc
    20d4:	00000000 	nop
    20d8:	0400bd27 	addiu	sp,sp,4
    20dc:	0800e003 	jr	ra
    20e0:	00000000 	nop
	...
    20f0:	48656c6c 	ldr	t4,25928(v1)
    20f4:	6f20776f 	ldr	s7,8303(k1)
    20f8:	726c6421 	addi	a0,t3,27762
    20fc:	0a000000 	0xa
    2100:	48414c20 	addi	t4,v0,16712
    2104:	496e6974 	jalx	0x1a5b925
    2108:	69616c69 	ldl	t4,24937(t3)
    210c:	7a65640a 	j	0x99195e8
    2110:	00000000 	nop
    2114:	5249503a 	xori	s0,s2,0x4952
    2118:	20526571 	0x71655220
    211c:	75697265 	daddiu	s2,t3,26997
    2120:	0a000000 	0xa
    2124:	25315825 	addiu	t8,t2,12581
    2128:	31582000 	tgeu	at,zero,0x160
    212c:	0a000000 	0xa
    2130:	4655434b 	c2	0x1435546
    2134:	0a000000 	0xa
    2138:	53746172 	0x72617453
    213c:	74210a00 	teq	zero,t2,0x85
    2140:	53746172 	0x72617453
    2144:	740a0000 	teq	zero,zero,0x29
    2148:	5249503a 	xori	s0,s2,0x4952
    214c:	2042726f 	ldr	s2,16928(k1)
    2150:	61646361 	daddi	v1,t3,25697
    2154:	7374696e 	ldr	t1,29811(s3)
    2158:	670a0000 	0xa67
    215c:	5061636b 	ldl	v1,24912(k1)
    2160:	65742069 	ldl	zero,29797(t1)
    2164:	73207472 	0x72742073
    2168:	756e6361 	daddi	v1,t3,28277
    216c:	7465642c 	sltiu	a0,v1,25972
    2170:	2069676e 	ldr	a3,26912(s3)
    2174:	6f726520 	addi	a1,v1,29295
    2178:	69740a00 	0xa7469
    217c:	496e7661 	daddi	s6,t3,28233
    2180:	6c696420 	addi	a0,v1,26988
    2184:	49502043 	c0	0x1205049
    2188:	6865636b 	ldl	v1,25960(k1)
    218c:	73756d20 	addi	t5,v1,30067
    2190:	6c656e20 	addi	t6,v1,25964
    2194:	25640a00 	0xa6425
    2198:	52656365 	daddiu	v1,t3,25938
    219c:	69766520 	addi	a1,v1,30313
    21a0:	52495020 	addi	s0,v0,18770
    21a4:	7061636b 	ldl	v1,24944(k1)
    21a8:	65742000 	0x207465
    21ac:	436f6d6d 	ldr	t5,28483(t3)
    21b0:	6f6e643a 	xori	a0,s3,0x6e6f
    21b4:	20726571 	0x71657220
    21b8:	75657374 	jalx	0x1cd95d5
    21bc:	0a000000 	0xa
    21c0:	436f6d6d 	ldr	t5,28483(t3)
    21c4:	6f6e643a 	xori	a0,s3,0x6e6f
    21c8:	20726573 	0x73657220
    21cc:	706f6e73 	0x736e6f70
    21d0:	65202564 	daddiu	a1,at,8293
    21d4:	0a000000 	0xa
    21d8:	55706461 	daddi	a0,t3,28757
    21dc:	74653a20 	addi	k0,at,25972
    21e0:	25642072 	0x72206425
    21e4:	65636f72 	0x726f6365
    21e8:	64287329 	slti	s3,t3,10340
    21ec:	2025640a 	j	0x9909480
    21f0:	00000000 	nop
    21f4:	4950206e 	ldr	zero,20553(s1)
    21f8:	6f742066 	daddiu	zero,s1,29807
    21fc:	6f756e64 	daddiu	t6,v1,30063
    2200:	20666f72 	0x726f6620
    2204:	2025780a 	j	0x9e09480
    2208:	00000000 	nop
    220c:	00000000 	nop
    2210:	e8ffbd27 	addiu	sp,sp,-24
    2214:	1400beaf 	sw	s8,20(sp)
    2218:	25f0a003 	move	s8,sp
    221c:	1800c4af 	sw	a0,24(s8)
    2220:	1c00c5af 	sw	a1,28(s8)
    2224:	1800c28f 	lw	v0,24(s8)
    2228:	00004290 	lbu	v0,0(v0)
    222c:	0f004230 	andi	v0,v0,0xf
    2230:	80100200 	sll	v0,v0,0x2
    2234:	0800c2af 	sw	v0,8(s8)
    2238:	0000c0af 	sw	zero,0(s8)
    223c:	0400c0af 	sw	zero,4(s8)
    2240:	0400c38f 	lw	v1,4(s8)
    2244:	0800c28f 	lw	v0,8(s8)
    2248:	2a106200 	slt	v0,v1,v0
    224c:	27004010 	beqz	v0,0x22ec
    2250:	00000000 	nop
    2254:	0400c38f 	lw	v1,4(s8)
    2258:	0a000224 	li	v0,10
    225c:	1d006210 	beq	v1,v0,0x22d4
    2260:	00000000 	nop
    2264:	0400c28f 	lw	v0,4(s8)
    2268:	1800c38f 	lw	v1,24(s8)
    226c:	21106200 	addu	v0,v1,v0
    2270:	00004290 	lbu	v0,0(v0)
    2274:	00120200 	sll	v0,v0,0x8
    2278:	25184000 	move	v1,v0
    227c:	0000c28f 	lw	v0,0(s8)
    2280:	21106200 	addu	v0,v1,v0
    2284:	0400c38f 	lw	v1,4(s8)
    2288:	01006324 	addiu	v1,v1,1
    228c:	1800c48f 	lw	a0,24(s8)
    2290:	21188300 	addu	v1,a0,v1
    2294:	00006390 	lbu	v1,0(v1)
    2298:	21104300 	addu	v0,v0,v1
    229c:	0000c2af 	sw	v0,0(s8)
    22a0:	0000c38f 	lw	v1,0(s8)
    22a4:	0100023c 	lui	v0,0x1
    22a8:	2b106200 	sltu	v0,v1,v0
    22ac:	0a004014 	bnez	v0,0x22d8
    22b0:	00000000 	nop
    22b4:	0000c28f 	lw	v0,0(s8)
    22b8:	ffff4330 	andi	v1,v0,0xffff
    22bc:	0000c28f 	lw	v0,0(s8)
    22c0:	02140200 	srl	v0,v0,0x10
    22c4:	21106200 	addu	v0,v1,v0
    22c8:	0000c2af 	sw	v0,0(s8)
    22cc:	f4ff0010 	b	0x22a0
    22d0:	00000000 	nop
    22d4:	00000000 	nop
    22d8:	0400c28f 	lw	v0,4(s8)
    22dc:	02004224 	addiu	v0,v0,2
    22e0:	0400c2af 	sw	v0,4(s8)
    22e4:	d6ff0010 	b	0x2240
    22e8:	00000000 	nop
    22ec:	0000c28f 	lw	v0,0(s8)
    22f0:	27100200 	nor	v0,zero,v0
    22f4:	ffff4230 	andi	v0,v0,0xffff
    22f8:	25e8c003 	move	sp,s8
    22fc:	1400be8f 	lw	s8,20(sp)
    2300:	1800bd27 	addiu	sp,sp,24
    2304:	0800e003 	jr	ra
    2308:	00000000 	nop
    230c:	e0ffbd27 	addiu	sp,sp,-32
    2310:	1c00bfaf 	sw	ra,28(sp)
    2314:	1800beaf 	sw	s8,24(sp)
    2318:	25f0a003 	move	s8,sp
    231c:	2000c4af 	sw	a0,32(s8)
    2320:	2400c5af 	sw	a1,36(s8)
    2324:	2000c28f 	lw	v0,32(s8)
    2328:	0a004224 	addiu	v0,v0,10
    232c:	00004290 	lbu	v0,0(v0)
    2330:	00120200 	sll	v0,v0,0x8
    2334:	2000c38f 	lw	v1,32(s8)
    2338:	0b006324 	addiu	v1,v1,11
    233c:	00006390 	lbu	v1,0(v1)
    2340:	21104300 	addu	v0,v0,v1
    2344:	1000c2af 	sw	v0,16(s8)
    2348:	2400c58f 	lw	a1,36(s8)
    234c:	2000c48f 	lw	a0,32(s8)
    2350:	8408000c 	jal	0x2210
    2354:	00000000 	nop
    2358:	1400c2af 	sw	v0,20(s8)
    235c:	1000c38f 	lw	v1,16(s8)
    2360:	1400c28f 	lw	v0,20(s8)
    2364:	26106200 	xor	v0,v1,v0
    2368:	0100422c 	sltiu	v0,v0,1
    236c:	ff004230 	andi	v0,v0,0xff
    2370:	25e8c003 	move	sp,s8
    2374:	1c00bf8f 	lw	ra,28(sp)
    2378:	1800be8f 	lw	s8,24(sp)
    237c:	2000bd27 	addiu	sp,sp,32
    2380:	0800e003 	jr	ra
    2384:	00000000 	nop
    2388:	d8ffbd27 	addiu	sp,sp,-40
    238c:	2400bfaf 	sw	ra,36(sp)
    2390:	2000beaf 	sw	s8,32(sp)
    2394:	25f0a003 	move	s8,sp
    2398:	2800c4af 	sw	a0,40(s8)
    239c:	2c00c5af 	sw	a1,44(s8)
    23a0:	2800c28f 	lw	v0,40(s8)
    23a4:	0a004224 	addiu	v0,v0,10
    23a8:	00004290 	lbu	v0,0(v0)
    23ac:	00120200 	sll	v0,v0,0x8
    23b0:	2800c38f 	lw	v1,40(s8)
    23b4:	0b006324 	addiu	v1,v1,11
    23b8:	00006390 	lbu	v1,0(v1)
    23bc:	21104300 	addu	v0,v0,v1
    23c0:	1000c2af 	sw	v0,16(s8)
    23c4:	2c00c58f 	lw	a1,44(s8)
    23c8:	2800c48f 	lw	a0,40(s8)
    23cc:	8408000c 	jal	0x2210
    23d0:	00000000 	nop
    23d4:	1400c2af 	sw	v0,20(s8)
    23d8:	1000c38f 	lw	v1,16(s8)
    23dc:	1400c28f 	lw	v0,20(s8)
    23e0:	04006210 	beq	v1,v0,0x23f4
    23e4:	00000000 	nop
    23e8:	25100000 	move	v0,zero
    23ec:	18000010 	b	0x2450
    23f0:	00000000 	nop
    23f4:	2800c28f 	lw	v0,40(s8)
    23f8:	08004224 	addiu	v0,v0,8
    23fc:	00004390 	lbu	v1,0(v0)
    2400:	ffff6324 	addiu	v1,v1,-1
    2404:	ff006330 	andi	v1,v1,0xff
    2408:	000043a0 	sb	v1,0(v0)
    240c:	2c00c58f 	lw	a1,44(s8)
    2410:	2800c48f 	lw	a0,40(s8)
    2414:	8408000c 	jal	0x2210
    2418:	00000000 	nop
    241c:	1800c2af 	sw	v0,24(s8)
    2420:	1800c28f 	lw	v0,24(s8)
    2424:	021a0200 	srl	v1,v0,0x8
    2428:	2800c28f 	lw	v0,40(s8)
    242c:	0a004224 	addiu	v0,v0,10
    2430:	ff006330 	andi	v1,v1,0xff
    2434:	000043a0 	sb	v1,0(v0)
    2438:	2800c28f 	lw	v0,40(s8)
    243c:	0b004224 	addiu	v0,v0,11
    2440:	1800c38f 	lw	v1,24(s8)
    2444:	ff006330 	andi	v1,v1,0xff
    2448:	000043a0 	sb	v1,0(v0)
    244c:	01000224 	li	v0,1
    2450:	25e8c003 	move	sp,s8
    2454:	2400bf8f 	lw	ra,36(sp)
    2458:	2000be8f 	lw	s8,32(sp)
    245c:	2800bd27 	addiu	sp,sp,40
    2460:	0800e003 	jr	ra
    2464:	00000000 	nop
    2468:	f0ffbd27 	addiu	sp,sp,-16
    246c:	0c00beaf 	sw	s8,12(sp)
    2470:	25f0a003 	move	s8,sp
    2474:	1000c4af 	sw	a0,16(s8)
    2478:	1400c5af 	sw	a1,20(s8)
    247c:	1800c6af 	sw	a2,24(s8)
    2480:	1400c28f 	lw	v0,20(s8)
    2484:	0000c2af 	sw	v0,0(s8)
    2488:	1000c28f 	lw	v0,16(s8)
    248c:	0400c2af 	sw	v0,4(s8)
    2490:	1800c28f 	lw	v0,24(s8)
    2494:	ffff4324 	addiu	v1,v0,-1
    2498:	1800c3af 	sw	v1,24(s8)
    249c:	2b100200 	sltu	v0,zero,v0
    24a0:	ff004230 	andi	v0,v0,0xff
    24a4:	0b004010 	beqz	v0,0x24d4
    24a8:	00000000 	nop
    24ac:	0000c38f 	lw	v1,0(s8)
    24b0:	01006224 	addiu	v0,v1,1
    24b4:	0000c2af 	sw	v0,0(s8)
    24b8:	0400c28f 	lw	v0,4(s8)
    24bc:	01004424 	addiu	a0,v0,1
    24c0:	0400c4af 	sw	a0,4(s8)
    24c4:	00006390 	lbu	v1,0(v1)
    24c8:	000043a0 	sb	v1,0(v0)
    24cc:	f0ff0010 	b	0x2490
    24d0:	00000000 	nop
    24d4:	1000c28f 	lw	v0,16(s8)
    24d8:	25e8c003 	move	sp,s8
    24dc:	0c00be8f 	lw	s8,12(sp)
    24e0:	1000bd27 	addiu	sp,sp,16
    24e4:	0800e003 	jr	ra
    24e8:	00000000 	nop
    24ec:	f8ffbd27 	addiu	sp,sp,-8
    24f0:	0400beaf 	sw	s8,4(sp)
    24f4:	25f0a003 	move	s8,sp
    24f8:	0800c4af 	sw	a0,8(s8)
    24fc:	0800c28f 	lw	v0,8(s8)
    2500:	25e8c003 	move	sp,s8
    2504:	0400be8f 	lw	s8,4(sp)
    2508:	0800bd27 	addiu	sp,sp,8
    250c:	0800e003 	jr	ra
    2510:	00000000 	nop
    2514:	f8ffbd27 	addiu	sp,sp,-8
    2518:	0400beaf 	sw	s8,4(sp)
    251c:	25f0a003 	move	s8,sp
    2520:	0800c4af 	sw	a0,8(s8)
    2524:	0800c28f 	lw	v0,8(s8)
    2528:	25e8c003 	move	sp,s8
    252c:	0400be8f 	lw	s8,4(sp)
    2530:	0800bd27 	addiu	sp,sp,8
    2534:	0800e003 	jr	ra
    2538:	00000000 	nop
    253c:	f8ffbd27 	addiu	sp,sp,-8
    2540:	0400beaf 	sw	s8,4(sp)
    2544:	25f0a003 	move	s8,sp
    2548:	0800c4af 	sw	a0,8(s8)
    254c:	0800c28f 	lw	v0,8(s8)
    2550:	25e8c003 	move	sp,s8
    2554:	0400be8f 	lw	s8,4(sp)
    2558:	0800bd27 	addiu	sp,sp,8
    255c:	0800e003 	jr	ra
    2560:	00000000 	nop
    2564:	f8ffbd27 	addiu	sp,sp,-8
    2568:	0400beaf 	sw	s8,4(sp)
    256c:	25f0a003 	move	s8,sp
    2570:	0800c4af 	sw	a0,8(s8)
    2574:	0800c28f 	lw	v0,8(s8)
    2578:	25e8c003 	move	sp,s8
    257c:	0400be8f 	lw	s8,4(sp)
    2580:	0800bd27 	addiu	sp,sp,8
    2584:	0800e003 	jr	ra
    2588:	00000000 	nop
    258c:	e8ffbd27 	addiu	sp,sp,-24
    2590:	1400bfaf 	sw	ra,20(sp)
    2594:	1000beaf 	sw	s8,16(sp)
    2598:	25f0a003 	move	s8,sp
    259c:	1800c4af 	sw	a0,24(s8)
    25a0:	1c00c5af 	sw	a1,28(s8)
    25a4:	7f80023c 	lui	v0,0x807f
    25a8:	9000428c 	lw	v0,144(v0)
    25ac:	04004010 	beqz	v0,0x25c0
    25b0:	00000000 	nop
    25b4:	25100000 	move	v0,zero
    25b8:	0b000010 	b	0x25e8
    25bc:	00000000 	nop
    25c0:	7f80023c 	lui	v0,0x807f
    25c4:	01000324 	li	v1,1
    25c8:	900043ac 	sw	v1,144(v0)
    25cc:	10000624 	li	a2,16
    25d0:	1c00c58f 	lw	a1,28(s8)
    25d4:	7f80023c 	lui	v0,0x807f
    25d8:	94004424 	addiu	a0,v0,148
    25dc:	1a09000c 	jal	0x2468
    25e0:	00000000 	nop
    25e4:	25100000 	move	v0,zero
    25e8:	25e8c003 	move	sp,s8
    25ec:	1400bf8f 	lw	ra,20(sp)
    25f0:	1000be8f 	lw	s8,16(sp)
    25f4:	1800bd27 	addiu	sp,sp,24
    25f8:	0800e003 	jr	ra
    25fc:	00000000 	nop
    2600:	e8ffbd27 	addiu	sp,sp,-24
    2604:	1400bfaf 	sw	ra,20(sp)
    2608:	1000beaf 	sw	s8,16(sp)
    260c:	25f0a003 	move	s8,sp
    2610:	00bb043c 	lui	a0,0xbb00
    2614:	5909000c 	jal	0x2564
    2618:	00000000 	nop
    261c:	0400438c 	lw	v1,4(v0)
    2620:	0000428c 	lw	v0,0(v0)
    2624:	25e8c003 	move	sp,s8
    2628:	1400bf8f 	lw	ra,20(sp)
    262c:	1000be8f 	lw	s8,16(sp)
    2630:	1800bd27 	addiu	sp,sp,24
    2634:	0800e003 	jr	ra
    2638:	00000000 	nop
    263c:	f8ffbd27 	addiu	sp,sp,-8
    2640:	0400beaf 	sw	s8,4(sp)
    2644:	25f0a003 	move	s8,sp
    2648:	0800c4af 	sw	a0,8(s8)
    264c:	0c00c5af 	sw	a1,12(s8)
    2650:	1000c6af 	sw	a2,16(s8)
    2654:	7f80023c 	lui	v0,0x807f
    2658:	9000428c 	lw	v0,144(v0)
    265c:	04004014 	bnez	v0,0x2670
    2660:	00000000 	nop
    2664:	1bfc0224 	li	v0,-997
    2668:	02000010 	b	0x2674
    266c:	00000000 	nop
    2670:	1dfc0224 	li	v0,-995
    2674:	25e8c003 	move	sp,s8
    2678:	0400be8f 	lw	s8,4(sp)
    267c:	0800bd27 	addiu	sp,sp,8
    2680:	0800e003 	jr	ra
    2684:	00000000 	nop
    2688:	e8ffbd27 	addiu	sp,sp,-24
    268c:	1400bfaf 	sw	ra,20(sp)
    2690:	1000beaf 	sw	s8,16(sp)
    2694:	25f0a003 	move	s8,sp
    2698:	1800c4af 	sw	a0,24(s8)
    269c:	1c00c5af 	sw	a1,28(s8)
    26a0:	7f80023c 	lui	v0,0x807f
    26a4:	9000428c 	lw	v0,144(v0)
    26a8:	04004014 	bnez	v0,0x26bc
    26ac:	00000000 	nop
    26b0:	1bfc0224 	li	v0,-997
    26b4:	19000010 	b	0x271c
    26b8:	00000000 	nop
    26bc:	1800c28f 	lw	v0,24(s8)
    26c0:	04004228 	slti	v0,v0,4
    26c4:	04004010 	beqz	v0,0x26d8
    26c8:	00000000 	nop
    26cc:	1800c28f 	lw	v0,24(s8)
    26d0:	04004104 	bgez	v0,0x26e4
    26d4:	00000000 	nop
    26d8:	1afc0224 	li	v0,-998
    26dc:	0f000010 	b	0x271c
    26e0:	00000000 	nop
    26e4:	1800c38f 	lw	v1,24(s8)
    26e8:	25106000 	move	v0,v1
    26ec:	40100200 	sll	v0,v0,0x1
    26f0:	21104300 	addu	v0,v0,v1
    26f4:	40100200 	sll	v0,v0,0x1
    26f8:	0080033c 	lui	v1,0x8000
    26fc:	88556324 	addiu	v1,v1,21896
    2700:	21104300 	addu	v0,v0,v1
    2704:	06000624 	li	a2,6
    2708:	25284000 	move	a1,v0
    270c:	1c00c48f 	lw	a0,28(s8)
    2710:	1a09000c 	jal	0x2468
    2714:	00000000 	nop
    2718:	25100000 	move	v0,zero
    271c:	25e8c003 	move	sp,s8
    2720:	1400bf8f 	lw	ra,20(sp)
    2724:	1000be8f 	lw	s8,16(sp)
    2728:	1800bd27 	addiu	sp,sp,24
    272c:	0800e003 	jr	ra
    2730:	00000000 	nop
    2734:	c8ffbd27 	addiu	sp,sp,-56
    2738:	3400bfaf 	sw	ra,52(sp)
    273c:	3000beaf 	sw	s8,48(sp)
    2740:	25f0a003 	move	s8,sp
    2744:	3800c4af 	sw	a0,56(s8)
    2748:	3c00c5af 	sw	a1,60(s8)
    274c:	4000c6af 	sw	a2,64(s8)
    2750:	4400c7af 	sw	a3,68(s8)
    2754:	7f80023c 	lui	v0,0x807f
    2758:	9000428c 	lw	v0,144(v0)
    275c:	04004014 	bnez	v0,0x2770
    2760:	00000000 	nop
    2764:	1bfc0224 	li	v0,-997
    2768:	a6000010 	b	0x2a04
    276c:	00000000 	nop
    2770:	3800c28f 	lw	v0,56(s8)
    2774:	0f004230 	andi	v0,v0,0xf
    2778:	0c004010 	beqz	v0,0x27ac
    277c:	00000000 	nop
    2780:	5400c28f 	lw	v0,84(s8)
    2784:	0c004104 	bgez	v0,0x27b8
    2788:	00000000 	nop
    278c:	5000c38f 	lw	v1,80(s8)
    2790:	ffff0224 	li	v0,-1
    2794:	05006214 	bne	v1,v0,0x27ac
    2798:	00000000 	nop
    279c:	5400c38f 	lw	v1,84(s8)
    27a0:	ffff0224 	li	v0,-1
    27a4:	04006210 	beq	v1,v0,0x27b8
    27a8:	00000000 	nop
    27ac:	18fc0224 	li	v0,-1000
    27b0:	94000010 	b	0x2a04
    27b4:	00000000 	nop
    27b8:	3800c38f 	lw	v1,56(s8)
    27bc:	0f000224 	li	v0,15
    27c0:	04006210 	beq	v1,v0,0x27d4
    27c4:	00000000 	nop
    27c8:	1dfc0224 	li	v0,-995
    27cc:	8d000010 	b	0x2a04
    27d0:	00000000 	nop
    27d4:	8009000c 	jal	0x2600
    27d8:	00000000 	nop
    27dc:	1000c2af 	sw	v0,16(s8)
    27e0:	1400c3af 	sw	v1,20(s8)
    27e4:	25100000 	move	v0,zero
    27e8:	25180000 	move	v1,zero
    27ec:	1800c2af 	sw	v0,24(s8)
    27f0:	1c00c3af 	sw	v1,28(s8)
    27f4:	5000c38f 	lw	v1,80(s8)
    27f8:	ffff0224 	li	v0,-1
    27fc:	05006214 	bne	v1,v0,0x2814
    2800:	00000000 	nop
    2804:	5400c38f 	lw	v1,84(s8)
    2808:	ffff0224 	li	v0,-1
    280c:	1a006210 	beq	v1,v0,0x2878
    2810:	00000000 	nop
    2814:	8009000c 	jal	0x2600
    2818:	00000000 	nop
    281c:	1800c2af 	sw	v0,24(s8)
    2820:	1c00c3af 	sw	v1,28(s8)
    2824:	5000c48f 	lw	a0,80(s8)
    2828:	5400c58f 	lw	a1,84(s8)
    282c:	1000c68f 	lw	a2,16(s8)
    2830:	1400c78f 	lw	a3,20(s8)
    2834:	21108600 	addu	v0,a0,a2
    2838:	2b404400 	sltu	t0,v0,a0
    283c:	2118a700 	addu	v1,a1,a3
    2840:	21200301 	addu	a0,t0,v1
    2844:	25188000 	move	v1,a0
    2848:	1c00c48f 	lw	a0,28(s8)
    284c:	2b208300 	sltu	a0,a0,v1
    2850:	09008014 	bnez	a0,0x2878
    2854:	00000000 	nop
    2858:	1c00c48f 	lw	a0,28(s8)
    285c:	25286000 	move	a1,v1
    2860:	08008514 	bne	a0,a1,0x2884
    2864:	00000000 	nop
    2868:	1800c48f 	lw	a0,24(s8)
    286c:	2b108200 	sltu	v0,a0,v0
    2870:	04004010 	beqz	v0,0x2884
    2874:	00000000 	nop
    2878:	01000224 	li	v0,1
    287c:	02000010 	b	0x2888
    2880:	00000000 	nop
    2884:	25100000 	move	v0,zero
    2888:	5d004010 	beqz	v0,0x2a00
    288c:	00000000 	nop
    2890:	00bb023c 	lui	v0,0xbb00
    2894:	20004434 	ori	a0,v0,0x20
    2898:	3b09000c 	jal	0x24ec
    289c:	00000000 	nop
    28a0:	00004290 	lbu	v0,0(v0)
    28a4:	01004238 	xori	v0,v0,0x1
    28a8:	0100422c 	sltiu	v0,v0,1
    28ac:	ff004230 	andi	v0,v0,0xff
    28b0:	d0ff4010 	beqz	v0,0x27f4
    28b4:	00000000 	nop
    28b8:	00bb023c 	lui	v0,0xbb00
    28bc:	40004434 	ori	a0,v0,0x40
    28c0:	4f09000c 	jal	0x253c
    28c4:	00000000 	nop
    28c8:	0000428c 	lw	v0,0(v0)
    28cc:	2000c2af 	sw	v0,32(s8)
    28d0:	00bb023c 	lui	v0,0xbb00
    28d4:	44004434 	ori	a0,v0,0x44
    28d8:	3b09000c 	jal	0x24ec
    28dc:	00000000 	nop
    28e0:	2400c2af 	sw	v0,36(s8)
    28e4:	2400c28f 	lw	v0,36(s8)
    28e8:	3e004010 	beqz	v0,0x29e4
    28ec:	00000000 	nop
    28f0:	2000c28f 	lw	v0,32(s8)
    28f4:	1200422c 	sltiu	v0,v0,18
    28f8:	3a004014 	bnez	v0,0x29e4
    28fc:	00000000 	nop
    2900:	2400c28f 	lw	v0,36(s8)
    2904:	10004224 	addiu	v0,v0,16
    2908:	00004390 	lbu	v1,0(v0)
    290c:	08000224 	li	v0,8
    2910:	34006214 	bne	v1,v0,0x29e4
    2914:	00000000 	nop
    2918:	2400c28f 	lw	v0,36(s8)
    291c:	11004224 	addiu	v0,v0,17
    2920:	00004290 	lbu	v0,0(v0)
    2924:	2f004014 	bnez	v0,0x29e4
    2928:	00000000 	nop
    292c:	06000624 	li	a2,6
    2930:	2400c58f 	lw	a1,36(s8)
    2934:	4800c48f 	lw	a0,72(s8)
    2938:	1a09000c 	jal	0x2468
    293c:	00000000 	nop
    2940:	2400c28f 	lw	v0,36(s8)
    2944:	06004224 	addiu	v0,v0,6
    2948:	06000624 	li	a2,6
    294c:	25284000 	move	a1,v0
    2950:	4400c48f 	lw	a0,68(s8)
    2954:	1a09000c 	jal	0x2468
    2958:	00000000 	nop
    295c:	2400c28f 	lw	v0,36(s8)
    2960:	0f004224 	addiu	v0,v0,15
    2964:	00004290 	lbu	v0,0(v0)
    2968:	ffff4324 	addiu	v1,v0,-1
    296c:	5800c28f 	lw	v0,88(s8)
    2970:	000043ac 	sw	v1,0(v0)
    2974:	2000c28f 	lw	v0,32(s8)
    2978:	eeff4224 	addiu	v0,v0,-18
    297c:	2800c2af 	sw	v0,40(s8)
    2980:	2000c38f 	lw	v1,32(s8)
    2984:	2800c28f 	lw	v0,40(s8)
    2988:	2b104300 	sltu	v0,v0,v1
    298c:	04004010 	beqz	v0,0x29a0
    2990:	00000000 	nop
    2994:	2800c28f 	lw	v0,40(s8)
    2998:	02000010 	b	0x29a4
    299c:	00000000 	nop
    29a0:	2000c28f 	lw	v0,32(s8)
    29a4:	2c00c2af 	sw	v0,44(s8)
    29a8:	2400c28f 	lw	v0,36(s8)
    29ac:	12004224 	addiu	v0,v0,18
    29b0:	2c00c68f 	lw	a2,44(s8)
    29b4:	25284000 	move	a1,v0
    29b8:	3c00c48f 	lw	a0,60(s8)
    29bc:	1a09000c 	jal	0x2468
    29c0:	00000000 	nop
    29c4:	00bb023c 	lui	v0,0xbb00
    29c8:	20004434 	ori	a0,v0,0x20
    29cc:	3b09000c 	jal	0x24ec
    29d0:	00000000 	nop
    29d4:	000040a0 	sb	zero,0(v0)
    29d8:	2c00c28f 	lw	v0,44(s8)
    29dc:	09000010 	b	0x2a04
    29e0:	00000000 	nop
    29e4:	00bb023c 	lui	v0,0xbb00
    29e8:	20004434 	ori	a0,v0,0x20
    29ec:	3b09000c 	jal	0x24ec
    29f0:	00000000 	nop
    29f4:	000040a0 	sb	zero,0(v0)
    29f8:	7eff0010 	b	0x27f4
    29fc:	00000000 	nop
    2a00:	25100000 	move	v0,zero
    2a04:	25e8c003 	move	sp,s8
    2a08:	3400bf8f 	lw	ra,52(sp)
    2a0c:	3000be8f 	lw	s8,48(sp)
    2a10:	3800bd27 	addiu	sp,sp,56
    2a14:	0800e003 	jr	ra
    2a18:	00000000 	nop
    2a1c:	e0ffbd27 	addiu	sp,sp,-32
    2a20:	1c00bfaf 	sw	ra,28(sp)
    2a24:	1800beaf 	sw	s8,24(sp)
    2a28:	25f0a003 	move	s8,sp
    2a2c:	2000c4af 	sw	a0,32(s8)
    2a30:	2400c5af 	sw	a1,36(s8)
    2a34:	2800c6af 	sw	a2,40(s8)
    2a38:	2c00c7af 	sw	a3,44(s8)
    2a3c:	7f80023c 	lui	v0,0x807f
    2a40:	9000428c 	lw	v0,144(v0)
    2a44:	04004014 	bnez	v0,0x2a58
    2a48:	00000000 	nop
    2a4c:	1bfc0224 	li	v0,-997
    2a50:	5d000010 	b	0x2bc8
    2a54:	00000000 	nop
    2a58:	2000c28f 	lw	v0,32(s8)
    2a5c:	04004228 	slti	v0,v0,4
    2a60:	04004010 	beqz	v0,0x2a74
    2a64:	00000000 	nop
    2a68:	2000c28f 	lw	v0,32(s8)
    2a6c:	04004104 	bgez	v0,0x2a80
    2a70:	00000000 	nop
    2a74:	18fc0224 	li	v0,-1000
    2a78:	53000010 	b	0x2bc8
    2a7c:	00000000 	nop
    2a80:	00bb023c 	lui	v0,0xbb00
    2a84:	5c024434 	ori	a0,v0,0x25c
    2a88:	3b09000c 	jal	0x24ec
    2a8c:	00000000 	nop
    2a90:	1000c2af 	sw	v0,16(s8)
    2a94:	06000624 	li	a2,6
    2a98:	2c00c58f 	lw	a1,44(s8)
    2a9c:	1000c48f 	lw	a0,16(s8)
    2aa0:	1a09000c 	jal	0x2468
    2aa4:	00000000 	nop
    2aa8:	1000c28f 	lw	v0,16(s8)
    2aac:	06004424 	addiu	a0,v0,6
    2ab0:	2000c38f 	lw	v1,32(s8)
    2ab4:	25106000 	move	v0,v1
    2ab8:	40100200 	sll	v0,v0,0x1
    2abc:	21104300 	addu	v0,v0,v1
    2ac0:	40100200 	sll	v0,v0,0x1
    2ac4:	0080033c 	lui	v1,0x8000
    2ac8:	88556324 	addiu	v1,v1,21896
    2acc:	21104300 	addu	v0,v0,v1
    2ad0:	06000624 	li	a2,6
    2ad4:	25284000 	move	a1,v0
    2ad8:	1a09000c 	jal	0x2468
    2adc:	00000000 	nop
    2ae0:	1000c28f 	lw	v0,16(s8)
    2ae4:	0c004224 	addiu	v0,v0,12
    2ae8:	81ff0324 	li	v1,-127
    2aec:	000043a0 	sb	v1,0(v0)
    2af0:	1000c28f 	lw	v0,16(s8)
    2af4:	0d004224 	addiu	v0,v0,13
    2af8:	000040a0 	sb	zero,0(v0)
    2afc:	1000c28f 	lw	v0,16(s8)
    2b00:	0e004224 	addiu	v0,v0,14
    2b04:	000040a0 	sb	zero,0(v0)
    2b08:	2000c28f 	lw	v0,32(s8)
    2b0c:	ff004330 	andi	v1,v0,0xff
    2b10:	1000c28f 	lw	v0,16(s8)
    2b14:	0f004224 	addiu	v0,v0,15
    2b18:	01006324 	addiu	v1,v1,1
    2b1c:	ff006330 	andi	v1,v1,0xff
    2b20:	000043a0 	sb	v1,0(v0)
    2b24:	1000c28f 	lw	v0,16(s8)
    2b28:	10004224 	addiu	v0,v0,16
    2b2c:	08000324 	li	v1,8
    2b30:	000043a0 	sb	v1,0(v0)
    2b34:	1000c28f 	lw	v0,16(s8)
    2b38:	11004224 	addiu	v0,v0,17
    2b3c:	000040a0 	sb	zero,0(v0)
    2b40:	1000c28f 	lw	v0,16(s8)
    2b44:	12004224 	addiu	v0,v0,18
    2b48:	2800c68f 	lw	a2,40(s8)
    2b4c:	2400c58f 	lw	a1,36(s8)
    2b50:	25204000 	move	a0,v0
    2b54:	1a09000c 	jal	0x2468
    2b58:	00000000 	nop
    2b5c:	00bb023c 	lui	v0,0xbb00
    2b60:	58024434 	ori	a0,v0,0x258
    2b64:	4f09000c 	jal	0x253c
    2b68:	00000000 	nop
    2b6c:	25184000 	move	v1,v0
    2b70:	2800c28f 	lw	v0,40(s8)
    2b74:	12004224 	addiu	v0,v0,18
    2b78:	000062ac 	sw	v0,0(v1)
    2b7c:	00bb023c 	lui	v0,0xbb00
    2b80:	24004434 	ori	a0,v0,0x24
    2b84:	3b09000c 	jal	0x24ec
    2b88:	00000000 	nop
    2b8c:	25184000 	move	v1,v0
    2b90:	01000224 	li	v0,1
    2b94:	000062a0 	sb	v0,0(v1)
    2b98:	00bb023c 	lui	v0,0xbb00
    2b9c:	24004434 	ori	a0,v0,0x24
    2ba0:	3b09000c 	jal	0x24ec
    2ba4:	00000000 	nop
    2ba8:	00004290 	lbu	v0,0(v0)
    2bac:	2b100200 	sltu	v0,zero,v0
    2bb0:	ff004230 	andi	v0,v0,0xff
    2bb4:	03004010 	beqz	v0,0x2bc4
    2bb8:	00000000 	nop
    2bbc:	f6ff0010 	b	0x2b98
    2bc0:	00000000 	nop
    2bc4:	25100000 	move	v0,zero
    2bc8:	25e8c003 	move	sp,s8
    2bcc:	1c00bf8f 	lw	ra,28(sp)
    2bd0:	1800be8f 	lw	s8,24(sp)
    2bd4:	2000bd27 	addiu	sp,sp,32
    2bd8:	0800e003 	jr	ra
    2bdc:	00000000 	nop
    2be0:	e8ffbd27 	addiu	sp,sp,-24
    2be4:	1400bfaf 	sw	ra,20(sp)
    2be8:	1000beaf 	sw	s8,16(sp)
    2bec:	25f0a003 	move	s8,sp
    2bf0:	1800c4af 	sw	a0,24(s8)
    2bf4:	1c00c5af 	sw	a1,28(s8)
    2bf8:	2000c6af 	sw	a2,32(s8)
    2bfc:	2400c7af 	sw	a3,36(s8)
    2c00:	7f80023c 	lui	v0,0x807f
    2c04:	9000428c 	lw	v0,144(v0)
    2c08:	04004014 	bnez	v0,0x2c1c
    2c0c:	00000000 	nop
    2c10:	1bfc0224 	li	v0,-997
    2c14:	43000010 	b	0x2d24
    2c18:	00000000 	nop
    2c1c:	1800c28f 	lw	v0,24(s8)
    2c20:	04004228 	slti	v0,v0,4
    2c24:	04004010 	beqz	v0,0x2c38
    2c28:	00000000 	nop
    2c2c:	1800c28f 	lw	v0,24(s8)
    2c30:	04004104 	bgez	v0,0x2c44
    2c34:	00000000 	nop
    2c38:	18fc0224 	li	v0,-1000
    2c3c:	39000010 	b	0x2d24
    2c40:	00000000 	nop
    2c44:	00bb023c 	lui	v0,0xbb00
    2c48:	0c004434 	ori	a0,v0,0xc
    2c4c:	3b09000c 	jal	0x24ec
    2c50:	00000000 	nop
    2c54:	25184000 	move	v1,v0
    2c58:	1c00c28f 	lw	v0,28(s8)
    2c5c:	ff004230 	andi	v0,v0,0xff
    2c60:	000062a0 	sb	v0,0(v1)
    2c64:	00bb023c 	lui	v0,0xbb00
    2c68:	10004434 	ori	a0,v0,0x10
    2c6c:	4f09000c 	jal	0x253c
    2c70:	00000000 	nop
    2c74:	25184000 	move	v1,v0
    2c78:	2000c28f 	lw	v0,32(s8)
    2c7c:	000062ac 	sw	v0,0(v1)
    2c80:	00bb023c 	lui	v0,0xbb00
    2c84:	14004434 	ori	a0,v0,0x14
    2c88:	4f09000c 	jal	0x253c
    2c8c:	00000000 	nop
    2c90:	25184000 	move	v1,v0
    2c94:	2400c28f 	lw	v0,36(s8)
    2c98:	000062ac 	sw	v0,0(v1)
    2c9c:	00bb023c 	lui	v0,0xbb00
    2ca0:	18004434 	ori	a0,v0,0x18
    2ca4:	3b09000c 	jal	0x24ec
    2ca8:	00000000 	nop
    2cac:	25184000 	move	v1,v0
    2cb0:	1800c28f 	lw	v0,24(s8)
    2cb4:	ff004230 	andi	v0,v0,0xff
    2cb8:	000062a0 	sb	v0,0(v1)
    2cbc:	00bb023c 	lui	v0,0xbb00
    2cc0:	1c004434 	ori	a0,v0,0x1c
    2cc4:	3b09000c 	jal	0x24ec
    2cc8:	00000000 	nop
    2ccc:	25184000 	move	v1,v0
    2cd0:	2800c293 	lbu	v0,40(s8)
    2cd4:	000062a0 	sb	v0,0(v1)
    2cd8:	00bb023c 	lui	v0,0xbb00
    2cdc:	08004434 	ori	a0,v0,0x8
    2ce0:	3b09000c 	jal	0x24ec
    2ce4:	00000000 	nop
    2ce8:	25184000 	move	v1,v0
    2cec:	01000224 	li	v0,1
    2cf0:	000062a0 	sb	v0,0(v1)
    2cf4:	00bb023c 	lui	v0,0xbb00
    2cf8:	08004434 	ori	a0,v0,0x8
    2cfc:	3b09000c 	jal	0x24ec
    2d00:	00000000 	nop
    2d04:	00004290 	lbu	v0,0(v0)
    2d08:	2b100200 	sltu	v0,zero,v0
    2d0c:	ff004230 	andi	v0,v0,0xff
    2d10:	03004010 	beqz	v0,0x2d20
    2d14:	00000000 	nop
    2d18:	f6ff0010 	b	0x2cf4
    2d1c:	00000000 	nop
    2d20:	25100000 	move	v0,zero
    2d24:	25e8c003 	move	sp,s8
    2d28:	1400bf8f 	lw	ra,20(sp)
    2d2c:	1000be8f 	lw	s8,16(sp)
    2d30:	1800bd27 	addiu	sp,sp,24
    2d34:	0800e003 	jr	ra
    2d38:	00000000 	nop
    2d3c:	f0ffbd27 	addiu	sp,sp,-16
    2d40:	0c00beaf 	sw	s8,12(sp)
    2d44:	25f0a003 	move	s8,sp
    2d48:	25108000 	move	v0,a0
    2d4c:	1400c5af 	sw	a1,20(s8)
    2d50:	1800c6af 	sw	a2,24(s8)
    2d54:	1c00c7af 	sw	a3,28(s8)
    2d58:	1000c2a3 	sb	v0,16(s8)
    2d5c:	1000c293 	lbu	v0,16(s8)
    2d60:	8c004010 	beqz	v0,0x2f94
    2d64:	00000000 	nop
    2d68:	2400c38f 	lw	v1,36(s8)
    2d6c:	10000224 	li	v0,16
    2d70:	04006214 	bne	v1,v0,0x2d84
    2d74:	00000000 	nop
    2d78:	25100000 	move	v0,zero
    2d7c:	d9000010 	b	0x30e4
    2d80:	00000000 	nop
    2d84:	0000c0af 	sw	zero,0(s8)
    2d88:	7f80023c 	lui	v0,0x807f
    2d8c:	a400428c 	lw	v0,164(v0)
    2d90:	0000c38f 	lw	v1,0(s8)
    2d94:	2a106200 	slt	v0,v1,v0
    2d98:	65004010 	beqz	v0,0x2f30
    2d9c:	00000000 	nop
    2da0:	7f80043c 	lui	a0,0x807f
    2da4:	0000c38f 	lw	v1,0(s8)
    2da8:	25106000 	move	v0,v1
    2dac:	80100200 	sll	v0,v0,0x2
    2db0:	21104300 	addu	v0,v0,v1
    2db4:	80100200 	sll	v0,v0,0x2
    2db8:	a8008324 	addiu	v1,a0,168
    2dbc:	21104300 	addu	v0,v0,v1
    2dc0:	0000438c 	lw	v1,0(v0)
    2dc4:	1400c28f 	lw	v0,20(s8)
    2dc8:	54006214 	bne	v1,v0,0x2f1c
    2dcc:	00000000 	nop
    2dd0:	7f80023c 	lui	v0,0x807f
    2dd4:	0000c38f 	lw	v1,0(s8)
    2dd8:	a8004424 	addiu	a0,v0,168
    2ddc:	25106000 	move	v0,v1
    2de0:	80100200 	sll	v0,v0,0x2
    2de4:	21104300 	addu	v0,v0,v1
    2de8:	80100200 	sll	v0,v0,0x2
    2dec:	21108200 	addu	v0,a0,v0
    2df0:	0400438c 	lw	v1,4(v0)
    2df4:	1800c28f 	lw	v0,24(s8)
    2df8:	48006214 	bne	v1,v0,0x2f1c
    2dfc:	00000000 	nop
    2e00:	7f80023c 	lui	v0,0x807f
    2e04:	0000c38f 	lw	v1,0(s8)
    2e08:	a8004424 	addiu	a0,v0,168
    2e0c:	25106000 	move	v0,v1
    2e10:	80100200 	sll	v0,v0,0x2
    2e14:	21104300 	addu	v0,v0,v1
    2e18:	80100200 	sll	v0,v0,0x2
    2e1c:	21108200 	addu	v0,a0,v0
    2e20:	0c00438c 	lw	v1,12(v0)
    2e24:	2000c28f 	lw	v0,32(s8)
    2e28:	15006214 	bne	v1,v0,0x2e80
    2e2c:	00000000 	nop
    2e30:	7f80043c 	lui	a0,0x807f
    2e34:	0000c38f 	lw	v1,0(s8)
    2e38:	25106000 	move	v0,v1
    2e3c:	80100200 	sll	v0,v0,0x2
    2e40:	21104300 	addu	v0,v0,v1
    2e44:	80100200 	sll	v0,v0,0x2
    2e48:	a8008324 	addiu	v1,a0,168
    2e4c:	21104300 	addu	v0,v0,v1
    2e50:	1400c78f 	lw	a3,20(s8)
    2e54:	1800c68f 	lw	a2,24(s8)
    2e58:	1c00c58f 	lw	a1,28(s8)
    2e5c:	2000c48f 	lw	a0,32(s8)
    2e60:	2400c38f 	lw	v1,36(s8)
    2e64:	000047ac 	sw	a3,0(v0)
    2e68:	040046ac 	sw	a2,4(v0)
    2e6c:	080045ac 	sw	a1,8(v0)
    2e70:	0c0044ac 	sw	a0,12(v0)
    2e74:	100043ac 	sw	v1,16(v0)
    2e78:	25000010 	b	0x2f10
    2e7c:	00000000 	nop
    2e80:	2400c48f 	lw	a0,36(s8)
    2e84:	7f80053c 	lui	a1,0x807f
    2e88:	0000c38f 	lw	v1,0(s8)
    2e8c:	25106000 	move	v0,v1
    2e90:	80100200 	sll	v0,v0,0x2
    2e94:	21104300 	addu	v0,v0,v1
    2e98:	80100200 	sll	v0,v0,0x2
    2e9c:	a800a324 	addiu	v1,a1,168
    2ea0:	21104300 	addu	v0,v0,v1
    2ea4:	1000428c 	lw	v0,16(v0)
    2ea8:	2b108200 	sltu	v0,a0,v0
    2eac:	15004010 	beqz	v0,0x2f04
    2eb0:	00000000 	nop
    2eb4:	7f80043c 	lui	a0,0x807f
    2eb8:	0000c38f 	lw	v1,0(s8)
    2ebc:	25106000 	move	v0,v1
    2ec0:	80100200 	sll	v0,v0,0x2
    2ec4:	21104300 	addu	v0,v0,v1
    2ec8:	80100200 	sll	v0,v0,0x2
    2ecc:	a8008324 	addiu	v1,a0,168
    2ed0:	21104300 	addu	v0,v0,v1
    2ed4:	1400c78f 	lw	a3,20(s8)
    2ed8:	1800c68f 	lw	a2,24(s8)
    2edc:	1c00c58f 	lw	a1,28(s8)
    2ee0:	2000c48f 	lw	a0,32(s8)
    2ee4:	2400c38f 	lw	v1,36(s8)
    2ee8:	000047ac 	sw	a3,0(v0)
    2eec:	040046ac 	sw	a2,4(v0)
    2ef0:	080045ac 	sw	a1,8(v0)
    2ef4:	0c0044ac 	sw	a0,12(v0)
    2ef8:	100043ac 	sw	v1,16(v0)
    2efc:	04000010 	b	0x2f10
    2f00:	00000000 	nop
    2f04:	25100000 	move	v0,zero
    2f08:	76000010 	b	0x30e4
    2f0c:	00000000 	nop
    2f10:	01000224 	li	v0,1
    2f14:	73000010 	b	0x30e4
    2f18:	00000000 	nop
    2f1c:	0000c28f 	lw	v0,0(s8)
    2f20:	01004224 	addiu	v0,v0,1
    2f24:	0000c2af 	sw	v0,0(s8)
    2f28:	97ff0010 	b	0x2d88
    2f2c:	00000000 	nop
    2f30:	7f80023c 	lui	v0,0x807f
    2f34:	a400438c 	lw	v1,164(v0)
    2f38:	01006424 	addiu	a0,v1,1
    2f3c:	7f80023c 	lui	v0,0x807f
    2f40:	a40044ac 	sw	a0,164(v0)
    2f44:	7f80043c 	lui	a0,0x807f
    2f48:	25106000 	move	v0,v1
    2f4c:	80100200 	sll	v0,v0,0x2
    2f50:	21104300 	addu	v0,v0,v1
    2f54:	80100200 	sll	v0,v0,0x2
    2f58:	a8008324 	addiu	v1,a0,168
    2f5c:	21104300 	addu	v0,v0,v1
    2f60:	1400c78f 	lw	a3,20(s8)
    2f64:	1800c68f 	lw	a2,24(s8)
    2f68:	1c00c58f 	lw	a1,28(s8)
    2f6c:	2000c48f 	lw	a0,32(s8)
    2f70:	2400c38f 	lw	v1,36(s8)
    2f74:	000047ac 	sw	a3,0(v0)
    2f78:	040046ac 	sw	a2,4(v0)
    2f7c:	080045ac 	sw	a1,8(v0)
    2f80:	0c0044ac 	sw	a0,12(v0)
    2f84:	100043ac 	sw	v1,16(v0)
    2f88:	01000224 	li	v0,1
    2f8c:	55000010 	b	0x30e4
    2f90:	00000000 	nop
    2f94:	0400c0af 	sw	zero,4(s8)
    2f98:	7f80023c 	lui	v0,0x807f
    2f9c:	a400428c 	lw	v0,164(v0)
    2fa0:	0400c38f 	lw	v1,4(s8)
    2fa4:	2a106200 	slt	v0,v1,v0
    2fa8:	4d004010 	beqz	v0,0x30e0
    2fac:	00000000 	nop
    2fb0:	7f80043c 	lui	a0,0x807f
    2fb4:	0400c38f 	lw	v1,4(s8)
    2fb8:	25106000 	move	v0,v1
    2fbc:	80100200 	sll	v0,v0,0x2
    2fc0:	21104300 	addu	v0,v0,v1
    2fc4:	80100200 	sll	v0,v0,0x2
    2fc8:	a8008324 	addiu	v1,a0,168
    2fcc:	21104300 	addu	v0,v0,v1
    2fd0:	0000438c 	lw	v1,0(v0)
    2fd4:	1400c28f 	lw	v0,20(s8)
    2fd8:	3c006214 	bne	v1,v0,0x30cc
    2fdc:	00000000 	nop
    2fe0:	7f80023c 	lui	v0,0x807f
    2fe4:	0400c38f 	lw	v1,4(s8)
    2fe8:	a8004424 	addiu	a0,v0,168
    2fec:	25106000 	move	v0,v1
    2ff0:	80100200 	sll	v0,v0,0x2
    2ff4:	21104300 	addu	v0,v0,v1
    2ff8:	80100200 	sll	v0,v0,0x2
    2ffc:	21108200 	addu	v0,a0,v0
    3000:	0400438c 	lw	v1,4(v0)
    3004:	1800c28f 	lw	v0,24(s8)
    3008:	30006214 	bne	v1,v0,0x30cc
    300c:	00000000 	nop
    3010:	7f80043c 	lui	a0,0x807f
    3014:	0400c38f 	lw	v1,4(s8)
    3018:	25106000 	move	v0,v1
    301c:	80100200 	sll	v0,v0,0x2
    3020:	21104300 	addu	v0,v0,v1
    3024:	80100200 	sll	v0,v0,0x2
    3028:	a8008324 	addiu	v1,a0,168
    302c:	21104300 	addu	v0,v0,v1
    3030:	0800438c 	lw	v1,8(v0)
    3034:	1c00c28f 	lw	v0,28(s8)
    3038:	24006214 	bne	v1,v0,0x30cc
    303c:	00000000 	nop
    3040:	7f80023c 	lui	v0,0x807f
    3044:	a400428c 	lw	v0,164(v0)
    3048:	ffff4324 	addiu	v1,v0,-1
    304c:	7f80023c 	lui	v0,0x807f
    3050:	a40043ac 	sw	v1,164(v0)
    3054:	7f80023c 	lui	v0,0x807f
    3058:	a400448c 	lw	a0,164(v0)
    305c:	7f80053c 	lui	a1,0x807f
    3060:	0400c38f 	lw	v1,4(s8)
    3064:	25106000 	move	v0,v1
    3068:	80100200 	sll	v0,v0,0x2
    306c:	21104300 	addu	v0,v0,v1
    3070:	80100200 	sll	v0,v0,0x2
    3074:	a800a324 	addiu	v1,a1,168
    3078:	21184300 	addu	v1,v0,v1
    307c:	7f80053c 	lui	a1,0x807f
    3080:	25108000 	move	v0,a0
    3084:	80100200 	sll	v0,v0,0x2
    3088:	21104400 	addu	v0,v0,a0
    308c:	80100200 	sll	v0,v0,0x2
    3090:	a800a424 	addiu	a0,a1,168
    3094:	21104400 	addu	v0,v0,a0
    3098:	0000478c 	lw	a3,0(v0)
    309c:	0400468c 	lw	a2,4(v0)
    30a0:	0800458c 	lw	a1,8(v0)
    30a4:	0c00448c 	lw	a0,12(v0)
    30a8:	1000428c 	lw	v0,16(v0)
    30ac:	000067ac 	sw	a3,0(v1)
    30b0:	040066ac 	sw	a2,4(v1)
    30b4:	080065ac 	sw	a1,8(v1)
    30b8:	0c0064ac 	sw	a0,12(v1)
    30bc:	100062ac 	sw	v0,16(v1)
    30c0:	01000224 	li	v0,1
    30c4:	07000010 	b	0x30e4
    30c8:	00000000 	nop
    30cc:	0400c28f 	lw	v0,4(s8)
    30d0:	01004224 	addiu	v0,v0,1
    30d4:	0400c2af 	sw	v0,4(s8)
    30d8:	afff0010 	b	0x2f98
    30dc:	00000000 	nop
    30e0:	25100000 	move	v0,zero
    30e4:	25e8c003 	move	sp,s8
    30e8:	0c00be8f 	lw	s8,12(sp)
    30ec:	1000bd27 	addiu	sp,sp,16
    30f0:	0800e003 	jr	ra
    30f4:	00000000 	nop
    30f8:	e8ffbd27 	addiu	sp,sp,-24
    30fc:	1400beaf 	sw	s8,20(sp)
    3100:	25f0a003 	move	s8,sp
    3104:	1800c4af 	sw	a0,24(s8)
    3108:	1c00c5af 	sw	a1,28(s8)
    310c:	2000c6af 	sw	a2,32(s8)
    3110:	1c00c28f 	lw	v0,28(s8)
    3114:	000040ac 	sw	zero,0(v0)
    3118:	2000c28f 	lw	v0,32(s8)
    311c:	000040ac 	sw	zero,0(v0)
    3120:	0000c0a3 	sb	zero,0(s8)
    3124:	0400c0af 	sw	zero,4(s8)
    3128:	0800c0af 	sw	zero,8(s8)
    312c:	7f80023c 	lui	v0,0x807f
    3130:	a400428c 	lw	v0,164(v0)
    3134:	0800c38f 	lw	v1,8(s8)
    3138:	2a106200 	slt	v0,v1,v0
    313c:	5f004010 	beqz	v0,0x32bc
    3140:	00000000 	nop
    3144:	1800c28f 	lw	v0,24(s8)
    3148:	0c00c2af 	sw	v0,12(s8)
    314c:	7f80023c 	lui	v0,0x807f
    3150:	0800c38f 	lw	v1,8(s8)
    3154:	a8004424 	addiu	a0,v0,168
    3158:	25106000 	move	v0,v1
    315c:	80100200 	sll	v0,v0,0x2
    3160:	21104300 	addu	v0,v0,v1
    3164:	80100200 	sll	v0,v0,0x2
    3168:	21108200 	addu	v0,a0,v0
    316c:	0400428c 	lw	v0,4(v0)
    3170:	2000422c 	sltiu	v0,v0,32
    3174:	11004010 	beqz	v0,0x31bc
    3178:	00000000 	nop
    317c:	7f80023c 	lui	v0,0x807f
    3180:	0800c38f 	lw	v1,8(s8)
    3184:	a8004424 	addiu	a0,v0,168
    3188:	25106000 	move	v0,v1
    318c:	80100200 	sll	v0,v0,0x2
    3190:	21104300 	addu	v0,v0,v1
    3194:	80100200 	sll	v0,v0,0x2
    3198:	21108200 	addu	v0,a0,v0
    319c:	0400428c 	lw	v0,4(v0)
    31a0:	01000324 	li	v1,1
    31a4:	04104300 	sllv	v0,v1,v0
    31a8:	ffff4224 	addiu	v0,v0,-1
    31ac:	25184000 	move	v1,v0
    31b0:	0c00c28f 	lw	v0,12(s8)
    31b4:	24104300 	and	v0,v0,v1
    31b8:	0c00c2af 	sw	v0,12(s8)
    31bc:	7f80043c 	lui	a0,0x807f
    31c0:	0800c38f 	lw	v1,8(s8)
    31c4:	25106000 	move	v0,v1
    31c8:	80100200 	sll	v0,v0,0x2
    31cc:	21104300 	addu	v0,v0,v1
    31d0:	80100200 	sll	v0,v0,0x2
    31d4:	a8008324 	addiu	v1,a0,168
    31d8:	21104300 	addu	v0,v0,v1
    31dc:	0000428c 	lw	v0,0(v0)
    31e0:	0c00c38f 	lw	v1,12(s8)
    31e4:	30006214 	bne	v1,v0,0x32a8
    31e8:	00000000 	nop
    31ec:	7f80023c 	lui	v0,0x807f
    31f0:	0800c38f 	lw	v1,8(s8)
    31f4:	a8004424 	addiu	a0,v0,168
    31f8:	25106000 	move	v0,v1
    31fc:	80100200 	sll	v0,v0,0x2
    3200:	21104300 	addu	v0,v0,v1
    3204:	80100200 	sll	v0,v0,0x2
    3208:	21108200 	addu	v0,a0,v0
    320c:	0400438c 	lw	v1,4(v0)
    3210:	0400c28f 	lw	v0,4(s8)
    3214:	2b104300 	sltu	v0,v0,v1
    3218:	23004010 	beqz	v0,0x32a8
    321c:	00000000 	nop
    3220:	7f80023c 	lui	v0,0x807f
    3224:	0800c38f 	lw	v1,8(s8)
    3228:	a8004424 	addiu	a0,v0,168
    322c:	25106000 	move	v0,v1
    3230:	80100200 	sll	v0,v0,0x2
    3234:	21104300 	addu	v0,v0,v1
    3238:	80100200 	sll	v0,v0,0x2
    323c:	21108200 	addu	v0,a0,v0
    3240:	0400428c 	lw	v0,4(v0)
    3244:	0400c2af 	sw	v0,4(s8)
    3248:	7f80023c 	lui	v0,0x807f
    324c:	0800c38f 	lw	v1,8(s8)
    3250:	a8004424 	addiu	a0,v0,168
    3254:	25106000 	move	v0,v1
    3258:	80100200 	sll	v0,v0,0x2
    325c:	21104300 	addu	v0,v0,v1
    3260:	80100200 	sll	v0,v0,0x2
    3264:	21108200 	addu	v0,a0,v0
    3268:	0c00438c 	lw	v1,12(v0)
    326c:	1c00c28f 	lw	v0,28(s8)
    3270:	000043ac 	sw	v1,0(v0)
    3274:	7f80043c 	lui	a0,0x807f
    3278:	0800c38f 	lw	v1,8(s8)
    327c:	25106000 	move	v0,v1
    3280:	80100200 	sll	v0,v0,0x2
    3284:	21104300 	addu	v0,v0,v1
    3288:	80100200 	sll	v0,v0,0x2
    328c:	a8008324 	addiu	v1,a0,168
    3290:	21104300 	addu	v0,v0,v1
    3294:	0800438c 	lw	v1,8(v0)
    3298:	2000c28f 	lw	v0,32(s8)
    329c:	000043ac 	sw	v1,0(v0)
    32a0:	01000224 	li	v0,1
    32a4:	0000c2a3 	sb	v0,0(s8)
    32a8:	0800c28f 	lw	v0,8(s8)
    32ac:	01004224 	addiu	v0,v0,1
    32b0:	0800c2af 	sw	v0,8(s8)
    32b4:	9dff0010 	b	0x312c
    32b8:	00000000 	nop
    32bc:	0000c293 	lbu	v0,0(s8)
    32c0:	25e8c003 	move	sp,s8
    32c4:	1400be8f 	lw	s8,20(sp)
    32c8:	1800bd27 	addiu	sp,sp,24
    32cc:	0800e003 	jr	ra
    32d0:	00000000 	nop
    32d4:	f0ffbd27 	addiu	sp,sp,-16
    32d8:	0c00beaf 	sw	s8,12(sp)
    32dc:	25f0a003 	move	s8,sp
    32e0:	1000c4af 	sw	a0,16(s8)
    32e4:	1000c28f 	lw	v0,16(s8)
    32e8:	000040ac 	sw	zero,0(v0)
    32ec:	1000c28f 	lw	v0,16(s8)
    32f0:	040040a0 	sb	zero,4(v0)
    32f4:	0000c0af 	sw	zero,0(s8)
    32f8:	0000c28f 	lw	v0,0(s8)
    32fc:	19004228 	slti	v0,v0,25
    3300:	1c004010 	beqz	v0,0x3374
    3304:	00000000 	nop
    3308:	1000c38f 	lw	v1,16(s8)
    330c:	0000c28f 	lw	v0,0(s8)
    3310:	00110200 	sll	v0,v0,0x4
    3314:	21106200 	addu	v0,v1,v0
    3318:	080040ac 	sw	zero,8(v0)
    331c:	1000c38f 	lw	v1,16(s8)
    3320:	0000c28f 	lw	v0,0(s8)
    3324:	00110200 	sll	v0,v0,0x4
    3328:	21106200 	addu	v0,v1,v0
    332c:	0c0040ac 	sw	zero,12(v0)
    3330:	1000c38f 	lw	v1,16(s8)
    3334:	0000c28f 	lw	v0,0(s8)
    3338:	01004224 	addiu	v0,v0,1
    333c:	00110200 	sll	v0,v0,0x4
    3340:	21106200 	addu	v0,v1,v0
    3344:	000040ac 	sw	zero,0(v0)
    3348:	1000c38f 	lw	v1,16(s8)
    334c:	0000c28f 	lw	v0,0(s8)
    3350:	01004224 	addiu	v0,v0,1
    3354:	00110200 	sll	v0,v0,0x4
    3358:	21106200 	addu	v0,v1,v0
    335c:	040040ac 	sw	zero,4(v0)
    3360:	0000c28f 	lw	v0,0(s8)
    3364:	01004224 	addiu	v0,v0,1
    3368:	0000c2af 	sw	v0,0(s8)
    336c:	e2ff0010 	b	0x32f8
    3370:	00000000 	nop
    3374:	00000000 	nop
    3378:	25e8c003 	move	sp,s8
    337c:	0c00be8f 	lw	s8,12(sp)
    3380:	1000bd27 	addiu	sp,sp,16
    3384:	0800e003 	jr	ra
    3388:	00000000 	nop
    338c:	f8ffbd27 	addiu	sp,sp,-8
    3390:	0400beaf 	sw	s8,4(sp)
    3394:	25f0a003 	move	s8,sp
    3398:	0800c4af 	sw	a0,8(s8)
    339c:	0c00c5af 	sw	a1,12(s8)
    33a0:	1000c6af 	sw	a2,16(s8)
    33a4:	1400c7af 	sw	a3,20(s8)
    33a8:	00000000 	nop
    33ac:	25e8c003 	move	sp,s8
    33b0:	0400be8f 	lw	s8,4(sp)
    33b4:	0800bd27 	addiu	sp,sp,8
    33b8:	0800e003 	jr	ra
    33bc:	00000000 	nop
    33c0:	e8ffbd27 	addiu	sp,sp,-24
    33c4:	1400bfaf 	sw	ra,20(sp)
    33c8:	1000beaf 	sw	s8,16(sp)
    33cc:	25f0a003 	move	s8,sp
    33d0:	25108000 	move	v0,a0
    33d4:	1800c2a3 	sb	v0,24(s8)
    33d8:	1800c293 	lbu	v0,24(s8)
    33dc:	25204000 	move	a0,v0
    33e0:	fc05000c 	jal	0x17f0
    33e4:	00000000 	nop
    33e8:	00000000 	nop
    33ec:	25e8c003 	move	sp,s8
    33f0:	1400bf8f 	lw	ra,20(sp)
    33f4:	1000be8f 	lw	s8,16(sp)
    33f8:	1800bd27 	addiu	sp,sp,24
    33fc:	0800e003 	jr	ra
    3400:	00000000 	nop
    3404:	e0ffbd27 	addiu	sp,sp,-32
    3408:	1c00bfaf 	sw	ra,28(sp)
    340c:	1800beaf 	sw	s8,24(sp)
    3410:	25f0a003 	move	s8,sp
    3414:	2000c4af 	sw	a0,32(s8)
    3418:	1000c0af 	sw	zero,16(s8)
    341c:	1000c28f 	lw	v0,16(s8)
    3420:	2000c38f 	lw	v1,32(s8)
    3424:	21106200 	addu	v0,v1,v0
    3428:	00004280 	lb	v0,0(v0)
    342c:	0e004010 	beqz	v0,0x3468
    3430:	00000000 	nop
    3434:	1000c28f 	lw	v0,16(s8)
    3438:	2000c38f 	lw	v1,32(s8)
    343c:	21106200 	addu	v0,v1,v0
    3440:	00004280 	lb	v0,0(v0)
    3444:	ff004230 	andi	v0,v0,0xff
    3448:	25204000 	move	a0,v0
    344c:	f00c000c 	jal	0x33c0
    3450:	00000000 	nop
    3454:	1000c28f 	lw	v0,16(s8)
    3458:	01004224 	addiu	v0,v0,1
    345c:	1000c2af 	sw	v0,16(s8)
    3460:	eeff0010 	b	0x341c
    3464:	00000000 	nop
    3468:	00000000 	nop
    346c:	25e8c003 	move	sp,s8
    3470:	1c00bf8f 	lw	ra,28(sp)
    3474:	1800be8f 	lw	s8,24(sp)
    3478:	2000bd27 	addiu	sp,sp,32
    347c:	0800e003 	jr	ra
    3480:	00000000 	nop
    3484:	e8ffbd27 	addiu	sp,sp,-24
    3488:	1400bfaf 	sw	ra,20(sp)
    348c:	1000beaf 	sw	s8,16(sp)
    3490:	25f0a003 	move	s8,sp
    3494:	1800c4af 	sw	a0,24(s8)
    3498:	1800c28f 	lw	v0,24(s8)
    349c:	ff004230 	andi	v0,v0,0xff
    34a0:	25204000 	move	a0,v0
    34a4:	f00c000c 	jal	0x33c0
    34a8:	00000000 	nop
    34ac:	1800c28f 	lw	v0,24(s8)
    34b0:	02120200 	srl	v0,v0,0x8
    34b4:	ff004230 	andi	v0,v0,0xff
    34b8:	25204000 	move	a0,v0
    34bc:	f00c000c 	jal	0x33c0
    34c0:	00000000 	nop
    34c4:	1800c28f 	lw	v0,24(s8)
    34c8:	02140200 	srl	v0,v0,0x10
    34cc:	ff004230 	andi	v0,v0,0xff
    34d0:	25204000 	move	a0,v0
    34d4:	f00c000c 	jal	0x33c0
    34d8:	00000000 	nop
    34dc:	1800c28f 	lw	v0,24(s8)
    34e0:	02160200 	srl	v0,v0,0x18
    34e4:	ff004230 	andi	v0,v0,0xff
    34e8:	25204000 	move	a0,v0
    34ec:	f00c000c 	jal	0x33c0
    34f0:	00000000 	nop
    34f4:	2c000424 	li	a0,44
    34f8:	f00c000c 	jal	0x33c0
    34fc:	00000000 	nop
    3500:	00000000 	nop
    3504:	25e8c003 	move	sp,s8
    3508:	1400bf8f 	lw	ra,20(sp)
    350c:	1000be8f 	lw	s8,16(sp)
    3510:	1800bd27 	addiu	sp,sp,24
    3514:	0800e003 	jr	ra
    3518:	00000000 	nop
    351c:	e8ffbd27 	addiu	sp,sp,-24
    3520:	1400bfaf 	sw	ra,20(sp)
    3524:	1000beaf 	sw	s8,16(sp)
    3528:	25f0a003 	move	s8,sp
    352c:	25108000 	move	v0,a0
    3530:	1800c2a3 	sb	v0,24(s8)
    3534:	1800c293 	lbu	v0,24(s8)
    3538:	25204000 	move	a0,v0
    353c:	f00c000c 	jal	0x33c0
    3540:	00000000 	nop
    3544:	1800c293 	lbu	v0,24(s8)
    3548:	25204000 	move	a0,v0
    354c:	f00c000c 	jal	0x33c0
    3550:	00000000 	nop
    3554:	1800c293 	lbu	v0,24(s8)
    3558:	25204000 	move	a0,v0
    355c:	f00c000c 	jal	0x33c0
    3560:	00000000 	nop
    3564:	00000000 	nop
    3568:	25e8c003 	move	sp,s8
    356c:	1400bf8f 	lw	ra,20(sp)
    3570:	1000be8f 	lw	s8,16(sp)
    3574:	1800bd27 	addiu	sp,sp,24
    3578:	0800e003 	jr	ra
    357c:	00000000 	nop
    3580:	f0ffbd27 	addiu	sp,sp,-16
    3584:	0c00beaf 	sw	s8,12(sp)
    3588:	25f0a003 	move	s8,sp
    358c:	1000c4af 	sw	a0,16(s8)
    3590:	1400c5af 	sw	a1,20(s8)
    3594:	0000c0af 	sw	zero,0(s8)
    3598:	0400c0af 	sw	zero,4(s8)
    359c:	0400c38f 	lw	v1,4(s8)
    35a0:	1400c28f 	lw	v0,20(s8)
    35a4:	2a106200 	slt	v0,v1,v0
    35a8:	0f004010 	beqz	v0,0x35e8
    35ac:	00000000 	nop
    35b0:	0400c28f 	lw	v0,4(s8)
    35b4:	40100200 	sll	v0,v0,0x1
    35b8:	1000c38f 	lw	v1,16(s8)
    35bc:	21106200 	addu	v0,v1,v0
    35c0:	00004294 	lhu	v0,0(v0)
    35c4:	25184000 	move	v1,v0
    35c8:	0000c28f 	lw	v0,0(s8)
    35cc:	21104300 	addu	v0,v0,v1
    35d0:	0000c2af 	sw	v0,0(s8)
    35d4:	0400c28f 	lw	v0,4(s8)
    35d8:	01004224 	addiu	v0,v0,1
    35dc:	0400c2af 	sw	v0,4(s8)
    35e0:	eeff0010 	b	0x359c
    35e4:	00000000 	nop
    35e8:	0000c38f 	lw	v1,0(s8)
    35ec:	0100023c 	lui	v0,0x1
    35f0:	2b106200 	sltu	v0,v1,v0
    35f4:	09004014 	bnez	v0,0x361c
    35f8:	00000000 	nop
    35fc:	0000c28f 	lw	v0,0(s8)
    3600:	ffff4330 	andi	v1,v0,0xffff
    3604:	0000c28f 	lw	v0,0(s8)
    3608:	02140200 	srl	v0,v0,0x10
    360c:	21106200 	addu	v0,v1,v0
    3610:	0000c2af 	sw	v0,0(s8)
    3614:	f4ff0010 	b	0x35e8
    3618:	00000000 	nop
    361c:	0000c28f 	lw	v0,0(s8)
    3620:	ffff4230 	andi	v0,v0,0xffff
    3624:	27100200 	nor	v0,zero,v0
    3628:	ffff4230 	andi	v0,v0,0xffff
    362c:	25e8c003 	move	sp,s8
    3630:	0c00be8f 	lw	s8,12(sp)
    3634:	1000bd27 	addiu	sp,sp,16
    3638:	0800e003 	jr	ra
    363c:	00000000 	nop
    3640:	f8ffbd27 	addiu	sp,sp,-8
    3644:	0400beaf 	sw	s8,4(sp)
    3648:	25f0a003 	move	s8,sp
    364c:	25108000 	move	v0,a0
    3650:	0800c2a7 	sh	v0,8(s8)
    3654:	0800c297 	lhu	v0,8(s8)
    3658:	02120200 	srl	v0,v0,0x8
    365c:	ffff4330 	andi	v1,v0,0xffff
    3660:	0800c297 	lhu	v0,8(s8)
    3664:	00120200 	sll	v0,v0,0x8
    3668:	ffff4230 	andi	v0,v0,0xffff
    366c:	21106200 	addu	v0,v1,v0
    3670:	ffff4230 	andi	v0,v0,0xffff
    3674:	25e8c003 	move	sp,s8
    3678:	0400be8f 	lw	s8,4(sp)
    367c:	0800bd27 	addiu	sp,sp,8
    3680:	0800e003 	jr	ra
    3684:	00000000 	nop
    3688:	e0ffbd27 	addiu	sp,sp,-32
    368c:	1c00bfaf 	sw	ra,28(sp)
    3690:	1800beaf 	sw	s8,24(sp)
    3694:	1400b0af 	sw	s0,20(sp)
    3698:	25f0a003 	move	s8,sp
    369c:	2000c4af 	sw	a0,32(s8)
    36a0:	2400c5af 	sw	a1,36(s8)
    36a4:	2800c6af 	sw	a2,40(s8)
    36a8:	2c00c7af 	sw	a3,44(s8)
    36ac:	2000c28f 	lw	v0,32(s8)
    36b0:	45000324 	li	v1,69
    36b4:	000043a0 	sb	v1,0(v0)
    36b8:	2000c28f 	lw	v0,32(s8)
    36bc:	01004224 	addiu	v0,v0,1
    36c0:	c0ff0324 	li	v1,-64
    36c4:	000043a0 	sb	v1,0(v0)
    36c8:	2400c28f 	lw	v0,36(s8)
    36cc:	0000428c 	lw	v0,0(v0)
    36d0:	14004324 	addiu	v1,v0,20
    36d4:	2400c28f 	lw	v0,36(s8)
    36d8:	000043ac 	sw	v1,0(v0)
    36dc:	2400c28f 	lw	v0,36(s8)
    36e0:	0000428c 	lw	v0,0(v0)
    36e4:	ffff4330 	andi	v1,v0,0xffff
    36e8:	2000c28f 	lw	v0,32(s8)
    36ec:	02005024 	addiu	s0,v0,2
    36f0:	25206000 	move	a0,v1
    36f4:	900d000c 	jal	0x3640
    36f8:	00000000 	nop
    36fc:	000002a6 	sh	v0,0(s0)
    3700:	2000c28f 	lw	v0,32(s8)
    3704:	04004224 	addiu	v0,v0,4
    3708:	66660324 	li	v1,26214
    370c:	000043a4 	sh	v1,0(v0)
    3710:	2400c28f 	lw	v0,36(s8)
    3714:	0000428c 	lw	v0,0(v0)
    3718:	ffff4330 	andi	v1,v0,0xffff
    371c:	0080023c 	lui	v0,0x8000
    3720:	b0554294 	lhu	v0,21936(v0)
    3724:	21106200 	addu	v0,v1,v0
    3728:	ffff4330 	andi	v1,v0,0xffff
    372c:	0080023c 	lui	v0,0x8000
    3730:	b05543a4 	sh	v1,21936(v0)
    3734:	2000c28f 	lw	v0,32(s8)
    3738:	04004224 	addiu	v0,v0,4
    373c:	0080033c 	lui	v1,0x8000
    3740:	b0556394 	lhu	v1,21936(v1)
    3744:	000043a4 	sh	v1,0(v0)
    3748:	2000c28f 	lw	v0,32(s8)
    374c:	06004224 	addiu	v0,v0,6
    3750:	000040a4 	sh	zero,0(v0)
    3754:	2000c28f 	lw	v0,32(s8)
    3758:	08004224 	addiu	v0,v0,8
    375c:	01000324 	li	v1,1
    3760:	000043a0 	sb	v1,0(v0)
    3764:	2000c28f 	lw	v0,32(s8)
    3768:	09004224 	addiu	v0,v0,9
    376c:	11000324 	li	v1,17
    3770:	000043a0 	sb	v1,0(v0)
    3774:	2000c28f 	lw	v0,32(s8)
    3778:	0a004224 	addiu	v0,v0,10
    377c:	000040a4 	sh	zero,0(v0)
    3780:	2000c28f 	lw	v0,32(s8)
    3784:	0c004224 	addiu	v0,v0,12
    3788:	2800c38f 	lw	v1,40(s8)
    378c:	000043ac 	sw	v1,0(v0)
    3790:	2000c28f 	lw	v0,32(s8)
    3794:	10004224 	addiu	v0,v0,16
    3798:	2c00c38f 	lw	v1,44(s8)
    379c:	000043ac 	sw	v1,0(v0)
    37a0:	2000c28f 	lw	v0,32(s8)
    37a4:	0a005024 	addiu	s0,v0,10
    37a8:	0a000524 	li	a1,10
    37ac:	2000c48f 	lw	a0,32(s8)
    37b0:	600d000c 	jal	0x3580
    37b4:	00000000 	nop
    37b8:	000002a6 	sh	v0,0(s0)
    37bc:	00000000 	nop
    37c0:	25e8c003 	move	sp,s8
    37c4:	1c00bf8f 	lw	ra,28(sp)
    37c8:	1800be8f 	lw	s8,24(sp)
    37cc:	1400b08f 	lw	s0,20(sp)
    37d0:	2000bd27 	addiu	sp,sp,32
    37d4:	0800e003 	jr	ra
    37d8:	00000000 	nop
    37dc:	e0ffbd27 	addiu	sp,sp,-32
    37e0:	1c00bfaf 	sw	ra,28(sp)
    37e4:	1800beaf 	sw	s8,24(sp)
    37e8:	1400b0af 	sw	s0,20(sp)
    37ec:	25f0a003 	move	s8,sp
    37f0:	2000c4af 	sw	a0,32(s8)
    37f4:	2400c5af 	sw	a1,36(s8)
    37f8:	2510c000 	move	v0,a2
    37fc:	2518e000 	move	v1,a3
    3800:	2800c2a7 	sh	v0,40(s8)
    3804:	25106000 	move	v0,v1
    3808:	2c00c2a7 	sh	v0,44(s8)
    380c:	2800c297 	lhu	v0,40(s8)
    3810:	25204000 	move	a0,v0
    3814:	900d000c 	jal	0x3640
    3818:	00000000 	nop
    381c:	25184000 	move	v1,v0
    3820:	2000c28f 	lw	v0,32(s8)
    3824:	000043a4 	sh	v1,0(v0)
    3828:	2000c28f 	lw	v0,32(s8)
    382c:	02005024 	addiu	s0,v0,2
    3830:	2c00c297 	lhu	v0,44(s8)
    3834:	25204000 	move	a0,v0
    3838:	900d000c 	jal	0x3640
    383c:	00000000 	nop
    3840:	000002a6 	sh	v0,0(s0)
    3844:	2400c28f 	lw	v0,36(s8)
    3848:	0000428c 	lw	v0,0(v0)
    384c:	08004324 	addiu	v1,v0,8
    3850:	2400c28f 	lw	v0,36(s8)
    3854:	000043ac 	sw	v1,0(v0)
    3858:	2400c28f 	lw	v0,36(s8)
    385c:	0000428c 	lw	v0,0(v0)
    3860:	ffff4330 	andi	v1,v0,0xffff
    3864:	2000c28f 	lw	v0,32(s8)
    3868:	04005024 	addiu	s0,v0,4
    386c:	25206000 	move	a0,v1
    3870:	900d000c 	jal	0x3640
    3874:	00000000 	nop
    3878:	000002a6 	sh	v0,0(s0)
    387c:	2000c28f 	lw	v0,32(s8)
    3880:	06004224 	addiu	v0,v0,6
    3884:	000040a4 	sh	zero,0(v0)
    3888:	00000000 	nop
    388c:	25e8c003 	move	sp,s8
    3890:	1c00bf8f 	lw	ra,28(sp)
    3894:	1800be8f 	lw	s8,24(sp)
    3898:	1400b08f 	lw	s0,20(sp)
    389c:	2000bd27 	addiu	sp,sp,32
    38a0:	0800e003 	jr	ra
    38a4:	00000000 	nop
    38a8:	d8ffbd27 	addiu	sp,sp,-40
    38ac:	2400bfaf 	sw	ra,36(sp)
    38b0:	2000beaf 	sw	s8,32(sp)
    38b4:	1c00b0af 	sw	s0,28(sp)
    38b8:	25f0a003 	move	s8,sp
    38bc:	2800c4af 	sw	a0,40(s8)
    38c0:	2c00c5af 	sw	a1,44(s8)
    38c4:	3000c6af 	sw	a2,48(s8)
    38c8:	3000c28f 	lw	v0,48(s8)
    38cc:	04004390 	lbu	v1,4(v0)
    38d0:	2800c28f 	lw	v0,40(s8)
    38d4:	000043a0 	sb	v1,0(v0)
    38d8:	2800c28f 	lw	v0,40(s8)
    38dc:	01004224 	addiu	v0,v0,1
    38e0:	02000324 	li	v1,2
    38e4:	000043a0 	sb	v1,0(v0)
    38e8:	2800c28f 	lw	v0,40(s8)
    38ec:	03004224 	addiu	v0,v0,3
    38f0:	000040a0 	sb	zero,0(v0)
    38f4:	2800c38f 	lw	v1,40(s8)
    38f8:	02006324 	addiu	v1,v1,2
    38fc:	00004290 	lbu	v0,0(v0)
    3900:	000062a0 	sb	v0,0(v1)
    3904:	2c00c28f 	lw	v0,44(s8)
    3908:	04000324 	li	v1,4
    390c:	000043ac 	sw	v1,0(v0)
    3910:	3000c28f 	lw	v0,48(s8)
    3914:	04004390 	lbu	v1,4(v0)
    3918:	01000224 	li	v0,1
    391c:	0f006214 	bne	v1,v0,0x395c
    3920:	00000000 	nop
    3924:	2c00c28f 	lw	v0,44(s8)
    3928:	0000428c 	lw	v0,0(v0)
    392c:	13004224 	addiu	v0,v0,19
    3930:	2800c38f 	lw	v1,40(s8)
    3934:	21106200 	addu	v0,v1,v0
    3938:	10000324 	li	v1,16
    393c:	000043a0 	sb	v1,0(v0)
    3940:	2c00c28f 	lw	v0,44(s8)
    3944:	0000428c 	lw	v0,0(v0)
    3948:	14004324 	addiu	v1,v0,20
    394c:	2c00c28f 	lw	v0,44(s8)
    3950:	000043ac 	sw	v1,0(v0)
    3954:	57000010 	b	0x3ab4
    3958:	00000000 	nop
    395c:	3000c28f 	lw	v0,48(s8)
    3960:	04004390 	lbu	v1,4(v0)
    3964:	02000224 	li	v0,2
    3968:	52006214 	bne	v1,v0,0x3ab4
    396c:	00000000 	nop
    3970:	1000c0af 	sw	zero,16(s8)
    3974:	3000c28f 	lw	v0,48(s8)
    3978:	0000438c 	lw	v1,0(v0)
    397c:	1000c28f 	lw	v0,16(s8)
    3980:	2b104300 	sltu	v0,v0,v1
    3984:	4b004010 	beqz	v0,0x3ab4
    3988:	00000000 	nop
    398c:	2c00c28f 	lw	v0,44(s8)
    3990:	0000428c 	lw	v0,0(v0)
    3994:	2800c38f 	lw	v1,40(s8)
    3998:	21806200 	addu	s0,v1,v0
    399c:	02000424 	li	a0,2
    39a0:	900d000c 	jal	0x3640
    39a4:	00000000 	nop
    39a8:	000002a6 	sh	v0,0(s0)
    39ac:	2c00c28f 	lw	v0,44(s8)
    39b0:	0000428c 	lw	v0,0(v0)
    39b4:	02004224 	addiu	v0,v0,2
    39b8:	2800c38f 	lw	v1,40(s8)
    39bc:	21806200 	addu	s0,v1,v0
    39c0:	25200000 	move	a0,zero
    39c4:	900d000c 	jal	0x3640
    39c8:	00000000 	nop
    39cc:	000002a6 	sh	v0,0(s0)
    39d0:	2c00c28f 	lw	v0,44(s8)
    39d4:	0000428c 	lw	v0,0(v0)
    39d8:	04004224 	addiu	v0,v0,4
    39dc:	2800c38f 	lw	v1,40(s8)
    39e0:	21186200 	addu	v1,v1,v0
    39e4:	3000c48f 	lw	a0,48(s8)
    39e8:	1000c28f 	lw	v0,16(s8)
    39ec:	00110200 	sll	v0,v0,0x4
    39f0:	21108200 	addu	v0,a0,v0
    39f4:	0800428c 	lw	v0,8(v0)
    39f8:	000062ac 	sw	v0,0(v1)
    39fc:	2c00c28f 	lw	v0,44(s8)
    3a00:	0000428c 	lw	v0,0(v0)
    3a04:	08004224 	addiu	v0,v0,8
    3a08:	2800c38f 	lw	v1,40(s8)
    3a0c:	21186200 	addu	v1,v1,v0
    3a10:	3000c48f 	lw	a0,48(s8)
    3a14:	1000c28f 	lw	v0,16(s8)
    3a18:	00110200 	sll	v0,v0,0x4
    3a1c:	21108200 	addu	v0,a0,v0
    3a20:	0c00428c 	lw	v0,12(v0)
    3a24:	000062ac 	sw	v0,0(v1)
    3a28:	2c00c28f 	lw	v0,44(s8)
    3a2c:	0000428c 	lw	v0,0(v0)
    3a30:	0c004224 	addiu	v0,v0,12
    3a34:	2800c38f 	lw	v1,40(s8)
    3a38:	21106200 	addu	v0,v1,v0
    3a3c:	3000c48f 	lw	a0,48(s8)
    3a40:	1000c38f 	lw	v1,16(s8)
    3a44:	01006324 	addiu	v1,v1,1
    3a48:	00190300 	sll	v1,v1,0x4
    3a4c:	21188300 	addu	v1,a0,v1
    3a50:	0000638c 	lw	v1,0(v1)
    3a54:	000043ac 	sw	v1,0(v0)
    3a58:	3000c38f 	lw	v1,48(s8)
    3a5c:	1000c28f 	lw	v0,16(s8)
    3a60:	01004224 	addiu	v0,v0,1
    3a64:	00110200 	sll	v0,v0,0x4
    3a68:	21106200 	addu	v0,v1,v0
    3a6c:	0400438c 	lw	v1,4(v0)
    3a70:	2c00c28f 	lw	v0,44(s8)
    3a74:	0000428c 	lw	v0,0(v0)
    3a78:	10004224 	addiu	v0,v0,16
    3a7c:	2800c48f 	lw	a0,40(s8)
    3a80:	21108200 	addu	v0,a0,v0
    3a84:	001e0300 	sll	v1,v1,0x18
    3a88:	000043ac 	sw	v1,0(v0)
    3a8c:	2c00c28f 	lw	v0,44(s8)
    3a90:	0000428c 	lw	v0,0(v0)
    3a94:	14004324 	addiu	v1,v0,20
    3a98:	2c00c28f 	lw	v0,44(s8)
    3a9c:	000043ac 	sw	v1,0(v0)
    3aa0:	1000c28f 	lw	v0,16(s8)
    3aa4:	01004224 	addiu	v0,v0,1
    3aa8:	1000c2af 	sw	v0,16(s8)
    3aac:	b1ff0010 	b	0x3974
    3ab0:	00000000 	nop
    3ab4:	00000000 	nop
    3ab8:	25e8c003 	move	sp,s8
    3abc:	2400bf8f 	lw	ra,36(sp)
    3ac0:	2000be8f 	lw	s8,32(sp)
    3ac4:	1c00b08f 	lw	s0,28(sp)
    3ac8:	2800bd27 	addiu	sp,sp,40
    3acc:	0800e003 	jr	ra
    3ad0:	00000000 	nop
    3ad4:	f8ffbd27 	addiu	sp,sp,-8
    3ad8:	0400beaf 	sw	s8,4(sp)
    3adc:	25f0a003 	move	s8,sp
    3ae0:	0800c4af 	sw	a0,8(s8)
    3ae4:	0800c48f 	lw	a0,8(s8)
    3ae8:	20008430 	andi	a0,a0,0x20
    3aec:	25400000 	move	t0,zero
    3af0:	01000524 	li	a1,1
    3af4:	42300500 	srl	a2,a1,0x1
    3af8:	0800c78f 	lw	a3,8(s8)
    3afc:	ffff0524 	li	a1,-1
    3b00:	2628e500 	xor	a1,a3,a1
    3b04:	0628a600 	srlv	a1,a2,a1
    3b08:	25380000 	move	a3,zero
    3b0c:	0800c68f 	lw	a2,8(s8)
    3b10:	0418c700 	sllv	v1,a3,a2
    3b14:	2518a300 	or	v1,a1,v1
    3b18:	01000624 	li	a2,1
    3b1c:	0800c58f 	lw	a1,8(s8)
    3b20:	0410a600 	sllv	v0,a2,a1
    3b24:	0b184400 	0x44180b
    3b28:	0b100401 	0x104100b
    3b2c:	ffff4224 	addiu	v0,v0,-1
    3b30:	25e8c003 	move	sp,s8
    3b34:	0400be8f 	lw	s8,4(sp)
    3b38:	0800bd27 	addiu	sp,sp,8
    3b3c:	0800e003 	jr	ra
    3b40:	00000000 	nop
    3b44:	e0ffbd27 	addiu	sp,sp,-32
    3b48:	1c00bfaf 	sw	ra,28(sp)
    3b4c:	1800beaf 	sw	s8,24(sp)
    3b50:	25f0a003 	move	s8,sp
    3b54:	1000c0af 	sw	zero,16(s8)
    3b58:	7f80023c 	lui	v0,0x807f
    3b5c:	a400428c 	lw	v0,164(v0)
    3b60:	1000c38f 	lw	v1,16(s8)
    3b64:	2a106200 	slt	v0,v1,v0
    3b68:	3d004010 	beqz	v0,0x3c60
    3b6c:	00000000 	nop
    3b70:	7f80043c 	lui	a0,0x807f
    3b74:	1000c38f 	lw	v1,16(s8)
    3b78:	25106000 	move	v0,v1
    3b7c:	80100200 	sll	v0,v0,0x2
    3b80:	21104300 	addu	v0,v0,v1
    3b84:	80100200 	sll	v0,v0,0x2
    3b88:	a8008324 	addiu	v1,a0,168
    3b8c:	21104300 	addu	v0,v0,v1
    3b90:	0000428c 	lw	v0,0(v0)
    3b94:	25204000 	move	a0,v0
    3b98:	210d000c 	jal	0x3484
    3b9c:	00000000 	nop
    3ba0:	7f80023c 	lui	v0,0x807f
    3ba4:	1000c38f 	lw	v1,16(s8)
    3ba8:	a8004424 	addiu	a0,v0,168
    3bac:	25106000 	move	v0,v1
    3bb0:	80100200 	sll	v0,v0,0x2
    3bb4:	21104300 	addu	v0,v0,v1
    3bb8:	80100200 	sll	v0,v0,0x2
    3bbc:	21108200 	addu	v0,a0,v0
    3bc0:	0400428c 	lw	v0,4(v0)
    3bc4:	25204000 	move	a0,v0
    3bc8:	b50e000c 	jal	0x3ad4
    3bcc:	00000000 	nop
    3bd0:	25204000 	move	a0,v0
    3bd4:	210d000c 	jal	0x3484
    3bd8:	00000000 	nop
    3bdc:	7f80023c 	lui	v0,0x807f
    3be0:	1000c38f 	lw	v1,16(s8)
    3be4:	a8004424 	addiu	a0,v0,168
    3be8:	25106000 	move	v0,v1
    3bec:	80100200 	sll	v0,v0,0x2
    3bf0:	21104300 	addu	v0,v0,v1
    3bf4:	80100200 	sll	v0,v0,0x2
    3bf8:	21108200 	addu	v0,a0,v0
    3bfc:	0c00428c 	lw	v0,12(v0)
    3c00:	25204000 	move	a0,v0
    3c04:	210d000c 	jal	0x3484
    3c08:	00000000 	nop
    3c0c:	7f80043c 	lui	a0,0x807f
    3c10:	1000c38f 	lw	v1,16(s8)
    3c14:	25106000 	move	v0,v1
    3c18:	80100200 	sll	v0,v0,0x2
    3c1c:	21104300 	addu	v0,v0,v1
    3c20:	80100200 	sll	v0,v0,0x2
    3c24:	a8008324 	addiu	v1,a0,168
    3c28:	21104300 	addu	v0,v0,v1
    3c2c:	1000428c 	lw	v0,16(v0)
    3c30:	ff004230 	andi	v0,v0,0xff
    3c34:	25204000 	move	a0,v0
    3c38:	f00c000c 	jal	0x33c0
    3c3c:	00000000 	nop
    3c40:	0a000424 	li	a0,10
    3c44:	f00c000c 	jal	0x33c0
    3c48:	00000000 	nop
    3c4c:	1000c28f 	lw	v0,16(s8)
    3c50:	01004224 	addiu	v0,v0,1
    3c54:	1000c2af 	sw	v0,16(s8)
    3c58:	bfff0010 	b	0x3b58
    3c5c:	00000000 	nop
    3c60:	00000000 	nop
    3c64:	25e8c003 	move	sp,s8
    3c68:	1c00bf8f 	lw	ra,28(sp)
    3c6c:	1800be8f 	lw	s8,24(sp)
    3c70:	2000bd27 	addiu	sp,sp,32
    3c74:	0800e003 	jr	ra
    3c78:	00000000 	nop
    3c7c:	c8ffbd27 	addiu	sp,sp,-56
    3c80:	3400bfaf 	sw	ra,52(sp)
    3c84:	3000beaf 	sw	s8,48(sp)
    3c88:	2c00b1af 	sw	s1,44(sp)
    3c8c:	2800b0af 	sw	s0,40(sp)
    3c90:	25f0a003 	move	s8,sp
    3c94:	3800c4af 	sw	a0,56(s8)
    3c98:	3c00c5af 	sw	a1,60(s8)
    3c9c:	3800c48f 	lw	a0,56(s8)
    3ca0:	b50c000c 	jal	0x32d4
    3ca4:	00000000 	nop
    3ca8:	3800c28f 	lw	v0,56(s8)
    3cac:	02000324 	li	v1,2
    3cb0:	040043a0 	sb	v1,4(v0)
    3cb4:	3800c28f 	lw	v0,56(s8)
    3cb8:	55550324 	li	v1,21845
    3cbc:	000043ac 	sw	v1,0(v0)
    3cc0:	3800c28f 	lw	v0,56(s8)
    3cc4:	000040ac 	sw	zero,0(v0)
    3cc8:	1000c0af 	sw	zero,16(s8)
    3ccc:	7f80023c 	lui	v0,0x807f
    3cd0:	a400428c 	lw	v0,164(v0)
    3cd4:	1000c38f 	lw	v1,16(s8)
    3cd8:	2a106200 	slt	v0,v1,v0
    3cdc:	64004010 	beqz	v0,0x3e70
    3ce0:	00000000 	nop
    3ce4:	3800c28f 	lw	v0,56(s8)
    3ce8:	0000508c 	lw	s0,0(v0)
    3cec:	7f80043c 	lui	a0,0x807f
    3cf0:	1000c38f 	lw	v1,16(s8)
    3cf4:	25106000 	move	v0,v1
    3cf8:	80100200 	sll	v0,v0,0x2
    3cfc:	21104300 	addu	v0,v0,v1
    3d00:	80100200 	sll	v0,v0,0x2
    3d04:	a8008324 	addiu	v1,a0,168
    3d08:	21104300 	addu	v0,v0,v1
    3d0c:	0000518c 	lw	s1,0(v0)
    3d10:	7f80023c 	lui	v0,0x807f
    3d14:	1000c38f 	lw	v1,16(s8)
    3d18:	a8004424 	addiu	a0,v0,168
    3d1c:	25106000 	move	v0,v1
    3d20:	80100200 	sll	v0,v0,0x2
    3d24:	21104300 	addu	v0,v0,v1
    3d28:	80100200 	sll	v0,v0,0x2
    3d2c:	21108200 	addu	v0,a0,v0
    3d30:	0400428c 	lw	v0,4(v0)
    3d34:	25204000 	move	a0,v0
    3d38:	b50e000c 	jal	0x3ad4
    3d3c:	00000000 	nop
    3d40:	25304000 	move	a2,v0
    3d44:	7f80023c 	lui	v0,0x807f
    3d48:	1000c38f 	lw	v1,16(s8)
    3d4c:	a8004424 	addiu	a0,v0,168
    3d50:	25106000 	move	v0,v1
    3d54:	80100200 	sll	v0,v0,0x2
    3d58:	21104300 	addu	v0,v0,v1
    3d5c:	80100200 	sll	v0,v0,0x2
    3d60:	21108200 	addu	v0,a0,v0
    3d64:	0c00448c 	lw	a0,12(v0)
    3d68:	7f80053c 	lui	a1,0x807f
    3d6c:	1000c38f 	lw	v1,16(s8)
    3d70:	25106000 	move	v0,v1
    3d74:	80100200 	sll	v0,v0,0x2
    3d78:	21104300 	addu	v0,v0,v1
    3d7c:	80100200 	sll	v0,v0,0x2
    3d80:	a800a324 	addiu	v1,a1,168
    3d84:	21104300 	addu	v0,v0,v1
    3d88:	0800438c 	lw	v1,8(v0)
    3d8c:	3c00c28f 	lw	v0,60(s8)
    3d90:	0d006210 	beq	v1,v0,0x3dc8
    3d94:	00000000 	nop
    3d98:	7f80053c 	lui	a1,0x807f
    3d9c:	1000c38f 	lw	v1,16(s8)
    3da0:	25106000 	move	v0,v1
    3da4:	80100200 	sll	v0,v0,0x2
    3da8:	21104300 	addu	v0,v0,v1
    3dac:	80100200 	sll	v0,v0,0x2
    3db0:	a800a324 	addiu	v1,a1,168
    3db4:	21104300 	addu	v0,v0,v1
    3db8:	1000428c 	lw	v0,16(v0)
    3dbc:	01004324 	addiu	v1,v0,1
    3dc0:	02000010 	b	0x3dcc
    3dc4:	00000000 	nop
    3dc8:	10000324 	li	v1,16
    3dcc:	3800c58f 	lw	a1,56(s8)
    3dd0:	00111000 	sll	v0,s0,0x4
    3dd4:	2110a200 	addu	v0,a1,v0
    3dd8:	080051ac 	sw	s1,8(v0)
    3ddc:	3800c58f 	lw	a1,56(s8)
    3de0:	00111000 	sll	v0,s0,0x4
    3de4:	2110a200 	addu	v0,a1,v0
    3de8:	0c0046ac 	sw	a2,12(v0)
    3dec:	3800c58f 	lw	a1,56(s8)
    3df0:	01000226 	addiu	v0,s0,1
    3df4:	00110200 	sll	v0,v0,0x4
    3df8:	2110a200 	addu	v0,a1,v0
    3dfc:	000044ac 	sw	a0,0(v0)
    3e00:	3800c48f 	lw	a0,56(s8)
    3e04:	01000226 	addiu	v0,s0,1
    3e08:	00110200 	sll	v0,v0,0x4
    3e0c:	21108200 	addu	v0,a0,v0
    3e10:	040043ac 	sw	v1,4(v0)
    3e14:	3800c28f 	lw	v0,56(s8)
    3e18:	0000428c 	lw	v0,0(v0)
    3e1c:	3800c38f 	lw	v1,56(s8)
    3e20:	00110200 	sll	v0,v0,0x4
    3e24:	21106200 	addu	v0,v1,v0
    3e28:	0800458c 	lw	a1,8(v0)
    3e2c:	0c00448c 	lw	a0,12(v0)
    3e30:	1000438c 	lw	v1,16(v0)
    3e34:	1400428c 	lw	v0,20(v0)
    3e38:	1400c5af 	sw	a1,20(s8)
    3e3c:	1800c4af 	sw	a0,24(s8)
    3e40:	1c00c3af 	sw	v1,28(s8)
    3e44:	2000c2af 	sw	v0,32(s8)
    3e48:	3800c28f 	lw	v0,56(s8)
    3e4c:	0000428c 	lw	v0,0(v0)
    3e50:	01004324 	addiu	v1,v0,1
    3e54:	3800c28f 	lw	v0,56(s8)
    3e58:	000043ac 	sw	v1,0(v0)
    3e5c:	1000c28f 	lw	v0,16(s8)
    3e60:	01004224 	addiu	v0,v0,1
    3e64:	1000c2af 	sw	v0,16(s8)
    3e68:	98ff0010 	b	0x3ccc
    3e6c:	00000000 	nop
    3e70:	00000000 	nop
    3e74:	3800c28f 	lw	v0,56(s8)
    3e78:	25e8c003 	move	sp,s8
    3e7c:	3400bf8f 	lw	ra,52(sp)
    3e80:	3000be8f 	lw	s8,48(sp)
    3e84:	2c00b18f 	lw	s1,44(sp)
    3e88:	2800b08f 	lw	s0,40(sp)
    3e8c:	3800bd27 	addiu	sp,sp,56
    3e90:	0800e003 	jr	ra
    3e94:	00000000 	nop
    3e98:	e8ffbd27 	addiu	sp,sp,-24
    3e9c:	1400bfaf 	sw	ra,20(sp)
    3ea0:	1000beaf 	sw	s8,16(sp)
    3ea4:	25f0a003 	move	s8,sp
    3ea8:	1800c4af 	sw	a0,24(s8)
    3eac:	1800c48f 	lw	a0,24(s8)
    3eb0:	b50c000c 	jal	0x32d4
    3eb4:	00000000 	nop
    3eb8:	1800c28f 	lw	v0,24(s8)
    3ebc:	01000324 	li	v1,1
    3ec0:	040043a0 	sb	v1,4(v0)
    3ec4:	1800c28f 	lw	v0,24(s8)
    3ec8:	01000324 	li	v1,1
    3ecc:	000043ac 	sw	v1,0(v0)
    3ed0:	1800c28f 	lw	v0,24(s8)
    3ed4:	080040ac 	sw	zero,8(v0)
    3ed8:	1800c28f 	lw	v0,24(s8)
    3edc:	0c0040ac 	sw	zero,12(v0)
    3ee0:	1800c28f 	lw	v0,24(s8)
    3ee4:	100040ac 	sw	zero,16(v0)
    3ee8:	1800c28f 	lw	v0,24(s8)
    3eec:	10000324 	li	v1,16
    3ef0:	140043ac 	sw	v1,20(v0)
    3ef4:	00000000 	nop
    3ef8:	1800c28f 	lw	v0,24(s8)
    3efc:	25e8c003 	move	sp,s8
    3f00:	1400bf8f 	lw	ra,20(sp)
    3f04:	1000be8f 	lw	s8,16(sp)
    3f08:	1800bd27 	addiu	sp,sp,24
    3f0c:	0800e003 	jr	ra
    3f10:	00000000 	nop
    3f14:	f0ffbd27 	addiu	sp,sp,-16
    3f18:	0c00beaf 	sw	s8,12(sp)
    3f1c:	25f0a003 	move	s8,sp
    3f20:	1000c4af 	sw	a0,16(s8)
    3f24:	0000c0af 	sw	zero,0(s8)
    3f28:	04000224 	li	v0,4
    3f2c:	0400c2af 	sw	v0,4(s8)
    3f30:	0400c28f 	lw	v0,4(s8)
    3f34:	23004004 	bltz	v0,0x3fc4
    3f38:	00000000 	nop
    3f3c:	01000324 	li	v1,1
    3f40:	0400c28f 	lw	v0,4(s8)
    3f44:	04104300 	sllv	v0,v1,v0
    3f48:	01000324 	li	v1,1
    3f4c:	04104300 	sllv	v0,v1,v0
    3f50:	ffff4224 	addiu	v0,v0,-1
    3f54:	25184000 	move	v1,v0
    3f58:	1000c28f 	lw	v0,16(s8)
    3f5c:	24106200 	and	v0,v1,v0
    3f60:	01000424 	li	a0,1
    3f64:	0400c38f 	lw	v1,4(s8)
    3f68:	04186400 	sllv	v1,a0,v1
    3f6c:	01000424 	li	a0,1
    3f70:	04186400 	sllv	v1,a0,v1
    3f74:	ffff6324 	addiu	v1,v1,-1
    3f78:	07004314 	bne	v0,v1,0x3f98
    3f7c:	00000000 	nop
    3f80:	01000324 	li	v1,1
    3f84:	0400c28f 	lw	v0,4(s8)
    3f88:	04104300 	sllv	v0,v1,v0
    3f8c:	0000c38f 	lw	v1,0(s8)
    3f90:	21106200 	addu	v0,v1,v0
    3f94:	0000c2af 	sw	v0,0(s8)
    3f98:	01000324 	li	v1,1
    3f9c:	0400c28f 	lw	v0,4(s8)
    3fa0:	04104300 	sllv	v0,v1,v0
    3fa4:	1000c38f 	lw	v1,16(s8)
    3fa8:	06104300 	srlv	v0,v1,v0
    3fac:	1000c2af 	sw	v0,16(s8)
    3fb0:	0400c28f 	lw	v0,4(s8)
    3fb4:	ffff4224 	addiu	v0,v0,-1
    3fb8:	0400c2af 	sw	v0,4(s8)
    3fbc:	dcff0010 	b	0x3f30
    3fc0:	00000000 	nop
    3fc4:	0000c38f 	lw	v1,0(s8)
    3fc8:	1000c28f 	lw	v0,16(s8)
    3fcc:	21106200 	addu	v0,v1,v0
    3fd0:	25e8c003 	move	sp,s8
    3fd4:	0c00be8f 	lw	s8,12(sp)
    3fd8:	1000bd27 	addiu	sp,sp,16
    3fdc:	0800e003 	jr	ra
    3fe0:	00000000 	nop
    3fe4:	e8ffbd27 	addiu	sp,sp,-24
    3fe8:	1400bfaf 	sw	ra,20(sp)
    3fec:	1000beaf 	sw	s8,16(sp)
    3ff0:	25f0a003 	move	s8,sp
    3ff4:	1800c4af 	sw	a0,24(s8)
    3ff8:	1c00c5af 	sw	a1,28(s8)
    3ffc:	2000c6af 	sw	a2,32(s8)
    4000:	1c00c28f 	lw	v0,28(s8)
    4004:	0000438c 	lw	v1,0(v0)
    4008:	1800c28f 	lw	v0,24(s8)
    400c:	000043ac 	sw	v1,0(v0)
    4010:	1c00c28f 	lw	v0,28(s8)
    4014:	0400428c 	lw	v0,4(v0)
    4018:	25204000 	move	a0,v0
    401c:	c50f000c 	jal	0x3f14
    4020:	00000000 	nop
    4024:	25184000 	move	v1,v0
    4028:	1800c28f 	lw	v0,24(s8)
    402c:	040043ac 	sw	v1,4(v0)
    4030:	2000c38f 	lw	v1,32(s8)
    4034:	1800c28f 	lw	v0,24(s8)
    4038:	080043ac 	sw	v1,8(v0)
    403c:	1c00c28f 	lw	v0,28(s8)
    4040:	0800438c 	lw	v1,8(v0)
    4044:	1800c28f 	lw	v0,24(s8)
    4048:	0c0043ac 	sw	v1,12(v0)
    404c:	1c00c28f 	lw	v0,28(s8)
    4050:	0c00438c 	lw	v1,12(v0)
    4054:	1800c28f 	lw	v0,24(s8)
    4058:	100043ac 	sw	v1,16(v0)
    405c:	00000000 	nop
    4060:	1800c28f 	lw	v0,24(s8)
    4064:	25e8c003 	move	sp,s8
    4068:	1400bf8f 	lw	ra,20(sp)
    406c:	1000be8f 	lw	s8,16(sp)
    4070:	1800bd27 	addiu	sp,sp,24
    4074:	0800e003 	jr	ra
    4078:	00000000 	nop
    407c:	f0ffbd27 	addiu	sp,sp,-16
    4080:	0c00beaf 	sw	s8,12(sp)
    4084:	25f0a003 	move	s8,sp
    4088:	1000c4af 	sw	a0,16(s8)
    408c:	1400c5af 	sw	a1,20(s8)
    4090:	1800c6af 	sw	a2,24(s8)
    4094:	1400c28f 	lw	v0,20(s8)
    4098:	0000c2af 	sw	v0,0(s8)
    409c:	1000c28f 	lw	v0,16(s8)
    40a0:	0400c2af 	sw	v0,4(s8)
    40a4:	1800c28f 	lw	v0,24(s8)
    40a8:	ffff4324 	addiu	v1,v0,-1
    40ac:	1800c3af 	sw	v1,24(s8)
    40b0:	2b100200 	sltu	v0,zero,v0
    40b4:	ff004230 	andi	v0,v0,0xff
    40b8:	11004010 	beqz	v0,0x4100
    40bc:	00000000 	nop
    40c0:	0400c28f 	lw	v0,4(s8)
    40c4:	01004324 	addiu	v1,v0,1
    40c8:	0400c3af 	sw	v1,4(s8)
    40cc:	00004390 	lbu	v1,0(v0)
    40d0:	0000c28f 	lw	v0,0(s8)
    40d4:	01004424 	addiu	a0,v0,1
    40d8:	0000c4af 	sw	a0,0(s8)
    40dc:	00004290 	lbu	v0,0(v0)
    40e0:	26106200 	xor	v0,v1,v0
    40e4:	2b100200 	sltu	v0,zero,v0
    40e8:	ff004230 	andi	v0,v0,0xff
    40ec:	edff4010 	beqz	v0,0x40a4
    40f0:	00000000 	nop
    40f4:	01000224 	li	v0,1
    40f8:	02000010 	b	0x4104
    40fc:	00000000 	nop
    4100:	25100000 	move	v0,zero
    4104:	25e8c003 	move	sp,s8
    4108:	0c00be8f 	lw	s8,12(sp)
    410c:	1000bd27 	addiu	sp,sp,16
    4110:	0800e003 	jr	ra
    4114:	00000000 	nop
    4118:	88f5bd27 	addiu	sp,sp,-2680
    411c:	740abfaf 	sw	ra,2676(sp)
    4120:	700abeaf 	sw	s8,2672(sp)
    4124:	6c0ab1af 	sw	s1,2668(sp)
    4128:	680ab0af 	sw	s0,2664(sp)
    412c:	25f0a003 	move	s8,sp
    4130:	780ac4af 	sw	a0,2680(s8)
    4134:	7c0ac5af 	sw	a1,2684(s8)
    4138:	0080023c 	lui	v0,0x8000
    413c:	f0204424 	addiu	a0,v0,8432
    4140:	010d000c 	jal	0x3404
    4144:	00000000 	nop
    4148:	0080023c 	lui	v0,0x8000
    414c:	a0554524 	addiu	a1,v0,21920
    4150:	01000424 	li	a0,1
    4154:	6309000c 	jal	0x258c
    4158:	00000000 	nop
    415c:	5800c2af 	sw	v0,88(s8)
    4160:	5800c28f 	lw	v0,88(s8)
    4164:	04004104 	bgez	v0,0x4178
    4168:	00000000 	nop
    416c:	5800c28f 	lw	v0,88(s8)
    4170:	42030010 	b	0x4e7c
    4174:	00000000 	nop
    4178:	0080023c 	lui	v0,0x8000
    417c:	00214424 	addiu	a0,v0,8448
    4180:	010d000c 	jal	0x3404
    4184:	00000000 	nop
    4188:	2800c0af 	sw	zero,40(s8)
    418c:	2800c28f 	lw	v0,40(s8)
    4190:	0400422c 	sltiu	v0,v0,4
    4194:	2c004010 	beqz	v0,0x4248
    4198:	00000000 	nop
    419c:	d006c0af 	sw	zero,1744(s8)
    41a0:	d406c0af 	sw	zero,1748(s8)
    41a4:	d806c0af 	sw	zero,1752(s8)
    41a8:	dc06c0af 	sw	zero,1756(s8)
    41ac:	e006c0af 	sw	zero,1760(s8)
    41b0:	04000224 	li	v0,4
    41b4:	d406c2af 	sw	v0,1748(s8)
    41b8:	0080023c 	lui	v0,0x8000
    41bc:	2800c38f 	lw	v1,40(s8)
    41c0:	80180300 	sll	v1,v1,0x2
    41c4:	a0554224 	addiu	v0,v0,21920
    41c8:	21106200 	addu	v0,v1,v0
    41cc:	0000508c 	lw	s0,0(v0)
    41d0:	04000424 	li	a0,4
    41d4:	b50e000c 	jal	0x3ad4
    41d8:	00000000 	nop
    41dc:	24100202 	and	v0,s0,v0
    41e0:	d006c2af 	sw	v0,1744(s8)
    41e4:	2800c28f 	lw	v0,40(s8)
    41e8:	d806c2af 	sw	v0,1752(s8)
    41ec:	2800c28f 	lw	v0,40(s8)
    41f0:	01004224 	addiu	v0,v0,1
    41f4:	ff004230 	andi	v0,v0,0xff
    41f8:	00110200 	sll	v0,v0,0x4
    41fc:	ff004230 	andi	v0,v0,0xff
    4200:	25204000 	move	a0,v0
    4204:	470d000c 	jal	0x351c
    4208:	00000000 	nop
    420c:	dc06c38f 	lw	v1,1756(s8)
    4210:	e006c28f 	lw	v0,1760(s8)
    4214:	1000a3af 	sw	v1,16(sp)
    4218:	1400a2af 	sw	v0,20(sp)
    421c:	d006c58f 	lw	a1,1744(s8)
    4220:	d406c68f 	lw	a2,1748(s8)
    4224:	d806c78f 	lw	a3,1752(s8)
    4228:	01000424 	li	a0,1
    422c:	4f0b000c 	jal	0x2d3c
    4230:	00000000 	nop
    4234:	2800c28f 	lw	v0,40(s8)
    4238:	01004224 	addiu	v0,v0,1
    423c:	2800c2af 	sw	v0,40(s8)
    4240:	d2ff0010 	b	0x418c
    4244:	00000000 	nop
    4248:	0080023c 	lui	v0,0x8000
    424c:	14214424 	addiu	a0,v0,8468
    4250:	e30c000c 	jal	0x338c
    4254:	00000000 	nop
    4258:	2c00c0af 	sw	zero,44(s8)
    425c:	2c00c28f 	lw	v0,44(s8)
    4260:	04004228 	slti	v0,v0,4
    4264:	a3004010 	beqz	v0,0x44f4
    4268:	00000000 	nop
    426c:	2c00c28f 	lw	v0,44(s8)
    4270:	01004224 	addiu	v0,v0,1
    4274:	ff004230 	andi	v0,v0,0xff
    4278:	00110200 	sll	v0,v0,0x4
    427c:	ff004230 	andi	v0,v0,0xff
    4280:	01004224 	addiu	v0,v0,1
    4284:	ff004230 	andi	v0,v0,0xff
    4288:	25204000 	move	a0,v0
    428c:	470d000c 	jal	0x351c
    4290:	00000000 	nop
    4294:	8080023c 	lui	v0,0x8080
    4298:	c4a85024 	addiu	s0,v0,-22332
    429c:	8080023c 	lui	v0,0x8080
    42a0:	a8b040ac 	sw	zero,-20312(v0)
    42a4:	3805c227 	addiu	v0,s8,1336
    42a8:	25204000 	move	a0,v0
    42ac:	a60f000c 	jal	0x3e98
    42b0:	00000000 	nop
    42b4:	3805c227 	addiu	v0,s8,1336
    42b8:	25304000 	move	a2,v0
    42bc:	8080023c 	lui	v0,0x8080
    42c0:	a8b04524 	addiu	a1,v0,-20312
    42c4:	25200002 	move	a0,s0
    42c8:	2a0e000c 	jal	0x38a8
    42cc:	00000000 	nop
    42d0:	2c00c28f 	lw	v0,44(s8)
    42d4:	01004224 	addiu	v0,v0,1
    42d8:	ff004230 	andi	v0,v0,0xff
    42dc:	00110200 	sll	v0,v0,0x4
    42e0:	ff004230 	andi	v0,v0,0xff
    42e4:	02004224 	addiu	v0,v0,2
    42e8:	ff004230 	andi	v0,v0,0xff
    42ec:	25204000 	move	a0,v0
    42f0:	470d000c 	jal	0x351c
    42f4:	00000000 	nop
    42f8:	8080023c 	lui	v0,0x8080
    42fc:	bca84324 	addiu	v1,v0,-22340
    4300:	08020724 	li	a3,520
    4304:	08020624 	li	a2,520
    4308:	8080023c 	lui	v0,0x8080
    430c:	a8b04524 	addiu	a1,v0,-20312
    4310:	25206000 	move	a0,v1
    4314:	f70d000c 	jal	0x37dc
    4318:	00000000 	nop
    431c:	2c00c28f 	lw	v0,44(s8)
    4320:	01004224 	addiu	v0,v0,1
    4324:	ff004230 	andi	v0,v0,0xff
    4328:	00110200 	sll	v0,v0,0x4
    432c:	ff004230 	andi	v0,v0,0xff
    4330:	03004224 	addiu	v0,v0,3
    4334:	ff004230 	andi	v0,v0,0xff
    4338:	25204000 	move	a0,v0
    433c:	470d000c 	jal	0x351c
    4340:	00000000 	nop
    4344:	0080023c 	lui	v0,0x8000
    4348:	2c00c38f 	lw	v1,44(s8)
    434c:	80180300 	sll	v1,v1,0x2
    4350:	a0554224 	addiu	v0,v0,21920
    4354:	21106200 	addu	v0,v1,v0
    4358:	0000438c 	lw	v1,0(v0)
    435c:	0080023c 	lui	v0,0x8000
    4360:	b455428c 	lw	v0,21940(v0)
    4364:	25384000 	move	a3,v0
    4368:	25306000 	move	a2,v1
    436c:	8080023c 	lui	v0,0x8080
    4370:	a8b04524 	addiu	a1,v0,-20312
    4374:	8080023c 	lui	v0,0x8080
    4378:	a8a84424 	addiu	a0,v0,-22360
    437c:	a20d000c 	jal	0x3688
    4380:	00000000 	nop
    4384:	3000c0af 	sw	zero,48(s8)
    4388:	3000c38f 	lw	v1,48(s8)
    438c:	8080023c 	lui	v0,0x8080
    4390:	a8b0428c 	lw	v0,-20312(v0)
    4394:	2b106200 	sltu	v0,v1,v0
    4398:	20004010 	beqz	v0,0x441c
    439c:	00000000 	nop
    43a0:	8080023c 	lui	v0,0x8080
    43a4:	a8a84324 	addiu	v1,v0,-22360
    43a8:	3000c28f 	lw	v0,48(s8)
    43ac:	21106200 	addu	v0,v1,v0
    43b0:	00004290 	lbu	v0,0(v0)
    43b4:	03210200 	sra	a0,v0,0x4
    43b8:	8080023c 	lui	v0,0x8080
    43bc:	a8a84324 	addiu	v1,v0,-22360
    43c0:	3000c28f 	lw	v0,48(s8)
    43c4:	21106200 	addu	v0,v1,v0
    43c8:	00004290 	lbu	v0,0(v0)
    43cc:	0f004230 	andi	v0,v0,0xf
    43d0:	25304000 	move	a2,v0
    43d4:	25288000 	move	a1,a0
    43d8:	0080023c 	lui	v0,0x8000
    43dc:	24214424 	addiu	a0,v0,8484
    43e0:	e30c000c 	jal	0x338c
    43e4:	00000000 	nop
    43e8:	8080023c 	lui	v0,0x8080
    43ec:	a8a84324 	addiu	v1,v0,-22360
    43f0:	3000c28f 	lw	v0,48(s8)
    43f4:	21106200 	addu	v0,v1,v0
    43f8:	00004290 	lbu	v0,0(v0)
    43fc:	25204000 	move	a0,v0
    4400:	f00c000c 	jal	0x33c0
    4404:	00000000 	nop
    4408:	3000c28f 	lw	v0,48(s8)
    440c:	01004224 	addiu	v0,v0,1
    4410:	3000c2af 	sw	v0,48(s8)
    4414:	dcff0010 	b	0x4388
    4418:	00000000 	nop
    441c:	0080023c 	lui	v0,0x8000
    4420:	2c214424 	addiu	a0,v0,8492
    4424:	e30c000c 	jal	0x338c
    4428:	00000000 	nop
    442c:	2c00c28f 	lw	v0,44(s8)
    4430:	01004224 	addiu	v0,v0,1
    4434:	ff004230 	andi	v0,v0,0xff
    4438:	00110200 	sll	v0,v0,0x4
    443c:	ff004230 	andi	v0,v0,0xff
    4440:	04004224 	addiu	v0,v0,4
    4444:	ff004230 	andi	v0,v0,0xff
    4448:	25204000 	move	a0,v0
    444c:	470d000c 	jal	0x351c
    4450:	00000000 	nop
    4454:	8080023c 	lui	v0,0x8080
    4458:	a8b0438c 	lw	v1,-20312(v0)
    445c:	0080023c 	lui	v0,0x8000
    4460:	b8554724 	addiu	a3,v0,21944
    4464:	25306000 	move	a2,v1
    4468:	8080023c 	lui	v0,0x8080
    446c:	a8a84524 	addiu	a1,v0,-22360
    4470:	2c00c48f 	lw	a0,44(s8)
    4474:	870a000c 	jal	0x2a1c
    4478:	00000000 	nop
    447c:	2c00c28f 	lw	v0,44(s8)
    4480:	01004224 	addiu	v0,v0,1
    4484:	ff004230 	andi	v0,v0,0xff
    4488:	00110200 	sll	v0,v0,0x4
    448c:	ff004230 	andi	v0,v0,0xff
    4490:	05004224 	addiu	v0,v0,5
    4494:	ff004230 	andi	v0,v0,0xff
    4498:	25204000 	move	a0,v0
    449c:	470d000c 	jal	0x351c
    44a0:	00000000 	nop
    44a4:	8080023c 	lui	v0,0x8080
    44a8:	a8b0428c 	lw	v0,-20312(v0)
    44ac:	ecff4324 	addiu	v1,v0,-20
    44b0:	8080023c 	lui	v0,0x8080
    44b4:	a8b043ac 	sw	v1,-20312(v0)
    44b8:	2c00c28f 	lw	v0,44(s8)
    44bc:	01004224 	addiu	v0,v0,1
    44c0:	ff004230 	andi	v0,v0,0xff
    44c4:	00110200 	sll	v0,v0,0x4
    44c8:	ff004230 	andi	v0,v0,0xff
    44cc:	06004224 	addiu	v0,v0,6
    44d0:	ff004230 	andi	v0,v0,0xff
    44d4:	25204000 	move	a0,v0
    44d8:	470d000c 	jal	0x351c
    44dc:	00000000 	nop
    44e0:	2c00c28f 	lw	v0,44(s8)
    44e4:	01004224 	addiu	v0,v0,1
    44e8:	2c00c2af 	sw	v0,44(s8)
    44ec:	5bff0010 	b	0x425c
    44f0:	00000000 	nop
    44f4:	8009000c 	jal	0x2600
    44f8:	00000000 	nop
    44fc:	3800c2af 	sw	v0,56(s8)
    4500:	3c00c3af 	sw	v1,60(s8)
    4504:	66000424 	li	a0,102
    4508:	470d000c 	jal	0x351c
    450c:	00000000 	nop
    4510:	0080023c 	lui	v0,0x8000
    4514:	30214424 	addiu	a0,v0,8496
    4518:	e30c000c 	jal	0x338c
    451c:	00000000 	nop
    4520:	4000c0af 	sw	zero,64(s8)
    4524:	4000c28f 	lw	v0,64(s8)
    4528:	04004228 	slti	v0,v0,4
    452c:	60004010 	beqz	v0,0x46b0
    4530:	00000000 	nop
    4534:	8080023c 	lui	v0,0x8080
    4538:	c4a85024 	addiu	s0,v0,-22332
    453c:	8080023c 	lui	v0,0x8080
    4540:	a8b040ac 	sw	zero,-20312(v0)
    4544:	a003c227 	addiu	v0,s8,928
    4548:	4000c58f 	lw	a1,64(s8)
    454c:	25204000 	move	a0,v0
    4550:	1f0f000c 	jal	0x3c7c
    4554:	00000000 	nop
    4558:	a003c227 	addiu	v0,s8,928
    455c:	25304000 	move	a2,v0
    4560:	8080023c 	lui	v0,0x8080
    4564:	a8b04524 	addiu	a1,v0,-20312
    4568:	25200002 	move	a0,s0
    456c:	2a0e000c 	jal	0x38a8
    4570:	00000000 	nop
    4574:	8080023c 	lui	v0,0x8080
    4578:	bca84324 	addiu	v1,v0,-22340
    457c:	08020724 	li	a3,520
    4580:	08020624 	li	a2,520
    4584:	8080023c 	lui	v0,0x8080
    4588:	a8b04524 	addiu	a1,v0,-20312
    458c:	25206000 	move	a0,v1
    4590:	f70d000c 	jal	0x37dc
    4594:	00000000 	nop
    4598:	0080023c 	lui	v0,0x8000
    459c:	4000c38f 	lw	v1,64(s8)
    45a0:	80180300 	sll	v1,v1,0x2
    45a4:	a0554224 	addiu	v0,v0,21920
    45a8:	21106200 	addu	v0,v1,v0
    45ac:	0000438c 	lw	v1,0(v0)
    45b0:	0080023c 	lui	v0,0x8000
    45b4:	b455428c 	lw	v0,21940(v0)
    45b8:	25384000 	move	a3,v0
    45bc:	25306000 	move	a2,v1
    45c0:	8080023c 	lui	v0,0x8080
    45c4:	a8b04524 	addiu	a1,v0,-20312
    45c8:	8080023c 	lui	v0,0x8080
    45cc:	a8a84424 	addiu	a0,v0,-22360
    45d0:	a20d000c 	jal	0x3688
    45d4:	00000000 	nop
    45d8:	4400c0af 	sw	zero,68(s8)
    45dc:	4400c38f 	lw	v1,68(s8)
    45e0:	8080023c 	lui	v0,0x8080
    45e4:	a8b0428c 	lw	v0,-20312(v0)
    45e8:	2b106200 	sltu	v0,v1,v0
    45ec:	18004010 	beqz	v0,0x4650
    45f0:	00000000 	nop
    45f4:	8080023c 	lui	v0,0x8080
    45f8:	a8a84324 	addiu	v1,v0,-22360
    45fc:	4400c28f 	lw	v0,68(s8)
    4600:	21106200 	addu	v0,v1,v0
    4604:	00004290 	lbu	v0,0(v0)
    4608:	03210200 	sra	a0,v0,0x4
    460c:	8080023c 	lui	v0,0x8080
    4610:	a8a84324 	addiu	v1,v0,-22360
    4614:	4400c28f 	lw	v0,68(s8)
    4618:	21106200 	addu	v0,v1,v0
    461c:	00004290 	lbu	v0,0(v0)
    4620:	0f004230 	andi	v0,v0,0xf
    4624:	25304000 	move	a2,v0
    4628:	25288000 	move	a1,a0
    462c:	0080023c 	lui	v0,0x8000
    4630:	24214424 	addiu	a0,v0,8484
    4634:	e30c000c 	jal	0x338c
    4638:	00000000 	nop
    463c:	4400c28f 	lw	v0,68(s8)
    4640:	01004224 	addiu	v0,v0,1
    4644:	4400c2af 	sw	v0,68(s8)
    4648:	e4ff0010 	b	0x45dc
    464c:	00000000 	nop
    4650:	0080023c 	lui	v0,0x8000
    4654:	2c214424 	addiu	a0,v0,8492
    4658:	e30c000c 	jal	0x338c
    465c:	00000000 	nop
    4660:	8080023c 	lui	v0,0x8080
    4664:	a8b0438c 	lw	v1,-20312(v0)
    4668:	0080023c 	lui	v0,0x8000
    466c:	b8554724 	addiu	a3,v0,21944
    4670:	25306000 	move	a2,v1
    4674:	8080023c 	lui	v0,0x8080
    4678:	a8a84524 	addiu	a1,v0,-22360
    467c:	4000c48f 	lw	a0,64(s8)
    4680:	870a000c 	jal	0x2a1c
    4684:	00000000 	nop
    4688:	8080023c 	lui	v0,0x8080
    468c:	a8b0428c 	lw	v0,-20312(v0)
    4690:	ecff4324 	addiu	v1,v0,-20
    4694:	8080023c 	lui	v0,0x8080
    4698:	a8b043ac 	sw	v1,-20312(v0)
    469c:	4000c28f 	lw	v0,64(s8)
    46a0:	01004224 	addiu	v0,v0,1
    46a4:	4000c2af 	sw	v0,64(s8)
    46a8:	9eff0010 	b	0x4524
    46ac:	00000000 	nop
    46b0:	0080023c 	lui	v0,0x8000
    46b4:	38214424 	addiu	a0,v0,8504
    46b8:	010d000c 	jal	0x3404
    46bc:	00000000 	nop
    46c0:	0080023c 	lui	v0,0x8000
    46c4:	40214424 	addiu	a0,v0,8512
    46c8:	e30c000c 	jal	0x338c
    46cc:	00000000 	nop
    46d0:	8009000c 	jal	0x2600
    46d4:	00000000 	nop
    46d8:	6000c2af 	sw	v0,96(s8)
    46dc:	6400c3af 	sw	v1,100(s8)
    46e0:	3800c48f 	lw	a0,56(s8)
    46e4:	3c00c58f 	lw	a1,60(s8)
    46e8:	fa000624 	li	a2,250
    46ec:	25380000 	move	a3,zero
    46f0:	21108600 	addu	v0,a0,a2
    46f4:	2b404400 	sltu	t0,v0,a0
    46f8:	2118a700 	addu	v1,a1,a3
    46fc:	21200301 	addu	a0,t0,v1
    4700:	25188000 	move	v1,a0
    4704:	6400c48f 	lw	a0,100(s8)
    4708:	2b206400 	sltu	a0,v1,a0
    470c:	09008014 	bnez	a0,0x4734
    4710:	00000000 	nop
    4714:	6400c48f 	lw	a0,100(s8)
    4718:	25286000 	move	a1,v1
    471c:	52008514 	bne	a0,a1,0x4868
    4720:	00000000 	nop
    4724:	6000c48f 	lw	a0,96(s8)
    4728:	2b104400 	sltu	v0,v0,a0
    472c:	4e004010 	beqz	v0,0x4868
    4730:	00000000 	nop
    4734:	66000424 	li	a0,102
    4738:	470d000c 	jal	0x351c
    473c:	00000000 	nop
    4740:	0080023c 	lui	v0,0x8000
    4744:	48214424 	addiu	a0,v0,8520
    4748:	e30c000c 	jal	0x338c
    474c:	00000000 	nop
    4750:	4800c0af 	sw	zero,72(s8)
    4754:	4800c28f 	lw	v0,72(s8)
    4758:	04004228 	slti	v0,v0,4
    475c:	3e004010 	beqz	v0,0x4858
    4760:	00000000 	nop
    4764:	8080023c 	lui	v0,0x8080
    4768:	c4a85024 	addiu	s0,v0,-22332
    476c:	8080023c 	lui	v0,0x8080
    4770:	a8b040ac 	sw	zero,-20312(v0)
    4774:	0802c227 	addiu	v0,s8,520
    4778:	4800c58f 	lw	a1,72(s8)
    477c:	25204000 	move	a0,v0
    4780:	1f0f000c 	jal	0x3c7c
    4784:	00000000 	nop
    4788:	0802c227 	addiu	v0,s8,520
    478c:	25304000 	move	a2,v0
    4790:	8080023c 	lui	v0,0x8080
    4794:	a8b04524 	addiu	a1,v0,-20312
    4798:	25200002 	move	a0,s0
    479c:	2a0e000c 	jal	0x38a8
    47a0:	00000000 	nop
    47a4:	8080023c 	lui	v0,0x8080
    47a8:	bca84324 	addiu	v1,v0,-22340
    47ac:	08020724 	li	a3,520
    47b0:	08020624 	li	a2,520
    47b4:	8080023c 	lui	v0,0x8080
    47b8:	a8b04524 	addiu	a1,v0,-20312
    47bc:	25206000 	move	a0,v1
    47c0:	f70d000c 	jal	0x37dc
    47c4:	00000000 	nop
    47c8:	0080023c 	lui	v0,0x8000
    47cc:	4800c38f 	lw	v1,72(s8)
    47d0:	80180300 	sll	v1,v1,0x2
    47d4:	a0554224 	addiu	v0,v0,21920
    47d8:	21106200 	addu	v0,v1,v0
    47dc:	0000438c 	lw	v1,0(v0)
    47e0:	0080023c 	lui	v0,0x8000
    47e4:	b455428c 	lw	v0,21940(v0)
    47e8:	25384000 	move	a3,v0
    47ec:	25306000 	move	a2,v1
    47f0:	8080023c 	lui	v0,0x8080
    47f4:	a8b04524 	addiu	a1,v0,-20312
    47f8:	8080023c 	lui	v0,0x8080
    47fc:	a8a84424 	addiu	a0,v0,-22360
    4800:	a20d000c 	jal	0x3688
    4804:	00000000 	nop
    4808:	8080023c 	lui	v0,0x8080
    480c:	a8b0438c 	lw	v1,-20312(v0)
    4810:	0080023c 	lui	v0,0x8000
    4814:	b8554724 	addiu	a3,v0,21944
    4818:	25306000 	move	a2,v1
    481c:	8080023c 	lui	v0,0x8080
    4820:	a8a84524 	addiu	a1,v0,-22360
    4824:	4800c48f 	lw	a0,72(s8)
    4828:	870a000c 	jal	0x2a1c
    482c:	00000000 	nop
    4830:	8080023c 	lui	v0,0x8080
    4834:	a8b0428c 	lw	v0,-20312(v0)
    4838:	ecff4324 	addiu	v1,v0,-20
    483c:	8080023c 	lui	v0,0x8080
    4840:	a8b043ac 	sw	v1,-20312(v0)
    4844:	4800c28f 	lw	v0,72(s8)
    4848:	01004224 	addiu	v0,v0,1
    484c:	4800c2af 	sw	v0,72(s8)
    4850:	c0ff0010 	b	0x4754
    4854:	00000000 	nop
    4858:	6000c28f 	lw	v0,96(s8)
    485c:	6400c38f 	lw	v1,100(s8)
    4860:	3800c2af 	sw	v0,56(s8)
    4864:	3c00c3af 	sw	v1,60(s8)
    4868:	0f000224 	li	v0,15
    486c:	6800c2af 	sw	v0,104(s8)
    4870:	e406c427 	addiu	a0,s8,1764
    4874:	f406c227 	addiu	v0,s8,1780
    4878:	2000a2af 	sw	v0,32(sp)
    487c:	e8030224 	li	v0,1000
    4880:	25180000 	move	v1,zero
    4884:	1800a2af 	sw	v0,24(sp)
    4888:	1c00a3af 	sw	v1,28(sp)
    488c:	ec06c227 	addiu	v0,s8,1772
    4890:	1000a2af 	sw	v0,16(sp)
    4894:	25388000 	move	a3,a0
    4898:	00080624 	li	a2,2048
    489c:	8080023c 	lui	v0,0x8080
    48a0:	a8a04524 	addiu	a1,v0,-24408
    48a4:	6800c48f 	lw	a0,104(s8)
    48a8:	cd09000c 	jal	0x2734
    48ac:	00000000 	nop
    48b0:	5800c2af 	sw	v0,88(s8)
    48b4:	5800c38f 	lw	v1,88(s8)
    48b8:	1cfc0224 	li	v0,-996
    48bc:	04006214 	bne	v1,v0,0x48d0
    48c0:	00000000 	nop
    48c4:	25100000 	move	v0,zero
    48c8:	6c010010 	b	0x4e7c
    48cc:	00000000 	nop
    48d0:	5800c28f 	lw	v0,88(s8)
    48d4:	04004104 	bgez	v0,0x48e8
    48d8:	00000000 	nop
    48dc:	5800c28f 	lw	v0,88(s8)
    48e0:	66010010 	b	0x4e7c
    48e4:	00000000 	nop
    48e8:	5800c28f 	lw	v0,88(s8)
    48ec:	60014010 	beqz	v0,0x4e70
    48f0:	00000000 	nop
    48f4:	5800c28f 	lw	v0,88(s8)
    48f8:	0108422c 	sltiu	v0,v0,2049
    48fc:	07004014 	bnez	v0,0x491c
    4900:	00000000 	nop
    4904:	0080023c 	lui	v0,0x8000
    4908:	5c214424 	addiu	a0,v0,8540
    490c:	e30c000c 	jal	0x338c
    4910:	00000000 	nop
    4914:	57010010 	b	0x4e74
    4918:	00000000 	nop
    491c:	5800c28f 	lw	v0,88(s8)
    4920:	25284000 	move	a1,v0
    4924:	8080023c 	lui	v0,0x8080
    4928:	a8a04424 	addiu	a0,v0,-24408
    492c:	c308000c 	jal	0x230c
    4930:	00000000 	nop
    4934:	01004238 	xori	v0,v0,0x1
    4938:	ff004230 	andi	v0,v0,0xff
    493c:	08004010 	beqz	v0,0x4960
    4940:	00000000 	nop
    4944:	5800c58f 	lw	a1,88(s8)
    4948:	0080023c 	lui	v0,0x8000
    494c:	7c214424 	addiu	a0,v0,8572
    4950:	e30c000c 	jal	0x338c
    4954:	00000000 	nop
    4958:	46010010 	b	0x4e74
    495c:	00000000 	nop
    4960:	8080023c 	lui	v0,0x8080
    4964:	a8a04224 	addiu	v0,v0,-24408
    4968:	0c00428c 	lw	v0,12(v0)
    496c:	6c00c2af 	sw	v0,108(s8)
    4970:	8080023c 	lui	v0,0x8080
    4974:	a8a04224 	addiu	v0,v0,-24408
    4978:	1000428c 	lw	v0,16(v0)
    497c:	f806c2af 	sw	v0,1784(s8)
    4980:	4c00c0a3 	sb	zero,76(s8)
    4984:	5000c0af 	sw	zero,80(s8)
    4988:	5000c28f 	lw	v0,80(s8)
    498c:	04004228 	slti	v0,v0,4
    4990:	19004010 	beqz	v0,0x49f8
    4994:	00000000 	nop
    4998:	5000c28f 	lw	v0,80(s8)
    499c:	80180200 	sll	v1,v0,0x2
    49a0:	0080023c 	lui	v0,0x8000
    49a4:	a0554224 	addiu	v0,v0,21920
    49a8:	21186200 	addu	v1,v1,v0
    49ac:	f806c227 	addiu	v0,s8,1784
    49b0:	04000624 	li	a2,4
    49b4:	25286000 	move	a1,v1
    49b8:	25204000 	move	a0,v0
    49bc:	1f10000c 	jal	0x407c
    49c0:	00000000 	nop
    49c4:	0100422c 	sltiu	v0,v0,1
    49c8:	ff004230 	andi	v0,v0,0xff
    49cc:	05004010 	beqz	v0,0x49e4
    49d0:	00000000 	nop
    49d4:	01000224 	li	v0,1
    49d8:	4c00c2a3 	sb	v0,76(s8)
    49dc:	06000010 	b	0x49f8
    49e0:	00000000 	nop
    49e4:	5000c28f 	lw	v0,80(s8)
    49e8:	01004224 	addiu	v0,v0,1
    49ec:	5000c2af 	sw	v0,80(s8)
    49f0:	e5ff0010 	b	0x4988
    49f4:	00000000 	nop
    49f8:	f806c28f 	lw	v0,1784(s8)
    49fc:	e0004330 	andi	v1,v0,0xe0
    4a00:	e0000224 	li	v0,224
    4a04:	03006214 	bne	v1,v0,0x4a14
    4a08:	00000000 	nop
    4a0c:	01000224 	li	v0,1
    4a10:	4c00c2a3 	sb	v0,76(s8)
    4a14:	4c00c293 	lbu	v0,76(s8)
    4a18:	fd004010 	beqz	v0,0x4e10
    4a1c:	00000000 	nop
    4a20:	cc08c227 	addiu	v0,s8,2252
    4a24:	25204000 	move	a0,v0
    4a28:	b50c000c 	jal	0x32d4
    4a2c:	00000000 	nop
    4a30:	5800c28f 	lw	v0,88(s8)
    4a34:	cc08c327 	addiu	v1,s8,2252
    4a38:	25306000 	move	a2,v1
    4a3c:	25284000 	move	a1,v0
    4a40:	8080023c 	lui	v0,0x8080
    4a44:	a8a04424 	addiu	a0,v0,-24408
    4a48:	a713000c 	jal	0x4e9c
    4a4c:	00000000 	nop
    4a50:	17ff4010 	beqz	v0,0x46b0
    4a54:	00000000 	nop
    4a58:	0080023c 	lui	v0,0x8000
    4a5c:	98214424 	addiu	a0,v0,8600
    4a60:	e30c000c 	jal	0x338c
    4a64:	00000000 	nop
    4a68:	d008c393 	lbu	v1,2256(s8)
    4a6c:	01000224 	li	v0,1
    4a70:	3a006214 	bne	v1,v0,0x4b5c
    4a74:	00000000 	nop
    4a78:	0080023c 	lui	v0,0x8000
    4a7c:	ac214424 	addiu	a0,v0,8620
    4a80:	e30c000c 	jal	0x338c
    4a84:	00000000 	nop
    4a88:	8080023c 	lui	v0,0x8080
    4a8c:	c4a85024 	addiu	s0,v0,-22332
    4a90:	8080023c 	lui	v0,0x8080
    4a94:	a8b040ac 	sw	zero,-20312(v0)
    4a98:	f406c38f 	lw	v1,1780(s8)
    4a9c:	7000c227 	addiu	v0,s8,112
    4aa0:	25286000 	move	a1,v1
    4aa4:	25204000 	move	a0,v0
    4aa8:	1f0f000c 	jal	0x3c7c
    4aac:	00000000 	nop
    4ab0:	7000c227 	addiu	v0,s8,112
    4ab4:	25304000 	move	a2,v0
    4ab8:	8080023c 	lui	v0,0x8080
    4abc:	a8b04524 	addiu	a1,v0,-20312
    4ac0:	25200002 	move	a0,s0
    4ac4:	2a0e000c 	jal	0x38a8
    4ac8:	00000000 	nop
    4acc:	8080023c 	lui	v0,0x8080
    4ad0:	bca84324 	addiu	v1,v0,-22340
    4ad4:	08020724 	li	a3,520
    4ad8:	08020624 	li	a2,520
    4adc:	8080023c 	lui	v0,0x8080
    4ae0:	a8b04524 	addiu	a1,v0,-20312
    4ae4:	25206000 	move	a0,v1
    4ae8:	f70d000c 	jal	0x37dc
    4aec:	00000000 	nop
    4af0:	f406c38f 	lw	v1,1780(s8)
    4af4:	0080023c 	lui	v0,0x8000
    4af8:	80180300 	sll	v1,v1,0x2
    4afc:	a0554224 	addiu	v0,v0,21920
    4b00:	21106200 	addu	v0,v1,v0
    4b04:	0000428c 	lw	v0,0(v0)
    4b08:	6c00c78f 	lw	a3,108(s8)
    4b0c:	25304000 	move	a2,v0
    4b10:	8080023c 	lui	v0,0x8080
    4b14:	a8b04524 	addiu	a1,v0,-20312
    4b18:	8080023c 	lui	v0,0x8080
    4b1c:	a8a84424 	addiu	a0,v0,-22360
    4b20:	a20d000c 	jal	0x3688
    4b24:	00000000 	nop
    4b28:	f406c38f 	lw	v1,1780(s8)
    4b2c:	8080023c 	lui	v0,0x8080
    4b30:	a8b0428c 	lw	v0,-20312(v0)
    4b34:	e406c427 	addiu	a0,s8,1764
    4b38:	25388000 	move	a3,a0
    4b3c:	25304000 	move	a2,v0
    4b40:	8080023c 	lui	v0,0x8080
    4b44:	a8a84524 	addiu	a1,v0,-22360
    4b48:	25206000 	move	a0,v1
    4b4c:	870a000c 	jal	0x2a1c
    4b50:	00000000 	nop
    4b54:	d6fe0010 	b	0x46b0
    4b58:	00000000 	nop
    4b5c:	3407c227 	addiu	v0,s8,1844
    4b60:	25204000 	move	a0,v0
    4b64:	b50c000c 	jal	0x32d4
    4b68:	00000000 	nop
    4b6c:	02000224 	li	v0,2
    4b70:	3807c2a3 	sb	v0,1848(s8)
    4b74:	3407c0af 	sw	zero,1844(s8)
    4b78:	cc08c28f 	lw	v0,2252(s8)
    4b7c:	25284000 	move	a1,v0
    4b80:	0080023c 	lui	v0,0x8000
    4b84:	c0214424 	addiu	a0,v0,8640
    4b88:	e30c000c 	jal	0x338c
    4b8c:	00000000 	nop
    4b90:	5400c0af 	sw	zero,84(s8)
    4b94:	cc08c38f 	lw	v1,2252(s8)
    4b98:	5400c28f 	lw	v0,84(s8)
    4b9c:	2b104300 	sltu	v0,v0,v1
    4ba0:	61004010 	beqz	v0,0x4d28
    4ba4:	00000000 	nop
    4ba8:	5400c28f 	lw	v0,84(s8)
    4bac:	01004224 	addiu	v0,v0,1
    4bb0:	00110200 	sll	v0,v0,0x4
    4bb4:	2800c327 	addiu	v1,s8,40
    4bb8:	21106200 	addu	v0,v1,v0
    4bbc:	a808428c 	lw	v0,2216(v0)
    4bc0:	1000422c 	sltiu	v0,v0,16
    4bc4:	3d004010 	beqz	v0,0x4cbc
    4bc8:	00000000 	nop
    4bcc:	cc08c327 	addiu	v1,s8,2252
    4bd0:	5400c28f 	lw	v0,84(s8)
    4bd4:	00110200 	sll	v0,v0,0x4
    4bd8:	08004224 	addiu	v0,v0,8
    4bdc:	21186200 	addu	v1,v1,v0
    4be0:	f406c48f 	lw	a0,1780(s8)
    4be4:	fc06c227 	addiu	v0,s8,1788
    4be8:	25308000 	move	a2,a0
    4bec:	25286000 	move	a1,v1
    4bf0:	25204000 	move	a0,v0
    4bf4:	f90f000c 	jal	0x3fe4
    4bf8:	00000000 	nop
    4bfc:	0807c38f 	lw	v1,1800(s8)
    4c00:	0c07c28f 	lw	v0,1804(s8)
    4c04:	1000a3af 	sw	v1,16(sp)
    4c08:	1400a2af 	sw	v0,20(sp)
    4c0c:	fc06c58f 	lw	a1,1788(s8)
    4c10:	0007c68f 	lw	a2,1792(s8)
    4c14:	0407c78f 	lw	a3,1796(s8)
    4c18:	01000424 	li	a0,1
    4c1c:	4f0b000c 	jal	0x2d3c
    4c20:	00000000 	nop
    4c24:	3b004010 	beqz	v0,0x4d14
    4c28:	00000000 	nop
    4c2c:	3407d08f 	lw	s0,1844(s8)
    4c30:	01000226 	addiu	v0,s0,1
    4c34:	3407c2af 	sw	v0,1844(s8)
    4c38:	fc06d18f 	lw	s1,1788(s8)
    4c3c:	0007c28f 	lw	v0,1792(s8)
    4c40:	25204000 	move	a0,v0
    4c44:	b50e000c 	jal	0x3ad4
    4c48:	00000000 	nop
    4c4c:	24882202 	and	s1,s1,v0
    4c50:	0007c28f 	lw	v0,1792(s8)
    4c54:	25204000 	move	a0,v0
    4c58:	b50e000c 	jal	0x3ad4
    4c5c:	00000000 	nop
    4c60:	25284000 	move	a1,v0
    4c64:	0807c38f 	lw	v1,1800(s8)
    4c68:	00111000 	sll	v0,s0,0x4
    4c6c:	2800c427 	addiu	a0,s8,40
    4c70:	21108200 	addu	v0,a0,v0
    4c74:	140751ac 	sw	s1,1812(v0)
    4c78:	00111000 	sll	v0,s0,0x4
    4c7c:	2800c427 	addiu	a0,s8,40
    4c80:	21108200 	addu	v0,a0,v0
    4c84:	180745ac 	sw	a1,1816(v0)
    4c88:	01000226 	addiu	v0,s0,1
    4c8c:	00110200 	sll	v0,v0,0x4
    4c90:	2800c427 	addiu	a0,s8,40
    4c94:	21108200 	addu	v0,a0,v0
    4c98:	0c0743ac 	sw	v1,1804(v0)
    4c9c:	01000226 	addiu	v0,s0,1
    4ca0:	00110200 	sll	v0,v0,0x4
    4ca4:	2800c327 	addiu	v1,s8,40
    4ca8:	21106200 	addu	v0,v1,v0
    4cac:	10000324 	li	v1,16
    4cb0:	100743ac 	sw	v1,1808(v0)
    4cb4:	17000010 	b	0x4d14
    4cb8:	00000000 	nop
    4cbc:	cc08c327 	addiu	v1,s8,2252
    4cc0:	5400c28f 	lw	v0,84(s8)
    4cc4:	00110200 	sll	v0,v0,0x4
    4cc8:	08004224 	addiu	v0,v0,8
    4ccc:	21186200 	addu	v1,v1,v0
    4cd0:	f406c48f 	lw	a0,1780(s8)
    4cd4:	1007c227 	addiu	v0,s8,1808
    4cd8:	25308000 	move	a2,a0
    4cdc:	25286000 	move	a1,v1
    4ce0:	25204000 	move	a0,v0
    4ce4:	f90f000c 	jal	0x3fe4
    4ce8:	00000000 	nop
    4cec:	1c07c38f 	lw	v1,1820(s8)
    4cf0:	2007c28f 	lw	v0,1824(s8)
    4cf4:	1000a3af 	sw	v1,16(sp)
    4cf8:	1400a2af 	sw	v0,20(sp)
    4cfc:	1007c58f 	lw	a1,1808(s8)
    4d00:	1407c68f 	lw	a2,1812(s8)
    4d04:	1807c78f 	lw	a3,1816(s8)
    4d08:	25200000 	move	a0,zero
    4d0c:	4f0b000c 	jal	0x2d3c
    4d10:	00000000 	nop
    4d14:	5400c28f 	lw	v0,84(s8)
    4d18:	01004224 	addiu	v0,v0,1
    4d1c:	5400c2af 	sw	v0,84(s8)
    4d20:	9cff0010 	b	0x4b94
    4d24:	00000000 	nop
    4d28:	3407c28f 	lw	v0,1844(s8)
    4d2c:	60fe4010 	beqz	v0,0x46b0
    4d30:	00000000 	nop
    4d34:	3407c28f 	lw	v0,1844(s8)
    4d38:	f406c38f 	lw	v1,1780(s8)
    4d3c:	25306000 	move	a2,v1
    4d40:	25284000 	move	a1,v0
    4d44:	0080023c 	lui	v0,0x8000
    4d48:	d8214424 	addiu	a0,v0,8664
    4d4c:	e30c000c 	jal	0x338c
    4d50:	00000000 	nop
    4d54:	8080023c 	lui	v0,0x8080
    4d58:	c4a84324 	addiu	v1,v0,-22332
    4d5c:	8080023c 	lui	v0,0x8080
    4d60:	a8b040ac 	sw	zero,-20312(v0)
    4d64:	3407c227 	addiu	v0,s8,1844
    4d68:	25304000 	move	a2,v0
    4d6c:	8080023c 	lui	v0,0x8080
    4d70:	a8b04524 	addiu	a1,v0,-20312
    4d74:	25206000 	move	a0,v1
    4d78:	2a0e000c 	jal	0x38a8
    4d7c:	00000000 	nop
    4d80:	8080023c 	lui	v0,0x8080
    4d84:	bca84324 	addiu	v1,v0,-22340
    4d88:	08020724 	li	a3,520
    4d8c:	08020624 	li	a2,520
    4d90:	8080023c 	lui	v0,0x8080
    4d94:	a8b04524 	addiu	a1,v0,-20312
    4d98:	25206000 	move	a0,v1
    4d9c:	f70d000c 	jal	0x37dc
    4da0:	00000000 	nop
    4da4:	f406c38f 	lw	v1,1780(s8)
    4da8:	0080023c 	lui	v0,0x8000
    4dac:	80180300 	sll	v1,v1,0x2
    4db0:	a0554224 	addiu	v0,v0,21920
    4db4:	21106200 	addu	v0,v1,v0
    4db8:	0000428c 	lw	v0,0(v0)
    4dbc:	6c00c78f 	lw	a3,108(s8)
    4dc0:	25304000 	move	a2,v0
    4dc4:	8080023c 	lui	v0,0x8080
    4dc8:	a8b04524 	addiu	a1,v0,-20312
    4dcc:	8080023c 	lui	v0,0x8080
    4dd0:	a8a84424 	addiu	a0,v0,-22360
    4dd4:	a20d000c 	jal	0x3688
    4dd8:	00000000 	nop
    4ddc:	f406c38f 	lw	v1,1780(s8)
    4de0:	8080023c 	lui	v0,0x8080
    4de4:	a8b0428c 	lw	v0,-20312(v0)
    4de8:	e406c427 	addiu	a0,s8,1764
    4dec:	25388000 	move	a3,a0
    4df0:	25304000 	move	a2,v0
    4df4:	8080023c 	lui	v0,0x8080
    4df8:	a8a84524 	addiu	a1,v0,-22360
    4dfc:	25206000 	move	a0,v1
    4e00:	870a000c 	jal	0x2a1c
    4e04:	00000000 	nop
    4e08:	29fe0010 	b	0x46b0
    4e0c:	00000000 	nop
    4e10:	f806c28f 	lw	v0,1784(s8)
    4e14:	2807c427 	addiu	a0,s8,1832
    4e18:	2407c327 	addiu	v1,s8,1828
    4e1c:	25308000 	move	a2,a0
    4e20:	25286000 	move	a1,v1
    4e24:	25204000 	move	a0,v0
    4e28:	3e0c000c 	jal	0x30f8
    4e2c:	00000000 	nop
    4e30:	08004010 	beqz	v0,0x4e54
    4e34:	00000000 	nop
    4e38:	2407c28f 	lw	v0,1828(s8)
    4e3c:	1cfe4014 	bnez	v0,0x46b0
    4e40:	00000000 	nop
    4e44:	f806c28f 	lw	v0,1784(s8)
    4e48:	2407c2af 	sw	v0,1828(s8)
    4e4c:	18fe0010 	b	0x46b0
    4e50:	00000000 	nop
    4e54:	6c00c58f 	lw	a1,108(s8)
    4e58:	0080023c 	lui	v0,0x8000
    4e5c:	f4214424 	addiu	a0,v0,8692
    4e60:	e30c000c 	jal	0x338c
    4e64:	00000000 	nop
    4e68:	11fe0010 	b	0x46b0
    4e6c:	00000000 	nop
    4e70:	00000000 	nop
    4e74:	0efe0010 	b	0x46b0
    4e78:	00000000 	nop
    4e7c:	25e8c003 	move	sp,s8
    4e80:	740abf8f 	lw	ra,2676(sp)
    4e84:	700abe8f 	lw	s8,2672(sp)
    4e88:	6c0ab18f 	lw	s1,2668(sp)
    4e8c:	680ab08f 	lw	s0,2664(sp)
    4e90:	780abd27 	addiu	sp,sp,2680
    4e94:	0800e003 	jr	ra
    4e98:	00000000 	nop
    4e9c:	b0ffbd27 	addiu	sp,sp,-80
    4ea0:	4c00beaf 	sw	s8,76(sp)
    4ea4:	25f0a003 	move	s8,sp
    4ea8:	5000c4af 	sw	a0,80(s8)
    4eac:	5400c5af 	sw	a1,84(s8)
    4eb0:	5800c6af 	sw	a2,88(s8)
    4eb4:	5000c28f 	lw	v0,80(s8)
    4eb8:	00004290 	lbu	v0,0(v0)
    4ebc:	25184000 	move	v1,v0
    4ec0:	5400c28f 	lw	v0,84(s8)
    4ec4:	12004224 	addiu	v0,v0,18
    4ec8:	2b104300 	sltu	v0,v0,v1
    4ecc:	04004010 	beqz	v0,0x4ee0
    4ed0:	00000000 	nop
    4ed4:	25100000 	move	v0,zero
    4ed8:	fb000010 	b	0x52c8
    4edc:	00000000 	nop
    4ee0:	5000c28f 	lw	v0,80(s8)
    4ee4:	1c004224 	addiu	v0,v0,28
    4ee8:	00004290 	lbu	v0,0(v0)
    4eec:	1c00c2af 	sw	v0,28(s8)
    4ef0:	5000c28f 	lw	v0,80(s8)
    4ef4:	1d004224 	addiu	v0,v0,29
    4ef8:	00004290 	lbu	v0,0(v0)
    4efc:	2000c2af 	sw	v0,32(s8)
    4f00:	5000c28f 	lw	v0,80(s8)
    4f04:	1e004224 	addiu	v0,v0,30
    4f08:	00004290 	lbu	v0,0(v0)
    4f0c:	00120200 	sll	v0,v0,0x8
    4f10:	5000c38f 	lw	v1,80(s8)
    4f14:	1f006324 	addiu	v1,v1,31
    4f18:	00006390 	lbu	v1,0(v1)
    4f1c:	26104300 	xor	v0,v0,v1
    4f20:	2400c2af 	sw	v0,36(s8)
    4f24:	1c00c38f 	lw	v1,28(s8)
    4f28:	01000224 	li	v0,1
    4f2c:	05006210 	beq	v1,v0,0x4f44
    4f30:	00000000 	nop
    4f34:	1c00c38f 	lw	v1,28(s8)
    4f38:	02000224 	li	v0,2
    4f3c:	08006214 	bne	v1,v0,0x4f60
    4f40:	00000000 	nop
    4f44:	2000c38f 	lw	v1,32(s8)
    4f48:	02000224 	li	v0,2
    4f4c:	04006214 	bne	v1,v0,0x4f60
    4f50:	00000000 	nop
    4f54:	2400c28f 	lw	v0,36(s8)
    4f58:	04004010 	beqz	v0,0x4f6c
    4f5c:	00000000 	nop
    4f60:	25100000 	move	v0,zero
    4f64:	d8000010 	b	0x52c8
    4f68:	00000000 	nop
    4f6c:	0000c0af 	sw	zero,0(s8)
    4f70:	20000224 	li	v0,32
    4f74:	0400c2af 	sw	v0,4(s8)
    4f78:	0400c28f 	lw	v0,4(s8)
    4f7c:	5400c38f 	lw	v1,84(s8)
    4f80:	2b104300 	sltu	v0,v0,v1
    4f84:	c8004010 	beqz	v0,0x52a8
    4f88:	00000000 	nop
    4f8c:	0400c28f 	lw	v0,4(s8)
    4f90:	14004224 	addiu	v0,v0,20
    4f94:	25184000 	move	v1,v0
    4f98:	5400c28f 	lw	v0,84(s8)
    4f9c:	2b104300 	sltu	v0,v0,v1
    4fa0:	04004010 	beqz	v0,0x4fb4
    4fa4:	00000000 	nop
    4fa8:	25100000 	move	v0,zero
    4fac:	c6000010 	b	0x52c8
    4fb0:	00000000 	nop
    4fb4:	0400c28f 	lw	v0,4(s8)
    4fb8:	5000c38f 	lw	v1,80(s8)
    4fbc:	21106200 	addu	v0,v1,v0
    4fc0:	00004290 	lbu	v0,0(v0)
    4fc4:	00120200 	sll	v0,v0,0x8
    4fc8:	0400c38f 	lw	v1,4(s8)
    4fcc:	01006324 	addiu	v1,v1,1
    4fd0:	5000c48f 	lw	a0,80(s8)
    4fd4:	21188300 	addu	v1,a0,v1
    4fd8:	00006390 	lbu	v1,0(v1)
    4fdc:	25104300 	or	v0,v0,v1
    4fe0:	2800c2af 	sw	v0,40(s8)
    4fe4:	0400c28f 	lw	v0,4(s8)
    4fe8:	02004224 	addiu	v0,v0,2
    4fec:	5000c38f 	lw	v1,80(s8)
    4ff0:	21106200 	addu	v0,v1,v0
    4ff4:	00004290 	lbu	v0,0(v0)
    4ff8:	00120200 	sll	v0,v0,0x8
    4ffc:	0400c38f 	lw	v1,4(s8)
    5000:	03006324 	addiu	v1,v1,3
    5004:	5000c48f 	lw	a0,80(s8)
    5008:	21188300 	addu	v1,a0,v1
    500c:	00006390 	lbu	v1,0(v1)
    5010:	25104300 	or	v0,v0,v1
    5014:	2c00c2af 	sw	v0,44(s8)
    5018:	2c00c28f 	lw	v0,44(s8)
    501c:	04004010 	beqz	v0,0x5030
    5020:	00000000 	nop
    5024:	25100000 	move	v0,zero
    5028:	a7000010 	b	0x52c8
    502c:	00000000 	nop
    5030:	1c00c38f 	lw	v1,28(s8)
    5034:	02000224 	li	v0,2
    5038:	08006214 	bne	v1,v0,0x505c
    503c:	00000000 	nop
    5040:	2800c38f 	lw	v1,40(s8)
    5044:	02000224 	li	v0,2
    5048:	04006210 	beq	v1,v0,0x505c
    504c:	00000000 	nop
    5050:	25100000 	move	v0,zero
    5054:	9c000010 	b	0x52c8
    5058:	00000000 	nop
    505c:	1c00c38f 	lw	v1,28(s8)
    5060:	01000224 	li	v0,1
    5064:	07006214 	bne	v1,v0,0x5084
    5068:	00000000 	nop
    506c:	2800c28f 	lw	v0,40(s8)
    5070:	04004010 	beqz	v0,0x5084
    5074:	00000000 	nop
    5078:	25100000 	move	v0,zero
    507c:	92000010 	b	0x52c8
    5080:	00000000 	nop
    5084:	0400c28f 	lw	v0,4(s8)
    5088:	04004224 	addiu	v0,v0,4
    508c:	0400c2af 	sw	v0,4(s8)
    5090:	3400c0af 	sw	zero,52(s8)
    5094:	3800c0af 	sw	zero,56(s8)
    5098:	3c00c0af 	sw	zero,60(s8)
    509c:	4000c0af 	sw	zero,64(s8)
    50a0:	0800c0af 	sw	zero,8(s8)
    50a4:	0800c28f 	lw	v0,8(s8)
    50a8:	04004228 	slti	v0,v0,4
    50ac:	5e004010 	beqz	v0,0x5228
    50b0:	00000000 	nop
    50b4:	0c00c0af 	sw	zero,12(s8)
    50b8:	1000c0af 	sw	zero,16(s8)
    50bc:	1000c28f 	lw	v0,16(s8)
    50c0:	04004228 	slti	v0,v0,4
    50c4:	22004010 	beqz	v0,0x5150
    50c8:	00000000 	nop
    50cc:	0c00c28f 	lw	v0,12(s8)
    50d0:	00120200 	sll	v0,v0,0x8
    50d4:	0400c38f 	lw	v1,4(s8)
    50d8:	5000c48f 	lw	a0,80(s8)
    50dc:	21188300 	addu	v1,a0,v1
    50e0:	00006390 	lbu	v1,0(v1)
    50e4:	25104300 	or	v0,v0,v1
    50e8:	0c00c2af 	sw	v0,12(s8)
    50ec:	0800c28f 	lw	v0,8(s8)
    50f0:	80100200 	sll	v0,v0,0x2
    50f4:	2110c203 	addu	v0,s8,v0
    50f8:	3400438c 	lw	v1,52(v0)
    50fc:	0400c28f 	lw	v0,4(s8)
    5100:	5000c48f 	lw	a0,80(s8)
    5104:	21108200 	addu	v0,a0,v0
    5108:	00004290 	lbu	v0,0(v0)
    510c:	25204000 	move	a0,v0
    5110:	1000c28f 	lw	v0,16(s8)
    5114:	c0100200 	sll	v0,v0,0x3
    5118:	04104400 	sllv	v0,a0,v0
    511c:	25186200 	or	v1,v1,v0
    5120:	0800c28f 	lw	v0,8(s8)
    5124:	80100200 	sll	v0,v0,0x2
    5128:	2110c203 	addu	v0,s8,v0
    512c:	340043ac 	sw	v1,52(v0)
    5130:	1000c28f 	lw	v0,16(s8)
    5134:	01004224 	addiu	v0,v0,1
    5138:	1000c2af 	sw	v0,16(s8)
    513c:	0400c28f 	lw	v0,4(s8)
    5140:	01004224 	addiu	v0,v0,1
    5144:	0400c2af 	sw	v0,4(s8)
    5148:	dcff0010 	b	0x50bc
    514c:	00000000 	nop
    5150:	0800c38f 	lw	v1,8(s8)
    5154:	01000224 	li	v0,1
    5158:	20006214 	bne	v1,v0,0x51dc
    515c:	00000000 	nop
    5160:	1400c0a3 	sb	zero,20(s8)
    5164:	1800c0af 	sw	zero,24(s8)
    5168:	1800c28f 	lw	v0,24(s8)
    516c:	20004228 	slti	v0,v0,32
    5170:	1a004010 	beqz	v0,0x51dc
    5174:	00000000 	nop
    5178:	0c00c28f 	lw	v0,12(s8)
    517c:	01004230 	andi	v0,v0,0x1
    5180:	3000c2af 	sw	v0,48(s8)
    5184:	0c00c28f 	lw	v0,12(s8)
    5188:	42100200 	srl	v0,v0,0x1
    518c:	0c00c2af 	sw	v0,12(s8)
    5190:	1400c293 	lbu	v0,20(s8)
    5194:	07004010 	beqz	v0,0x51b4
    5198:	00000000 	nop
    519c:	3000c28f 	lw	v0,48(s8)
    51a0:	09004014 	bnez	v0,0x51c8
    51a4:	00000000 	nop
    51a8:	25100000 	move	v0,zero
    51ac:	46000010 	b	0x52c8
    51b0:	00000000 	nop
    51b4:	3000c28f 	lw	v0,48(s8)
    51b8:	03004010 	beqz	v0,0x51c8
    51bc:	00000000 	nop
    51c0:	01000224 	li	v0,1
    51c4:	1400c2a3 	sb	v0,20(s8)
    51c8:	1800c28f 	lw	v0,24(s8)
    51cc:	01004224 	addiu	v0,v0,1
    51d0:	1800c2af 	sw	v0,24(s8)
    51d4:	e4ff0010 	b	0x5168
    51d8:	00000000 	nop
    51dc:	0800c38f 	lw	v1,8(s8)
    51e0:	03000224 	li	v0,3
    51e4:	0b006214 	bne	v1,v0,0x5214
    51e8:	00000000 	nop
    51ec:	0c00c28f 	lw	v0,12(s8)
    51f0:	05004010 	beqz	v0,0x5208
    51f4:	00000000 	nop
    51f8:	0c00c28f 	lw	v0,12(s8)
    51fc:	1100422c 	sltiu	v0,v0,17
    5200:	04004014 	bnez	v0,0x5214
    5204:	00000000 	nop
    5208:	25100000 	move	v0,zero
    520c:	2e000010 	b	0x52c8
    5210:	00000000 	nop
    5214:	0800c28f 	lw	v0,8(s8)
    5218:	01004224 	addiu	v0,v0,1
    521c:	0800c2af 	sw	v0,8(s8)
    5220:	a0ff0010 	b	0x50a4
    5224:	00000000 	nop
    5228:	3400c38f 	lw	v1,52(s8)
    522c:	5800c48f 	lw	a0,88(s8)
    5230:	0000c28f 	lw	v0,0(s8)
    5234:	00110200 	sll	v0,v0,0x4
    5238:	21108200 	addu	v0,a0,v0
    523c:	080043ac 	sw	v1,8(v0)
    5240:	3800c38f 	lw	v1,56(s8)
    5244:	5800c48f 	lw	a0,88(s8)
    5248:	0000c28f 	lw	v0,0(s8)
    524c:	00110200 	sll	v0,v0,0x4
    5250:	21108200 	addu	v0,a0,v0
    5254:	0c0043ac 	sw	v1,12(v0)
    5258:	3c00c38f 	lw	v1,60(s8)
    525c:	5800c48f 	lw	a0,88(s8)
    5260:	0000c28f 	lw	v0,0(s8)
    5264:	01004224 	addiu	v0,v0,1
    5268:	00110200 	sll	v0,v0,0x4
    526c:	21108200 	addu	v0,a0,v0
    5270:	000043ac 	sw	v1,0(v0)
    5274:	4000c28f 	lw	v0,64(s8)
    5278:	021e0200 	srl	v1,v0,0x18
    527c:	5800c48f 	lw	a0,88(s8)
    5280:	0000c28f 	lw	v0,0(s8)
    5284:	01004224 	addiu	v0,v0,1
    5288:	00110200 	sll	v0,v0,0x4
    528c:	21108200 	addu	v0,a0,v0
    5290:	040043ac 	sw	v1,4(v0)
    5294:	0000c28f 	lw	v0,0(s8)
    5298:	01004224 	addiu	v0,v0,1
    529c:	0000c2af 	sw	v0,0(s8)
    52a0:	35ff0010 	b	0x4f78
    52a4:	00000000 	nop
    52a8:	0000c38f 	lw	v1,0(s8)
    52ac:	5800c28f 	lw	v0,88(s8)
    52b0:	000043ac 	sw	v1,0(v0)
    52b4:	1c00c28f 	lw	v0,28(s8)
    52b8:	ff004330 	andi	v1,v0,0xff
    52bc:	5800c28f 	lw	v0,88(s8)
    52c0:	040043a0 	sb	v1,4(v0)
    52c4:	01000224 	li	v0,1
    52c8:	25e8c003 	move	sp,s8
    52cc:	4c00be8f 	lw	s8,76(sp)
    52d0:	5000bd27 	addiu	sp,sp,80
    52d4:	0800e003 	jr	ra
    52d8:	00000000 	nop
    52dc:	f8ffbd27 	addiu	sp,sp,-8
    52e0:	0400beaf 	sw	s8,4(sp)
    52e4:	25f0a003 	move	s8,sp
    52e8:	0800c4af 	sw	a0,8(s8)
    52ec:	2510a000 	move	v0,a1
    52f0:	0c00c2a3 	sb	v0,12(s8)
    52f4:	0800c28f 	lw	v0,8(s8)
    52f8:	0000448c 	lw	a0,0(v0)
    52fc:	0800c28f 	lw	v0,8(s8)
    5300:	0400438c 	lw	v1,4(v0)
    5304:	0000628c 	lw	v0,0(v1)
    5308:	01004524 	addiu	a1,v0,1
    530c:	000065ac 	sw	a1,0(v1)
    5310:	21108200 	addu	v0,a0,v0
    5314:	0c00c393 	lbu	v1,12(s8)
    5318:	000043a0 	sb	v1,0(v0)
    531c:	00000000 	nop
    5320:	25e8c003 	move	sp,s8
    5324:	0400be8f 	lw	s8,4(sp)
    5328:	0800bd27 	addiu	sp,sp,8
    532c:	0800e003 	jr	ra
    5330:	00000000 	nop
    5334:	c0ffbd27 	addiu	sp,sp,-64
    5338:	3c00bfaf 	sw	ra,60(sp)
    533c:	3800beaf 	sw	s8,56(sp)
    5340:	25f0a003 	move	s8,sp
    5344:	4000c4af 	sw	a0,64(s8)
    5348:	4400c5af 	sw	a1,68(s8)
    534c:	1c00c0af 	sw	zero,28(s8)
    5350:	4400c28f 	lw	v0,68(s8)
    5354:	2000c2af 	sw	v0,32(s8)
    5358:	1c00c227 	addiu	v0,s8,28
    535c:	2400c2af 	sw	v0,36(s8)
    5360:	4000c28f 	lw	v0,64(s8)
    5364:	04004390 	lbu	v1,4(v0)
    5368:	2000c227 	addiu	v0,s8,32
    536c:	25286000 	move	a1,v1
    5370:	25204000 	move	a0,v0
    5374:	b714000c 	jal	0x52dc
    5378:	00000000 	nop
    537c:	2000c227 	addiu	v0,s8,32
    5380:	02000524 	li	a1,2
    5384:	25204000 	move	a0,v0
    5388:	b714000c 	jal	0x52dc
    538c:	00000000 	nop
    5390:	2000c227 	addiu	v0,s8,32
    5394:	25280000 	move	a1,zero
    5398:	25204000 	move	a0,v0
    539c:	b714000c 	jal	0x52dc
    53a0:	00000000 	nop
    53a4:	2000c227 	addiu	v0,s8,32
    53a8:	25280000 	move	a1,zero
    53ac:	25204000 	move	a0,v0
    53b0:	b714000c 	jal	0x52dc
    53b4:	00000000 	nop
    53b8:	1000c0af 	sw	zero,16(s8)
    53bc:	4000c28f 	lw	v0,64(s8)
    53c0:	0000438c 	lw	v1,0(v0)
    53c4:	1000c28f 	lw	v0,16(s8)
    53c8:	2b104300 	sltu	v0,v0,v1
    53cc:	67004010 	beqz	v0,0x556c
    53d0:	00000000 	nop
    53d4:	2000c227 	addiu	v0,s8,32
    53d8:	25280000 	move	a1,zero
    53dc:	25204000 	move	a0,v0
    53e0:	b714000c 	jal	0x52dc
    53e4:	00000000 	nop
    53e8:	4000c28f 	lw	v0,64(s8)
    53ec:	04004390 	lbu	v1,4(v0)
    53f0:	02000224 	li	v0,2
    53f4:	04006214 	bne	v1,v0,0x5408
    53f8:	00000000 	nop
    53fc:	02000224 	li	v0,2
    5400:	02000010 	b	0x540c
    5404:	00000000 	nop
    5408:	25100000 	move	v0,zero
    540c:	2000c327 	addiu	v1,s8,32
    5410:	25284000 	move	a1,v0
    5414:	25206000 	move	a0,v1
    5418:	b714000c 	jal	0x52dc
    541c:	00000000 	nop
    5420:	2000c227 	addiu	v0,s8,32
    5424:	25280000 	move	a1,zero
    5428:	25204000 	move	a0,v0
    542c:	b714000c 	jal	0x52dc
    5430:	00000000 	nop
    5434:	2000c227 	addiu	v0,s8,32
    5438:	25280000 	move	a1,zero
    543c:	25204000 	move	a0,v0
    5440:	b714000c 	jal	0x52dc
    5444:	00000000 	nop
    5448:	4000c38f 	lw	v1,64(s8)
    544c:	1000c28f 	lw	v0,16(s8)
    5450:	00110200 	sll	v0,v0,0x4
    5454:	21106200 	addu	v0,v1,v0
    5458:	0800428c 	lw	v0,8(v0)
    545c:	2800c2af 	sw	v0,40(s8)
    5460:	4000c38f 	lw	v1,64(s8)
    5464:	1000c28f 	lw	v0,16(s8)
    5468:	00110200 	sll	v0,v0,0x4
    546c:	21106200 	addu	v0,v1,v0
    5470:	0c00428c 	lw	v0,12(v0)
    5474:	2c00c2af 	sw	v0,44(s8)
    5478:	4000c38f 	lw	v1,64(s8)
    547c:	1000c28f 	lw	v0,16(s8)
    5480:	01004224 	addiu	v0,v0,1
    5484:	00110200 	sll	v0,v0,0x4
    5488:	21106200 	addu	v0,v1,v0
    548c:	0000428c 	lw	v0,0(v0)
    5490:	3000c2af 	sw	v0,48(s8)
    5494:	4000c38f 	lw	v1,64(s8)
    5498:	1000c28f 	lw	v0,16(s8)
    549c:	01004224 	addiu	v0,v0,1
    54a0:	00110200 	sll	v0,v0,0x4
    54a4:	21106200 	addu	v0,v1,v0
    54a8:	0400428c 	lw	v0,4(v0)
    54ac:	3400c2af 	sw	v0,52(s8)
    54b0:	1400c0af 	sw	zero,20(s8)
    54b4:	1400c28f 	lw	v0,20(s8)
    54b8:	04004228 	slti	v0,v0,4
    54bc:	26004010 	beqz	v0,0x5558
    54c0:	00000000 	nop
    54c4:	1800c0af 	sw	zero,24(s8)
    54c8:	1800c28f 	lw	v0,24(s8)
    54cc:	04004228 	slti	v0,v0,4
    54d0:	1c004010 	beqz	v0,0x5544
    54d4:	00000000 	nop
    54d8:	1400c28f 	lw	v0,20(s8)
    54dc:	80100200 	sll	v0,v0,0x2
    54e0:	1000c327 	addiu	v1,s8,16
    54e4:	21106200 	addu	v0,v1,v0
    54e8:	1800428c 	lw	v0,24(v0)
    54ec:	ff004330 	andi	v1,v0,0xff
    54f0:	2000c227 	addiu	v0,s8,32
    54f4:	25286000 	move	a1,v1
    54f8:	25204000 	move	a0,v0
    54fc:	b714000c 	jal	0x52dc
    5500:	00000000 	nop
    5504:	1400c28f 	lw	v0,20(s8)
    5508:	80100200 	sll	v0,v0,0x2
    550c:	1000c327 	addiu	v1,s8,16
    5510:	21106200 	addu	v0,v1,v0
    5514:	1800428c 	lw	v0,24(v0)
    5518:	021a0200 	srl	v1,v0,0x8
    551c:	1400c28f 	lw	v0,20(s8)
    5520:	80100200 	sll	v0,v0,0x2
    5524:	1000c427 	addiu	a0,s8,16
    5528:	21108200 	addu	v0,a0,v0
    552c:	180043ac 	sw	v1,24(v0)
    5530:	1800c28f 	lw	v0,24(s8)
    5534:	01004224 	addiu	v0,v0,1
    5538:	1800c2af 	sw	v0,24(s8)
    553c:	e2ff0010 	b	0x54c8
    5540:	00000000 	nop
    5544:	1400c28f 	lw	v0,20(s8)
    5548:	01004224 	addiu	v0,v0,1
    554c:	1400c2af 	sw	v0,20(s8)
    5550:	d8ff0010 	b	0x54b4
    5554:	00000000 	nop
    5558:	1000c28f 	lw	v0,16(s8)
    555c:	01004224 	addiu	v0,v0,1
    5560:	1000c2af 	sw	v0,16(s8)
    5564:	95ff0010 	b	0x53bc
    5568:	00000000 	nop
    556c:	1c00c28f 	lw	v0,28(s8)
    5570:	25e8c003 	move	sp,s8
    5574:	3c00bf8f 	lw	ra,60(sp)
    5578:	3800be8f 	lw	s8,56(sp)
    557c:	4000bd27 	addiu	sp,sp,64
    5580:	0800e003 	jr	ra
    5584:	00000000 	nop
