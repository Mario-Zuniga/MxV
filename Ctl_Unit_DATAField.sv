
module Ctl_Unit_DATAField

(
	//Inputs
	input clk,
	input reset,
	input RXINT,
	input VALIDCMD,
	input MAXREACH,
	input UNLOCKME,
	
	//Outputs
	output INITFLAG1,
	output INITFLAG2,
	output COUNTFLAG,
	output DONECOUNTFLAG,
	output CLEARFLAG,
	output LOCKEDFLAG,
	output UNLOCKPASTFLAG
	
);


/*  */
enum logic [3:0] {IDLE, INITWAIT1, CLEARI1, INIT1, INITWAIT2, CLEARI2, INIT2, COUNT, DONECOUNT, LOCKED} state;
/*  */
bit INITFLAG1_bit;
bit INITFLAG2_bit;
bit CLEARFLAG_bit;
bit LOCKEDFLAG_bit;
bit COUNTFLAG_bit;
bit DONECOUNTFLAG_bit;
bit UNLOCKPASTFLAG_bit;



/* Cycle to assign to the next state */
always_ff@(posedge clk, negedge reset) begin

	if(reset == 1'b0)
		state <= IDLE;
		
	else
	begin
		case(state)
			IDLE: 		if(VALIDCMD==1)	state <= INITWAIT1;
			INITWAIT1:	if(RXINT==1)		state <= CLEARI1;
			CLEARI1: 							state <= INIT1;
			INIT1:								state <= INITWAIT2;
			INITWAIT2:	if(RXINT==1)		state <= CLEARI2;
			CLEARI2:								state <= INIT2;
			INIT2: 								state <= COUNT;
			COUNT:		if(MAXREACH==1)	state <= DONECOUNT;
							else					state	<= INITWAIT1;
			DONECOUNT:							state	<=	LOCKED;
			LOCKED:		if(UNLOCKME==1)	state <= IDLE;
							
			
			default:		state <= IDLE;
				
		endcase
	end
end



always_comb begin

 INITFLAG1_bit=1'b0;
 INITFLAG2_bit=1'b0;
 COUNTFLAG_bit=1'b0;
 DONECOUNTFLAG_bit=1'b0;
 CLEARFLAG_bit=1'b0;
 LOCKEDFLAG_bit=1'b0;
 UNLOCKPASTFLAG_bit=1'b0;


	case(state) 
		
			IDLE:    UNLOCKPASTFLAG_bit=1'b1;
			CLEARI1: CLEARFLAG_bit=1'b1;	
			INIT1:	INITFLAG1_bit=1'b1;
			CLEARI2: CLEARFLAG_bit=1'b1;
			INIT2: 	INITFLAG2_bit=1'b1;
			COUNT:	COUNTFLAG_bit=1'b1;
			DONECOUNT: DONECOUNTFLAG_bit=1'b1;
			LOCKED: LOCKEDFLAG_bit=1'b1;
			
			default:	;
	endcase

end

assign INITFLAG1 = INITFLAG1_bit;
assign INITFLAG2 = INITFLAG2_bit;
assign COUNTFLAG =	COUNTFLAG_bit;
assign DONECOUNTFLAG = DONECOUNTFLAG_bit;
assign CLEARFLAG = CLEARFLAG_bit;
assign LOCKEDFLAG= LOCKEDFLAG_bit;
assign UNLOCKPASTFLAG= UNLOCKPASTFLAG_bit;

endmodule
