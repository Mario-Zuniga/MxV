
module Ctl_Unit_SENDTX

(
	//Inputs
	input clk,
	input reset,
	input W1,
	input [7:0]ONES_B1,
	input [7:0]TENS_B1,
	input [7:0]HUNDREDS_B1,
	input [7:0]ONES_B2,
	input [7:0]TENS_B2,
	input [7:0]HUNDREDS_B2,
	input [7:0]ONES_B3,
	input [7:0]TENS_B3,
	input [7:0]HUNDREDS_B3,
	input [7:0]ONES_B4,
	input [7:0]TENS_B4,
	input [7:0]HUNDREDS_B4,
	input [7:0]ONES_B5,
	input [7:0]TENS_B5,
	input [7:0]HUNDREDS_B5,
	input [7:0]ONES_B6,
	input [7:0]TENS_B6,
	input [7:0]HUNDREDS_B6,
	input [7:0]ONES_B7,
	input [7:0]TENS_B7,
	input [7:0]HUNDREDS_B7,
	input [7:0]ONES_B8,
	input [7:0]TENS_B8,
	input [7:0]HUNDREDS_B8,
	input MAXFLAG,
	
	//Outputs
	output COUNT,
	output [7:0]DATATX,
	output TRANS
	
	
);


enum logic [5:0] {IDLE, SENDONE1, WAITONE1, SENDTENS1, WAITTENS1, SENDHUNDREDS1, WAITHUNDREDS1, SENDONE2, WAITONE2, SENDTENS2, WAITTENS2, SENDHUNDREDS2, WAITHUNDREDS2, SENDONE3, WAITONE3, SENDTENS3, WAITTENS3, SENDHUNDREDS3, WAITHUNDREDS3, SENDONE4, WAITONE4, SENDTENS4, WAITTENS4, SENDHUNDREDS4, WAITHUNDREDS4, SENDONE5, WAITONE5, SENDTENS5, WAITTENS5, SENDHUNDREDS5, WAITHUNDREDS5, SENDONE6, WAITONE6, SENDTENS6, WAITTENS6, SENDHUNDREDS6, WAITHUNDREDS6, SENDONE7, WAITONE7, SENDTENS7, WAITTENS7, SENDHUNDREDS7, WAITHUNDREDS7, SENDONE8, WAITONE8, SENDTENS8, WAITTENS8, SENDHUNDREDS8, WAITHUNDREDS8} state;
/*  */

bit COUNT_bit;
logic [7:0] DATATX_logic;
bit TRANS_bit;


