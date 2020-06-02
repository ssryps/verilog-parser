`define RstEnable       1'b1
`define RstDisable      1'b0
`define ZeroWord        32'h00000000
`define WriteEnable     1'b1
`define WriteDisable    1'b0
`define ReadEnable      1'b1
`define ReadDisable     1'b0
`define AluOpBus        7:0
`define AluSelBus       2:0
`define InstValid       1'b0
`define InstInvalid     1'b1
`define True_v          1'b1
`define False_v         1'b0
`define ChipEnable      1'b1
`define ChipDisable     1'b0
`define Stop 1'b1
`define NoStop 1'b0
`define InDelaySlot 1'b1
`define NotInDelaySlot 1'b0
`define Branch 1'b1
`define NotBranch 1'b0
`define InterruptAssert 1'b1
`define InterruptNotAssert 1'b0

`define EXE_ADDIU   6'b001001
`define EXE_ANDI    6'b001100
`define EXE_ORI     6'b001101
`define EXE_XORI    6'b001110
`define EXE_LUI     6'b001111

`define EXE_ADDU 6'b100001
`define EXE_AND  6'b100100
`define EXE_OR   6'b100101
`define EXE_XOR 6'b100110
`define EXE_NOR 6'b100111

`define EXE_SLL  6'b000000
`define EXE_SRL  6'b000010
`define EXE_SRA  6'b000011

`define EXE_J  6'b000010
`define EXE_JAL  6'b000011
`define EXE_JR  6'b001000

`define EXE_BEQ  6'b000100
`define EXE_BNE  6'b000101
`define EXE_BGTZ  6'b000111

`define EXE_LB  6'b100000
`define EXE_LH  6'b100001
`define EXE_LW  6'b100011
`define EXE_SB  6'b101000
`define EXE_SW  6'b101011

`define EXE_LWPC 6'b111011

`define EXE_NOP 6'b000000

`define EXE_SYSCALL 6'b001100
`define EXE_ERET 32'b01000010000000000000000000011000

// for R-inst
`define EXE_SPECIAL_INST 6'b000000

// delete if unuse
`define EXE_SYNC  6'b001111
`define EXE_PREF  6'b110011


//AluOp
`define EXE_ADDIU_OP   8'b00001001
`define EXE_AND_OP    8'b00001100
`define EXE_OR_OP     8'b00001101
`define EXE_XOR_OP    8'b00001110
`define EXE_LUI_OP     8'b00001111
`define EXE_ADDU_OP     8'b00100001
`define EXE_SLL_OP      8'b01111100
`define EXE_SRL_OP      8'b00000010
`define EXE_SRA_OP      8'b00000011

`define EXE_NOR_OP    8'b00100111

`define EXE_J_OP  8'b01001111
`define EXE_JAL_OP  8'b01010000
`define EXE_JR_OP  8'b00001000
`define EXE_BEQ_OP  8'b01010001
`define EXE_BGTZ_OP  8'b01010100
`define EXE_BNE_OP  8'b01010010

`define EXE_LB_OP  8'b11100000
`define EXE_LH_OP  8'b11100001
`define EXE_LW_OP  8'b11100011
`define EXE_SB_OP  8'b11101000
`define EXE_SW_OP  8'b11101011

`define EXE_MFC0_OP 8'b01011101
`define EXE_MTC0_OP 8'b01100000

`define EXE_SYSCALL_OP 8'b00001100
`define EXE_ERET_OP 8'b01101011

`define EXE_LWPC_OP 8'b11100111

`define EXE_NOP_OP     8'b00000000

//AluSel
`define EXE_RES_LOGIC       3'b001
`define EXE_RES_SHIFT       3'b010
`define EXE_RES_ARITHMETIC  3'b011
`define EXE_RES_JUMP_BRANCH 3'b100
`define EXE_RES_LOAD_STORE  3'b101
`define EXE_RES_MOVE        3'b110	
`define EXE_RES_NOP         3'b000


//Instruction ROM
`define InstAddrBus     31:0
`define InstBus         31:0
`define InstMemNum      131071
`define InstMemNumLog2  17

//Data RAM
`define DataAddrBus     31:0
`define DataBus         31:0
`define DataMemNum      131071  //128K words
`define DataMemNumLog2  17
`define ByteWidth       7:0

//Regfile
`define RegAddrBus      4:0
`define RegBus          31:0
`define RegWidth        32
`define DoubleRegWidth  64
`define DoubleRegBus    63:0
`define RegNum          32
`define RegNumLog2      5
`define NOPRegAddr      5'b00000

//CP0±H¦s¾¹¦a§}
`define CP0_REG_COUNT    5'b01001
`define CP0_REG_COMPARE    5'b01011
`define CP0_REG_STATUS    5'b01100
`define CP0_REG_CAUSE    5'b01101        // read-only
`define CP0_REG_EPC    5'b01110
`define CP0_REG_PrId    5'b01111         // read-only
`define CP0_REG_CONFIG    5'b10000       // read-only