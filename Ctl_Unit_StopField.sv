
module Ctl_Unit_StopField

(
	//Inputs
	input clk,
	input reset,
	input RXINT,
	input VALIDOP,
	input VALIDSTOP,
	
	//Outputs
	output INITFLAG1,
	output INITFLAG2,
	output VALIDSTOPFLAG,
	output CLEARFLAG,
	output UNLOCKPASTFLAG
	
);


/*  */
enum logic [3:0] {IDLE, INITWAIT1, CLEARI1, INIT1, INITWAIT2, CLEARI2, INIT2, VALIDINIT, ISVALID} state;
/*  */
bit INITFLAG1_bit;
bit INITFLAG2_bit;
bit VALIDSTOPFLAG_bit;
bit CLEARFLAG_bit;
bit UNLOCKPASTFLAG_bit;



/* Cycle to assign to the next state */
always_ff@(posedge clk, negedge reset) begin

	if(reset == 1'b0)
		state <= IDLE;
		
	else
	begin
		case(state)
			IDLE:			if(VALIDOP==1)		state <= INITWAIT1;
			INITWAIT1:	if(RXINT==1)		state <= CLEARI1;
			CLEARI1: 							state <= INIT1;
			INIT1:								state <= INITWAIT2;
			INITWAIT2:	if(RXINT==1)		state <= CLEARI2;
			CLEARI2:								state <= INIT2;
			INIT2: 								state <= VALIDINIT;
			VALIDINIT:	begin
							if(VALIDSTOP==1)	state <= ISVALID;
							else					state <= IDLE;
							end
			ISVALID:							   state <= IDLE;
							
			
			default:		state <= IDLE;
				
		endcase
	end
end



always_comb begin

 INITFLAG1_bit=1'b0;
 INITFLAG2_bit=1'b0;
 VALIDSTOPFLAG_bit=1'b0;
 CLEARFLAG_bit=1'b0;
 UNLOCKPASTFLAG_bit=1'b0;


	case(state) 
			
			IDLE:		UNLOCKPASTFLAG_bit=1'b1;
			CLEARI1: CLEARFLAG_bit=1'b1;	
			INIT1:	INITFLAG1_bit=1'b1;
			CLEARI2: CLEARFLAG_bit=1'b1;
			INIT2: 	INITFLAG2_bit=1'b1;
			ISVALID:	VALIDSTOPFLAG_bit=1'b1;
			
			default:	;
	endcase

end

assign INITFLAG1 = INITFLAG1_bit;
assign INITFLAG2 = INITFLAG2_bit;
assign VALIDSTOPFLAG = VALIDSTOPFLAG_bit;
assign CLEARFLAG = CLEARFLAG_bit;
assign UNLOCKPASTFLAG= UNLOCKPASTFLAG_bit;

endmodule
