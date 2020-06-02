`ifdef ex.v
`else
 `define ex.v
 
 `include "defines.v"

module ex(

	  input wire 		   rst,
      
      input wire [`RegBus]  inst_i --in_signal,
	  input wire [`AluOpBus]   aluop_i --in_signal,
	  input wire [`AluSelBus]  alusel_i --in_signal,
	  input wire [`RegBus] 	   reg1_i --in_signal,
	  input wire [`RegBus] 	   reg2_i --in_signal,
	  input wire [`RegAddrBus] wd_i --in_signal,
	  input wire 		   wreg_i --in_signal,
	  input wire[31:0]              excepttype_i --in_signal,
	  input wire[`RegBus]          current_inst_address_i --in_signal,

	input wire[`RegBus]           link_address_i --in_signal,
	input wire                    is_in_delayslot_i --in_signal,
	
    input wire                    mem_cp0_reg_we --back this.mem,
	input wire[4:0]               mem_cp0_reg_write_addr --back this.mem,
	input wire[`RegBus]           mem_cp0_reg_data --back this.mem,
	
	input wire                    wb_cp0_reg_we --back this.mem,
	input wire[4:0]               wb_cp0_reg_write_addr --back this.mem,
	input wire[`RegBus]           wb_cp0_reg_data --back this.mem,
	
	input wire[`RegBus]           cp0_reg_data_i,
	output reg[4:0]               cp0_reg_read_addr_o,
	
	output reg                    cp0_reg_we_o,
	output reg[4:0]               cp0_reg_write_addr_o,
	output reg[`RegBus]           cp0_reg_data_o,
	
	  output reg [`RegAddrBus] wd_o,
	  output reg 		   wreg_o,
	  output reg [`RegBus] 	   wdata_o, 
	  //这几个输出接口时为加载、存储指令用的
	  output wire [`AluOpBus]   aluop_o,
	  output wire [`RegBus]     mem_addr_o,
	  output wire [`RegBus]    reg2_o,
	  
	  output wire                   is_load_o, 
//	  output reg                   uart_ce_o,
	  
	  output wire[31:0]             excepttype_o,
	  output wire                   is_in_delayslot_o,
	  output wire[`RegBus]          current_inst_address_o,
	
	  output reg stallreq
); --this.ex
   
   reg [`RegBus] 		   logicout;
   reg [`RegBus]           arithout;
   reg [`RegBus]           shiftres;
   reg[`RegBus]             moveres;

    assign aluop_o = aluop_i;
    assign mem_addr_o = (aluop_i == `EXE_LWPC_OP) ? reg1_i + {{11{inst_i[18]}}, inst_i[18:0], 2'b00} : reg1_i + {{16{inst_i[15]}},inst_i[15:0]};
    assign reg2_o = reg2_i;
    assign excepttype_o = {excepttype_i[31:12],2'b00,excepttype_i[9:8],8'h00};
    assign is_in_delayslot_o = is_in_delayslot_i;
	assign current_inst_address_o = current_inst_address_i;
	
	assign is_load_o = ((aluop_i == `EXE_LB_OP) ||  (aluop_i == `EXE_LH_OP) || (aluop_i == `EXE_LW_OP) || (aluop_i == `EXE_LWPC_OP));
	
//always @ (*) begin
//    if (rst == `RstEnable) 
//	   uart_ce_o <= 1'b0;
//    else
//        if (is_load_o && mem_addr_o >= 32'hbfd003f8 && mem_addr_o <= 32'hbfd003fc) 
//            uart_ce_o <= 1'b1;
//        else
//            uart_ce_o <= 1'b0;
//end

always @ (*) begin
    stallreq = `NoStop;
end
  
   always @ (*)
     begin
	   if (rst == `RstEnable) logicout <= `ZeroWord;
	   else
	   begin
	     case (aluop_i)
	       `EXE_OR_OP: logicout <= reg1_i | reg2_i;
	       `EXE_ADDIU_OP: arithout <= reg1_i + reg2_i;
	       `EXE_ADDU_OP: arithout <= reg1_i + reg2_i;
	       `EXE_AND_OP: logicout <= reg1_i & reg2_i;
	       `EXE_XOR_OP: logicout <= reg1_i ^ reg2_i;
	       `EXE_NOR_OP: logicout <= ~(reg1_i | reg2_i);
	       default: logicout <= `ZeroWord;
	     endcase // case (aluop_i)
	   end // else: !if(rst == `RstEnable)
     end // always @ (*)
    
   always @ (*) begin
		if(rst == `RstEnable) begin
			shiftres <= `ZeroWord;
		end else begin
			case (aluop_i)
				`EXE_SLL_OP:begin
					shiftres <= reg2_i << reg1_i[4:0] ;
				end
				`EXE_SRL_OP:begin
					shiftres <= reg2_i >> reg1_i[4:0];
				end
				`EXE_SRA_OP:begin
					shiftres <= ({32{reg2_i[31]}} << (6'd32-{1'b0, reg1_i[4:0]})) | reg2_i >> reg1_i[4:0];
				end
				default:begin
					shiftres <= `ZeroWord;
				end
			endcase
		end    // else
	end      //always
	
    always @ (*) begin
        if(rst == `RstEnable) begin
            moveres <= `ZeroWord;
        end else begin
            moveres <= `ZeroWord;
            case (aluop_i)
               `EXE_MFC0_OP: begin
                    cp0_reg_read_addr_o <= inst_i[15:11];
                    moveres <= cp0_reg_data_i;
                    if( mem_cp0_reg_we == `WriteEnable && mem_cp0_reg_write_addr == inst_i[15:11] ) begin
                        moveres <= mem_cp0_reg_data;
                    end else if( wb_cp0_reg_we == `WriteEnable && wb_cp0_reg_write_addr == inst_i[15:11] ) begin
                        moveres <= wb_cp0_reg_data;
                    end
               end	   	
               default : begin
               end
           endcase
        end
    end	 
	
   always @ (*) begin
	wd_o <= wd_i;
	wreg_o <= wreg_i;
	case (alusel_i) 
	  `EXE_RES_LOGIC:	wdata_o <= logicout;
	  `EXE_RES_ARITHMETIC: wdata_o <= arithout;
	  `EXE_RES_SHIFT: wdata_o <= shiftres;
	  `EXE_RES_JUMP_BRANCH: wdata_o <= link_address_i;
	  `EXE_RES_MOVE: wdata_o <= moveres;
	  default: wdata_o <= `ZeroWord;
	endcase // case (alusel_i)
   end // always @ (*)
   
   always @ (*) begin
		if(rst == `RstEnable) begin
			cp0_reg_write_addr_o <= 5'b00000;
			cp0_reg_we_o <= `WriteDisable;
			cp0_reg_data_o <= `ZeroWord;
		end else if(aluop_i == `EXE_MTC0_OP) begin
			cp0_reg_write_addr_o <= inst_i[15:11];
			cp0_reg_we_o <= `WriteEnable;
			cp0_reg_data_o <= reg1_i;
	  end else begin
			cp0_reg_write_addr_o <= 5'b00000;
			cp0_reg_we_o <= `WriteDisable;
			cp0_reg_data_o <= `ZeroWord;
		end				
	end
endmodule // ex

`endif