/* Cycle to assign to the next 	 */
always_ff@(posedge clk, negedge reset) begin

	if(reset == 1'b0)
		state	<= IDLE;
		
	else
	begin
		case(state)

			IDLE: 			if(W1==1'b1)		state <= SENDONE1;
			
			SENDONE1:								state <= WAITONE1;
			WAITONE1:	   if(MAXFLAG==1'b1)	state <= SENDTENS1;
			SENDTENS1: 								state <= WAITTENS1;
			WAITTENS1:		if(MAXFLAG==1'b1)	state <= SENDHUNDREDS1;
			SENDHUNDREDS1:							state <= WAITHUNDREDS1;
			WAITHUNDREDS1:	if(MAXFLAG==1'b1) state <= SENDONE2;
			
			SENDONE2:								state <= WAITONE2;
			WAITONE2:	   if(MAXFLAG==1'b1)	state <= SENDTENS2;
			SENDTENS2: 								state <= WAITTENS2;
			WAITTENS2:		if(MAXFLAG==1'b1)	state <= SENDHUNDREDS2;
			SENDHUNDREDS2:							state <= WAITHUNDREDS2;
			WAITHUNDREDS2:	if(MAXFLAG==1'b1) state <= SENDONE3;
			
			SENDONE3:								state <= WAITONE3;
			WAITONE3:	   if(MAXFLAG==1'b1)	state <= SENDTENS3;
			SENDTENS3: 								state <= WAITTENS3;
			WAITTENS3:		if(MAXFLAG==1'b1)	state <= SENDHUNDREDS3;
			SENDHUNDREDS3:							state <= WAITHUNDREDS3;
			WAITHUNDREDS3:	if(MAXFLAG==1'b1) state <= SENDONE4;
			
			SENDONE4:								state <= WAITONE4;
			WAITONE4:	   if(MAXFLAG==1'b1)	state <= SENDTENS4;
			SENDTENS4: 								state <= WAITTENS4;
			WAITTENS4:		if(MAXFLAG==1'b1)	state <= SENDHUNDREDS4;
			SENDHUNDREDS4:							state <= WAITHUNDREDS4;
			WAITHUNDREDS4:	if(MAXFLAG==1'b1) state <= SENDONE5;
			
			SENDONE5:								state <= WAITONE5;
			WAITONE5:	   if(MAXFLAG==1'b1)	state <= SENDTENS5;
			SENDTENS5: 								state <= WAITTENS5;
			WAITTENS5:		if(MAXFLAG==1'b1)	state <= SENDHUNDREDS5;
			SENDHUNDREDS5:							state <= WAITHUNDREDS5;
			WAITHUNDREDS5:	if(MAXFLAG==1'b1) state <= SENDONE6;
			
			SENDONE6:								state <= WAITONE6;
			WAITONE6:	   if(MAXFLAG==1'b1)	state <= SENDTENS6;
			SENDTENS6: 								state <= WAITTENS6;
			WAITTENS6:		if(MAXFLAG==1'b1)	state <= SENDHUNDREDS6;
			SENDHUNDREDS6:							state <= WAITHUNDREDS6;
			WAITHUNDREDS6:	if(MAXFLAG==1'b1) state <= SENDONE7;
			
			SENDONE7:								state <= WAITONE7;
			WAITONE7:	   if(MAXFLAG==1'b1)	state <= SENDTENS7;
			SENDTENS7: 								state <= WAITTENS7;
			WAITTENS7:		if(MAXFLAG==1'b1)	state <= SENDHUNDREDS7;
			SENDHUNDREDS7:							state <= WAITHUNDREDS7;
			WAITHUNDREDS7:	if(MAXFLAG==1'b1) state <= SENDONE8;
			
			SENDONE8:								state <= WAITONE8;
			WAITONE8:	   if(MAXFLAG==1'b1)	state <= SENDTENS8;
			SENDTENS8: 								state <= WAITTENS8;
			WAITTENS8:		if(MAXFLAG==1'b1)	state <= SENDHUNDREDS8;
			SENDHUNDREDS8:							state <= WAITHUNDREDS8;
			WAITHUNDREDS8:	if(MAXFLAG==1'b1) state <= IDLE;
			
			
			default:		state <= IDLE;
				
		endcase
	end
end



always_comb begin

COUNT_bit = 1'b0;
DATATX_logic = 8'b0;
TRANS_bit = 1'b0;


	case(state) 
		
			SENDONE1:			begin
									DATATX_logic = ONES_B1;
									TRANS_bit	=	1'b1;
									end
									
			WAITONE1:			begin
									DATATX_logic = ONES_B1;
									COUNT_bit =	1'b1;
									end
									
			SENDTENS1:			begin
									DATATX_logic = TENS_B1;
									TRANS_bit	=	1'b1;
									end
									
			WAITTENS1:			begin
									DATATX_logic = TENS_B1;
									COUNT_bit =	1'b1;
									end
									
			SENDHUNDREDS1:		begin
									DATATX_logic = HUNDREDS_B1;
									TRANS_bit	=	1'b1;
									end
									
			WAITHUNDREDS1:		begin
									DATATX_logic = HUNDREDS_B1;
									COUNT_bit =	1'b1;
									end
									
			SENDONE2:			begin
									DATATX_logic = ONES_B2;
									TRANS_bit	=	1'b1;
									end
									
			WAITONE2:			begin
									DATATX_logic = ONES_B2;
									COUNT_bit =	1'b1;
									end
									
			SENDTENS2:			begin
									DATATX_logic = TENS_B2;
									TRANS_bit	=	1'b1;
									end
									
			WAITTENS2:			begin
									DATATX_logic = TENS_B2;
									COUNT_bit =	1'b1;
									end
									
			SENDHUNDREDS2:		begin
									DATATX_logic = HUNDREDS_B2;
									TRANS_bit	=	1'b1;
									end
									
			WAITHUNDREDS2:		begin
									DATATX_logic = HUNDREDS_B2;
									COUNT_bit =	1'b1;
									end
									
			SENDONE3:			begin
									DATATX_logic = ONES_B3;
									TRANS_bit	=	1'b1;
									end
									
			WAITONE3:			begin
									DATATX_logic = ONES_B3;
									COUNT_bit =	1'b1;
									end
									
			SENDTENS3:			begin
									DATATX_logic = TENS_B3;
									TRANS_bit	=	1'b1;
									end
									
			WAITTENS3:			begin
									DATATX_logic = TENS_B3;
									COUNT_bit =	1'b1;
									end
									
			SENDHUNDREDS3:		begin
									DATATX_logic = HUNDREDS_B3;
									TRANS_bit	=	1'b1;
									end
									
			WAITHUNDREDS3:		begin
									DATATX_logic = HUNDREDS_B3;
									COUNT_bit =	1'b1;
									end
									
			SENDONE4	:			begin
									DATATX_logic = ONES_B4;
									TRANS_bit	=	1'b1;
									end
									
			WAITONE4:			begin
									DATATX_logic = ONES_B4;
									COUNT_bit =	1'b1;
									end
									
			SENDTENS4:			begin
									DATATX_logic = TENS_B4;
									TRANS_bit	=	1'b1;
									end
									
			WAITTENS4:			begin
									DATATX_logic = TENS_B4;
									COUNT_bit =	1'b1;
									end
									
			SENDHUNDREDS4:		begin
									DATATX_logic = HUNDREDS_B4;
									TRANS_bit	=	1'b1;
									end
									
			WAITHUNDREDS4:		begin
									DATATX_logic = HUNDREDS_B4;
									COUNT_bit =	1'b1;
									end
									
								
			SENDONE5:			begin
									DATATX_logic = ONES_B5;
									TRANS_bit	=	1'b1;
									end
									
			WAITONE5:			begin
									DATATX_logic = ONES_B5;
									COUNT_bit =	1'b1;
									end
									
			SENDTENS5:			begin
									DATATX_logic = TENS_B5;
									TRANS_bit	=	1'b1;
									end
									
			WAITTENS5:			begin
									DATATX_logic = TENS_B5;
									COUNT_bit =	1'b1;
									end
									
			SENDHUNDREDS5:		begin
									DATATX_logic = HUNDREDS_B5;
									TRANS_bit	=	1'b1;
									end
									
			WAITHUNDREDS5:		begin
									DATATX_logic = HUNDREDS_B5;
									COUNT_bit =	1'b1;
									end
									
			SENDONE6:			begin
									DATATX_logic = ONES_B6;
									TRANS_bit	=	1'b1;
									end
									
			WAITONE6:			begin
									DATATX_logic = ONES_B6;
									COUNT_bit =	1'b1;
									end
									
			SENDTENS6:			begin
									DATATX_logic = TENS_B6;
									TRANS_bit	=	1'b1;
									end
									
			WAITTENS6:			begin
									DATATX_logic = TENS_B6;
									COUNT_bit =	1'b1;
									end
									
			SENDHUNDREDS6:		begin
									DATATX_logic = HUNDREDS_B6;
									TRANS_bit	=	1'b1;
									end
									
			WAITHUNDREDS6:		begin
									DATATX_logic = HUNDREDS_B6;
									COUNT_bit =	1'b1;
									end
									
			SENDONE7:			begin
									DATATX_logic = ONES_B7;
									TRANS_bit	=	1'b1;
									end
									
			WAITONE7:			begin
									DATATX_logic = ONES_B7;
									COUNT_bit =	1'b1;
									end
									
			SENDTENS7:			begin
									DATATX_logic = TENS_B7;
									TRANS_bit	=	1'b1;
									end
									
			WAITTENS7:			begin
									DATATX_logic = TENS_B7;
									COUNT_bit =	1'b1;
									end
									
			SENDHUNDREDS7:		begin
									DATATX_logic = HUNDREDS_B7;
									TRANS_bit	=	1'b1;
									end
									
			WAITHUNDREDS7:		begin
									DATATX_logic = HUNDREDS_B7;
									COUNT_bit =	1'b1;
									end
									
									
			SENDONE8:			begin
									DATATX_logic = ONES_B8;
									TRANS_bit	=	1'b1;
									end
									
			WAITONE8:			begin
									DATATX_logic = ONES_B8;
									COUNT_bit =	1'b1;
									end
									
			SENDTENS8:			begin
									DATATX_logic = TENS_B8;
									TRANS_bit	=	1'b1;
									end
									
			WAITTENS8:			begin
									DATATX_logic = TENS_B8;
									COUNT_bit =	1'b1;
									end
									
			SENDHUNDREDS8:		begin
									DATATX_logic = HUNDREDS_B8;
									TRANS_bit	=	1'b1;
									end
									
			WAITHUNDREDS8:		begin
									DATATX_logic = HUNDREDS_B8;
									COUNT_bit =	1'b1;
									end
								
			
			default:	;
	endcase

end

assign COUNT  = COUNT_bit;
assign DATATX  = DATATX_logic;
assign TRANS  = TRANS_bit;

endmodule
