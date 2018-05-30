
module Ctl_Unit_CMDField

(
	//Inputs
	input clk,
	input reset,
	input RXINT,
	input VALIDLENGTH,
	input [7:0] VALIDCMDVAL,
	input UNLOCKME_N_DATA,
	input UNLOCKME_PREPARE_RETR,
	
	//Outputs
	output INITFLAG1,
	output INITFLAG2,
	output VALIDNFLAG,
	output VALIDDATAFLAG,
	output VALIDPREPARFLAG,
	output VALIDRETRFLAG,
	output CLEARFLAG,
	output LOCKED_N_DATA_FLAG,
	output LOCKED_PREPARE_RETR_FLAG,
	output UNLOCKPASTFLAG
	
);


/*  */
enum logic [3:0] {IDLE, INITWAIT1, CLEARI1, INIT1, INITWAIT2, CLEARI2, INIT2, VALIDCMD, VALIDN, VALIDDATA, VALIDPREPARE, VALIDRETR, LOCKED_N_DATA,LOCKED_PREPARE_RETR} state;
/*  */
bit INITFLAG1_bit;
bit INITFLAG2_bit;
bit VALIDNFLAG_bit;
bit VALIDDATAFLAG_bit;
bit VALIDPREPARFLAG_bit;
bit VALIDRETRFLAG_bit;
bit CLEARFLAG_bit;
bit LOCKED_N_DATA_FLAG_bit;
bit LOCKED_PREPARE_RETR_FLAG_bit;
bit UNLOCKPASTFLAG_bit;



/* Cycle to assign to the next state */
always_ff@(posedge clk, negedge reset) begin

	if(reset == 1'b0)
		state <= IDLE;
		
	else
	begin
		case(state)
			IDLE: 		if(VALIDLENGTH==1)	state <= INITWAIT1;
			INITWAIT1:	if(RXINT==1)			state <= CLEARI1;
			CLEARI1: 								state <= INIT1;
			INIT1:									state <= INITWAIT2;
			INITWAIT2:	if(RXINT==1)			state <= CLEARI2;
			CLEARI2:									state <= INIT2;
			INIT2: 									state <= VALIDCMD;
			VALIDCMD:	begin
							if(VALIDCMDVAL==8'd1)				state <= VALIDN;
							else if(VALIDCMDVAL==8'd2)			state <= VALIDRETR;
							else if(VALIDCMDVAL==8'd3)			state <= VALIDPREPARE;
							else if(VALIDCMDVAL==8'd4)			state <= VALIDDATA;
							else 									state <= IDLE;
							end
			VALIDN:							   	state <= LOCKED_N_DATA;
			VALIDRETR:							   state <= LOCKED_PREPARE_RETR;
			VALIDPREPARE:							state <= LOCKED_PREPARE_RETR;
			VALIDDATA:							  	state <= LOCKED_N_DATA;
			LOCKED_N_DATA:				if(UNLOCKME_N_DATA==1)				state <= IDLE;
			LOCKED_PREPARE_RETR:		if(UNLOCKME_PREPARE_RETR==1)		state <= IDLE;
							
			
			default:		state <= IDLE;
				
		endcase
	end
end



always_comb begin

 INITFLAG1_bit=1'b0;
 INITFLAG2_bit=1'b0;
 VALIDNFLAG_bit=1'b0;
 VALIDDATAFLAG_bit=1'b0;
 VALIDPREPARFLAG_bit=1'b0;
 VALIDRETRFLAG_bit=1'b0;
 CLEARFLAG_bit=1'b0;
 LOCKED_N_DATA_FLAG_bit=1'b0;
 LOCKED_PREPARE_RETR_FLAG_bit=1'b0;
 UNLOCKPASTFLAG_bit =1'b0;


	case(state) 
			
			IDLE:				UNLOCKPASTFLAG_bit=1'b1;
			CLEARI1:			CLEARFLAG_bit=1'b1;	
			INIT1:			INITFLAG1_bit=1'b1;
			CLEARI2: 		CLEARFLAG_bit=1'b1;
			INIT2: 			INITFLAG2_bit=1'b1;
			VALIDN:			VALIDNFLAG_bit=1'b1;
			VALIDRETR:		VALIDRETRFLAG_bit=1'b1;
			VALIDPREPARE:	VALIDPREPARFLAG_bit=1'b1;
			VALIDDATA:		VALIDDATAFLAG_bit=1'b1;
			LOCKED_N_DATA: LOCKED_N_DATA_FLAG_bit=1'b1;
			LOCKED_PREPARE_RETR: LOCKED_PREPARE_RETR_FLAG_bit =1'b1;
			
			default:	;
	endcase

end

assign INITFLAG1 = 			INITFLAG1_bit;
assign INITFLAG2 = 			INITFLAG2_bit;
assign VALIDNFLAG = 			VALIDNFLAG_bit;
assign VALIDDATAFLAG =  	VALIDDATAFLAG_bit;
assign VALIDPREPARFLAG = 	VALIDPREPARFLAG_bit;
assign VALIDRETRFLAG =		VALIDRETRFLAG_bit;
assign CLEARFLAG = 			CLEARFLAG_bit;
assign LOCKED_N_DATA_FLAG= LOCKED_N_DATA_FLAG_bit;
assign LOCKED_PREPARE_RETR_FLAG=		LOCKED_PREPARE_RETR_FLAG_bit;
assign UNLOCKPASTFLAG=		 			UNLOCKPASTFLAG_bit;

endmodule
