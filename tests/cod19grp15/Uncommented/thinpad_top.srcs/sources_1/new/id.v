`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.11.2019 02:08:18
// Design Name: 
// Module Name: id
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`ifdef id.v
`else
`define id.v

`include "defines.v"

module id(
    input wire 		         rst,
    input wire [`InstAddrBus]   pc_i,
    input wire [`InstBus]      inst_i,

    input wire [`RegBus] 	    reg1_data_i,
    input wire [`RegBus] 	    reg2_data_i,

    input wire                is_in_delayslot_i,
	
    // forward unit
    input wire                      ex_wreg_i,
    input wire[`RegBus]             ex_wdata_i,
    input wire[`RegAddrBus]             ex_wd_i,
	
    input wire                     mem_wreg_i,
	input wire[`RegBus]            mem_wdata_i,
	input wire[`RegAddrBus]        mem_wd_i,
	
	input wire[`AluOpBus]      ex_aluop_i,
    
	  output reg 		    reg1_read_o,
	  output reg 		    reg2_read_o, 
	  output reg [`RegAddrBus]  reg1_addr_o,
	  output reg [`RegAddrBus]  reg2_addr_o, 

	  output reg [`AluOpBus]    aluop_o,
	  output reg [`AluSelBus]   alusel_o,
	  output reg [`RegBus] 	    reg1_o,
	  output reg [`RegBus] 	    reg2_o,
	  output reg [`RegAddrBus]  wd_o,
	  output reg wreg_o, 
	  
	  output wire[`RegBus]     inst_o,
	  
	  output wire[31:0]             excepttype_o,
      output wire[`RegBus]          current_inst_address_o,
	  
	  output wire stallreq, 
	  
        output reg                    next_inst_in_delayslot_o,
        output reg                    branch_flag_o,
        output reg[`RegBus]            branch_target_address_o,       
        output reg[`RegBus]            link_addr_o,
        output reg                    is_in_delayslot_o
);

   wire [5:0] 			    op = inst_i[31:26];
   wire [4:0] 			    op2 = inst_i[10:6];
   wire [5:0] 			    op3 = inst_i[5:0];
   wire [4:0] 			    op4 = inst_i[20:16];
   reg [`RegBus] 		    imm;
   reg 				    instvalid;

   wire[`RegBus] pc_plus_8;
   wire[`RegBus] pc_plus_4;
   wire[`RegBus] imm_sll2_signedext;  
   
   reg excepttype_is_syscall;
   reg excepttype_is_eret;
   
   reg reg1_pc;
   
   reg stallreq_for_reg1_loadrelate;
   reg stallreq_for_reg2_loadrelate;
   
   wire pre_inst_is_load;
  
  assign pc_plus_8 = pc_i + 8;
  assign pc_plus_4 = pc_i + 4;
  assign imm_sll2_signedext = {{14{inst_i[15]}}, inst_i[15:0], 2'b00 }; 
  
  assign inst_o = inst_i;
  
  assign excepttype_o = {19'b0, excepttype_is_eret, 2'b0, instvalid, excepttype_is_syscall, 8'b0};
  assign current_inst_address_o = pc_i;
  assign stallreq = stallreq_for_reg1_loadrelate | stallreq_for_reg2_loadrelate;
  
  assign pre_inst_is_load = ((ex_aluop_i == `EXE_LB_OP) ||
                             (ex_aluop_i == `EXE_LW_OP)) ? 1'b1 : 1'b0;
                             
   
	
   always @ (*) begin
      if (rst == `RstEnable) begin
           aluop_o <= `EXE_NOP_OP;
           alusel_o <= `EXE_RES_NOP;
           wd_o <= `NOPRegAddr;
           wreg_o <= `WriteDisable;
           instvalid <= `InstValid;
           reg1_read_o <= 1'b0;
           reg2_read_o <= 1'b0;
           reg1_addr_o <= `NOPRegAddr;
           reg2_addr_o <= `NOPRegAddr;
           imm <= `ZeroWord;
           link_addr_o <= `ZeroWord;
		   branch_target_address_o <= `ZeroWord;
		   branch_flag_o <= `NotBranch;
		   next_inst_in_delayslot_o <= `NotInDelaySlot;
		   excepttype_is_syscall <= `False_v;
		   excepttype_is_eret <= `False_v;	
		   reg1_pc <= 1'b0;
	  end else begin
	   aluop_o <= `EXE_NOP_OP;
	   alusel_o <= `EXE_RES_NOP;
	   wd_o <= inst_i[15:11];
	   wreg_o <= `WriteDisable;
	   instvalid <= `InstInvalid;	   
	   reg1_read_o <= 1'b0;
	   reg2_read_o <= 1'b0;
	   reg1_addr_o <= inst_i[25:21];
	   reg2_addr_o <= inst_i[20:16];		
	   imm <= `ZeroWord;
	   link_addr_o <= `ZeroWord;
	   branch_target_address_o <= `ZeroWord;
	   branch_flag_o <= `NotBranch;
	   next_inst_in_delayslot_o <= `NotInDelaySlot;
	   excepttype_is_syscall <= `False_v;
	   excepttype_is_eret <= `False_v;	
	   reg1_pc <= 1'b0;
	   case (op)
	       `EXE_LWPC: begin
	           wreg_o <= `WriteEnable;		
		  		aluop_o <= `EXE_LWPC_OP;
		  		alusel_o <= `EXE_RES_LOAD_STORE; 
		  		reg1_read_o <= 1'b0;	
		  		reg2_read_o <= 1'b0;	  	
                wd_o <= inst_i[25:21]; 
                instvalid <= `InstValid;	
                reg1_pc <= 1'b1;
	       end
           `EXE_SPECIAL_INST:begin
                case (op2)
                    5'b00000:begin
                        case (op3)
                            `EXE_OR:begin
                                wreg_o <= `WriteEnable;		
                                aluop_o <= `EXE_OR_OP;
                                alusel_o <= `EXE_RES_LOGIC; 	
                                reg1_read_o <= 1'b1;	
                                reg2_read_o <= 1'b1;
                                instvalid <= `InstValid;
                            end  
                            `EXE_AND:begin
                                wreg_o <= `WriteEnable;		
                                aluop_o <= `EXE_AND_OP;
                                alusel_o <= `EXE_RES_LOGIC;	  
                                reg1_read_o <= 1'b1;	
                                reg2_read_o <= 1'b1;
                                instvalid <= `InstValid;	
                            end
                            `EXE_XOR:begin
                                wreg_o <= `WriteEnable;
                                aluop_o <= `EXE_XOR_OP;
                                alusel_o <= `EXE_RES_LOGIC;
                                reg1_read_o <= 1'b1;
                                reg2_read_o <= 1'b1;
                                instvalid <= `InstValid;
                            end  				
                            `EXE_NOR:begin
                                wreg_o <= `WriteEnable;
                                aluop_o <= `EXE_NOR_OP;
                                alusel_o <= `EXE_RES_LOGIC;
                                reg1_read_o <= 1'b1;
                                reg2_read_o <= 1'b1;
                                instvalid <= `InstValid;	
                            end 
                            `EXE_JR: begin
                                wreg_o <= `WriteDisable;		
                                aluop_o <= `EXE_JR_OP;
		  						alusel_o <= `EXE_RES_JUMP_BRANCH;
		  						reg1_read_o <= 1'b1;	
		  						reg2_read_o <= 1'b0;
		  						link_addr_o <= `ZeroWord;
		  						branch_target_address_o <= reg1_o;
                                branch_flag_o <= `Branch;
                                next_inst_in_delayslot_o <= `InDelaySlot;
                                instvalid <= `InstValid;	
							end
							`EXE_ADDU: begin
							    wreg_o <= `WriteEnable;
							    aluop_o <= `EXE_ADDU_OP;
							    alusel_o <= `EXE_RES_ARITHMETIC;
							    reg1_read_o <= 1'b1;
							    reg2_read_o <= 1'b1;
							    instvalid <= `InstValid;
							end					  									
                            default:begin
                            end
                        endcase
                    end
                    default: begin
                    end
                endcase	
                case (op3)
                    `EXE_SYSCALL: begin
				        wreg_o <= `WriteDisable;		
				        aluop_o <= `EXE_SYSCALL_OP;
		  				alusel_o <= `EXE_RES_NOP;   
		  				reg1_read_o <= 1'b0;	
		  				reg2_read_o <= 1'b0;
		  				instvalid <= `InstValid; 
		  				excepttype_is_syscall<= `True_v;
		  			end
		  			default: begin
                    end
                endcase	
           end	
	       `EXE_ORI: begin
               wreg_o <= `WriteEnable;
               aluop_o <= `EXE_OR_OP;
               alusel_o <= `EXE_RES_LOGIC; 
               reg1_read_o <= 1'b1;	
               reg2_read_o <= 1'b0;	  	
               imm <= {16'h0, inst_i[15:0]};		
               wd_o <= inst_i[20:16];
               instvalid <= `InstValid;
	       end // case: `EXE_ORI
	       `EXE_ADDIU: begin
              wreg_o <= `WriteEnable;
              aluop_o <= `EXE_ADDIU_OP;
              alusel_o <= `EXE_RES_ARITHMETIC; 
              reg1_read_o <= 1'b1;	
              reg2_read_o <= 1'b0;	  	
              imm <= {{16{inst_i[15]}}, inst_i[15:0]};		
              wd_o <= inst_i[20:16];
              instvalid <= `InstValid;
	       end // case: `EXE_ADDIU
	       `EXE_ANDI: begin
              wreg_o <= `WriteEnable;
              aluop_o <= `EXE_AND_OP;
              alusel_o <= `EXE_RES_LOGIC; 
              reg1_read_o <= 1'b1;	
              reg2_read_o <= 1'b0;	  	
              imm <= {16'h0, inst_i[15:0]};		
              wd_o <= inst_i[20:16];
              instvalid <= `InstValid;
	       end // case: `EXE_ANDI
	       `EXE_XORI: begin
              wreg_o <= `WriteEnable;
              aluop_o <= `EXE_XOR_OP;
              alusel_o <= `EXE_RES_LOGIC; 
              reg1_read_o <= 1'b1;	
              reg2_read_o <= 1'b0;	  	
              imm <= {16'h0, inst_i[15:0]};		
              wd_o <= inst_i[20:16];
              instvalid <= `InstValid;
	       end // case: `EXE_XORI
	       `EXE_LUI: begin
		  	    wreg_o <= `WriteEnable;		
		  	    aluop_o <= `EXE_OR_OP;
		  		alusel_o <= `EXE_RES_LOGIC; 
		  		reg1_read_o <= 1'b1;	
		  		reg2_read_o <= 1'b0;	  	
                imm <= {inst_i[15:0], 16'h0};		
                wd_o <= inst_i[20:16];		  	
                instvalid <= `InstValid;	
			end	// EXE_LUI
			`EXE_J: begin
		  		wreg_o <= `WriteDisable;		
		  		aluop_o <= `EXE_J_OP;
		  		alusel_o <= `EXE_RES_JUMP_BRANCH; 
		  		reg1_read_o <= 1'b0;	
		  		reg2_read_o <= 1'b0;
		  		link_addr_o <= `ZeroWord;
			    branch_target_address_o <= {pc_plus_4[31:28], inst_i[25:0], 2'b00};
			    branch_flag_o <= `Branch;
			    next_inst_in_delayslot_o <= `InDelaySlot;		  	
			    instvalid <= `InstValid;	
            end // EXE_J
            `EXE_JAL:	 begin
		  		wreg_o <= `WriteEnable;		
		  		aluop_o <= `EXE_JAL_OP;
		  		alusel_o <= `EXE_RES_JUMP_BRANCH; 
		  		reg1_read_o <= 1'b0;	
		  		reg2_read_o <= 1'b0;
		  		wd_o <= 5'b11111;	
		  		link_addr_o <= pc_plus_8;
			    branch_target_address_o <= {pc_plus_4[31:28], inst_i[25:0], 2'b00};
			    branch_flag_o <= `Branch;
			    next_inst_in_delayslot_o <= `InDelaySlot;		  	
			    instvalid <= `InstValid;	
            end // EXE_JAL
            `EXE_BEQ: 	begin
		  		wreg_o <= `WriteDisable;		
		  		aluop_o <= `EXE_BEQ_OP;
		  		alusel_o <= `EXE_RES_JUMP_BRANCH; 
		  		reg1_read_o <= 1'b1;	
		  		reg2_read_o <= 1'b1;
		  		instvalid <= `InstValid;	
		  		if(reg1_o == reg2_o) begin
			    	branch_target_address_o <= pc_plus_4 + imm_sll2_signedext;
			    	branch_flag_o <= `Branch;
			    	next_inst_in_delayslot_o <= `InDelaySlot;		  	
			    end
            end // EXE_BEQ
            `EXE_BGTZ: begin
		  		wreg_o <= `WriteDisable;		
		  		aluop_o <= `EXE_BGTZ_OP;
		  		alusel_o <= `EXE_RES_JUMP_BRANCH; 
		  		reg1_read_o <= 1'b1;	
		  		reg2_read_o <= 1'b0;
		  		instvalid <= `InstValid;	
		  		if((reg1_o[31] == 1'b0) && (reg1_o != `ZeroWord)) begin
			    	branch_target_address_o <= pc_plus_4 + imm_sll2_signedext;
			    	branch_flag_o <= `Branch;
			    	next_inst_in_delayslot_o <= `InDelaySlot;		  	
			    end
            end // EXE_BGTZ
            `EXE_BNE:	 begin
		  		wreg_o <= `WriteDisable;		
		  		aluop_o <= `EXE_BNE_OP;
		  		alusel_o <= `EXE_RES_JUMP_BRANCH; 
		  		reg1_read_o <= 1'b1;	
		  		reg2_read_o <= 1'b1;
		  		instvalid <= `InstValid;	
		  		if(reg1_o != reg2_o) begin
			    	branch_target_address_o <= pc_plus_4 + imm_sll2_signedext;
			    	branch_flag_o <= `Branch;
			    	next_inst_in_delayslot_o <= `InDelaySlot;		  	
			    end
            end // EXE_BNE
            `EXE_LB: begin
		  		wreg_o <= `WriteEnable;		
		  		aluop_o <= `EXE_LB_OP;
		  		alusel_o <= `EXE_RES_LOAD_STORE; 
		  		reg1_read_o <= 1'b1;	
		  		reg2_read_o <= 1'b0;	  	
                wd_o <= inst_i[20:16]; 
                instvalid <= `InstValid;	
            end // EXE_LB
            `EXE_LH:	begin
		  		wreg_o <= `WriteEnable;		
		  		aluop_o <= `EXE_LH_OP;
		  		alusel_o <= `EXE_RES_LOAD_STORE; 
		  		reg1_read_o <= 1'b1;	
		  		reg2_read_o <= 1'b0;	  	
                wd_o <= inst_i[20:16]; 
                instvalid <= `InstValid;	
            end // EXE_LH
            `EXE_LW:	begin
		  		wreg_o <= `WriteEnable;		
		  		aluop_o <= `EXE_LW_OP;
		  		alusel_o <= `EXE_RES_LOAD_STORE; 
		  		reg1_read_o <= 1'b1;	
		  		reg2_read_o <= 1'b0;	  	
                wd_o <= inst_i[20:16]; 
                instvalid <= `InstValid;	
            end // EXE_LW
            `EXE_SB:	begin
		  		wreg_o <= `WriteDisable;		
		  		aluop_o <= `EXE_SB_OP;
		  		alusel_o <= `EXE_RES_LOAD_STORE; 
		  		reg1_read_o <= 1'b1;	
		  		reg2_read_o <= 1'b1; 
		  		instvalid <= `InstValid;	
            end // EXE_SB
            `EXE_SW:	begin
		  		wreg_o <= `WriteDisable;		
		  		aluop_o <= `EXE_SW_OP;
		  		alusel_o <= `EXE_RES_LOAD_STORE; 
		  		reg1_read_o <= 1'b1;	
		  		reg2_read_o <= 1'b1; 
		  		instvalid <= `InstValid;	
            end // EXE_SW
	     default: begin
	     end
	   endcase // case (op)
	   if (inst_i[31:21] == 11'b00000000000) begin     // SHIFT
            if (op3 == `EXE_SLL) begin  
                wreg_o <= `WriteEnable;		
                aluop_o <= `EXE_SLL_OP;
                alusel_o <= `EXE_RES_SHIFT; 
                reg1_read_o <= 1'b0;	
                reg2_read_o <= 1'b1;
                imm[4:0] <= inst_i[10:6];
                wd_o <= inst_i[15:11];
                instvalid <= `InstValid;	
            end else if ( op3 == `EXE_SRL ) begin
                wreg_o <= `WriteEnable;		
                aluop_o <= `EXE_SRL_OP;
                alusel_o <= `EXE_RES_SHIFT; 
                reg1_read_o <= 1'b0;
                reg2_read_o <= 1'b1;	  	
                imm[4:0] <= inst_i[10:6];
                wd_o <= inst_i[15:11];
                instvalid <= `InstValid;	
            end else if ( op3 == `EXE_SRA ) begin
                wreg_o <= `WriteEnable;		
                aluop_o <= `EXE_SRA_OP;
                alusel_o <= `EXE_RES_SHIFT;
                reg1_read_o <= 1'b0;
                reg2_read_o <= 1'b1;
                imm[4:0] <= inst_i[10:6];
                wd_o <= inst_i[15:11];
                instvalid <= `InstValid;	
            end
	   end else if (inst_i == `EXE_ERET) begin
			wreg_o <= `WriteDisable;
			aluop_o <= `EXE_ERET_OP;
		  	alusel_o <= `EXE_RES_NOP;
		  	reg1_read_o <= 1'b0;
		  	reg2_read_o <= 1'b0;
		  	instvalid <= `InstValid;
		  	excepttype_is_eret<= `True_v;				
	   end else if(inst_i[31:21] == 11'b01000000000 && inst_i[10:0] == 11'b00000000000) begin
	       // mfc0
            aluop_o <= `EXE_MFC0_OP;
            alusel_o <= `EXE_RES_MOVE;
            wd_o <= inst_i[20:16];
            wreg_o <= `WriteEnable;
            instvalid <= `InstValid;	   
            reg1_read_o <= 1'b0;
            reg2_read_o <= 1'b0;		
        end else if(inst_i[31:21] == 11'b01000000100 && inst_i[10:0] == 11'b00000000000) begin
            // mtc0
            aluop_o <= `EXE_MTC0_OP;
            alusel_o <= `EXE_RES_NOP;
            wreg_o <= `WriteDisable;
            instvalid <= `InstValid;	   
            reg1_read_o <= 1'b1;
            reg1_addr_o <= inst_i[20:16];
            reg2_read_o <= 1'b0;					
        end	  
	end //if
end // always @ (*)

//    `define GET_OPRAND(reg_o, reg_read_o, reg_data_i, reg_addr_o) \
//       always @ (*) begin \
//        if(rst == `RstEnable) begin \
//           reg_o <= `ZeroWord; \
//         end else if ((reg_read_o == 1'b1) && (ex_wreg_i == 1'b1) && (ex_wd_i == reg_addr_o)) begin \
//            reg_o <= ex_wdata_i; \
//		end else if((reg_read_o == 1'b1) && (mem_wreg_i == 1'b1) && (mem_wd_i == reg_addr_o)) begin \
//			reg_o <= mem_wdata_i;	 \
//	   end else if(reg_read_o == 1'b1) begin \
//            reg_o <= reg_data_i; \
//         end else if(reg_read_o == 1'b0) begin \
//           reg_o <= imm; \
//         end else begin \
//           reg_o <= `ZeroWord; \
//         end \
//         $display("reg_o=%b, reg_addr_o=%b", reg_o, reg_addr_o); \
//     end
   
//   `GET_OPRAND(reg1_o,reg1_read_o,reg1_data_i, reg1_addr_o)
//   `GET_OPRAND(reg2_o,reg2_read_o,reg2_data_i, reg2_addr_o)
	
    always @ (*) begin
        stallreq_for_reg1_loadrelate <= `NoStop;
        if (rst == `RstEnable)
            reg1_o <= `ZeroWord;
        else if (pre_inst_is_load == 1'b1 && ex_wd_i == reg1_addr_o && reg1_read_o == 1'b1) begin
            stallreq_for_reg1_loadrelate <= `Stop;
            reg1_o <= reg1_o;
        end else if ((reg1_read_o == 1'b1) && (ex_wreg_i == 1'b1) && (ex_wd_i == reg1_addr_o))
            reg1_o <= ex_wdata_i;
        else if ((reg1_read_o == 1'b1) && (mem_wreg_i == 1'b1) && (mem_wd_i == reg1_addr_o))
            reg1_o <= mem_wdata_i;
        else if (reg1_read_o == 1'b1)
            reg1_o <= reg1_data_i;
        else if (reg1_pc == 1'b1)
            reg1_o <= pc_i;
        else if (reg1_read_o == 1'b0)
            reg1_o <= imm;
        else
            reg1_o <= `ZeroWord;
    end

    always @ (*) begin
        stallreq_for_reg2_loadrelate <= `NoStop;
        if (rst == `RstEnable)
            reg2_o <= `ZeroWord;
        else if (pre_inst_is_load == 1'b1 && ex_wd_i == reg2_addr_o && reg2_read_o == 1'b1) begin
            stallreq_for_reg2_loadrelate <= `Stop;
            reg2_o <= reg2_o;
        end else if ((reg2_read_o == 1'b1) && (ex_wreg_i == 1'b1) && (ex_wd_i == reg2_addr_o))
            reg2_o <= ex_wdata_i;
        else if ((reg2_read_o == 1'b1) && (mem_wreg_i == 1'b1) && (mem_wd_i == reg2_addr_o))
            reg2_o <= mem_wdata_i;
        else if (reg2_read_o == 1'b1)
            reg2_o <= reg2_data_i;
        else if (reg2_read_o == 1'b0)
            reg2_o <= imm;
        else
            reg2_o <= `ZeroWord;
    end	
	
	always @ (*) begin
		if(rst == `RstEnable) begin
			is_in_delayslot_o <= `NotInDelaySlot;
		end else begin
		  is_in_delayslot_o <= is_in_delayslot_i;		
	  end
	end
endmodule // id

// --------------------------------------------------------------------------------
`endif
