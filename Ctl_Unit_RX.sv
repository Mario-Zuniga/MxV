
module Ctl_Unit_RX

(
	//Inputs
	input clk,
	input reset,
	input frame,
	input maxflag,
	
	//Outputs
	output datastate,
	output parity,
	output stop,
	output waitstate
);


/*  */
enum logic [4:0] {IDLE, WAIT1, WAIT2, WAIT3, WAIT4, WAITDATA1, WAITDATA2, WAITDATA3, WAITDATA4, WAITDATA5, WAITDATA6, WAITDATA7, WAITDATA8, WAITPARITY, WAITSTOP, DATA1, DATA2,DATA3, DATA4, DATA5, DATA6, DATA7, DATA8, PARITY, STOP} state;
/*  */
bit datastate_bit;
bit parity_bit;
bit stop_bit;
bit waitstate_bit;

/* Cycle to assign to the next state */
always_ff@(posedge clk, negedge reset) begin

	if(reset == 1'b0)
		state <= IDLE;
		
	else
	begin
		case(state)
			IDLE:				if(frame == 1'b0) 		state <= WAIT1;
			WAIT1:                                 state <= WAIT2;
			WAIT2:											state	<= WAIT3;
			WAIT3:											state <= WAIT4;
			WAIT4:											state <= WAITDATA1;
			WAITDATA1:		if(maxflag == 1'b1)		state <= DATA1;
			DATA1:											state <= WAITDATA2;
			WAITDATA2:		if(maxflag == 1'b1)		state <= DATA2;
			DATA2:											state <= WAITDATA3;
			WAITDATA3:		if(maxflag == 1'b1)		state <= DATA3;
			DATA3:											state <= WAITDATA4;
			WAITDATA4:		if(maxflag == 1'b1)		state <= DATA4;
			DATA4:											state <= WAITDATA5;
			WAITDATA5:		if(maxflag == 1'b1)		state <= DATA5;
			DATA5:											state <= WAITDATA6;
			WAITDATA6:		if(maxflag == 1'b1)		state <= DATA6;
			DATA6:											state <= WAITDATA7;
			WAITDATA7:		if(maxflag == 1'b1)		state <= DATA7;
			DATA7:											state <= WAITDATA8;
			WAITDATA8:		if(maxflag == 1'b1)		state <= DATA8;
			DATA8:											state <= WAITPARITY;
			WAITPARITY:		if(maxflag == 1'b1)		state <= PARITY;
			PARITY:											state <= WAITSTOP;
			WAITSTOP:		if(maxflag == 1'b1)		state <= STOP;
			STOP:												state <= IDLE;
			
			
			default:		state <= IDLE;
				
		endcase
	end
end



always_comb begin


	datastate_bit = 1'b0;
	parity_bit = 1'b0;
	stop_bit = 1'b0;
	waitstate_bit = 1'b0;

	case(state) 
			
														
			WAITDATA1:	waitstate_bit = 1'b1;		
			DATA1:		datastate_bit = 1'b1;												
			WAITDATA2:	waitstate_bit = 1'b1;		
			DATA2:		datastate_bit = 1'b1;										
			WAITDATA3:	waitstate_bit = 1'b1;		
			DATA3:		datastate_bit = 1'b1;												
			WAITDATA4:	waitstate_bit = 1'b1;		
			DATA4:		datastate_bit = 1'b1;												
			WAITDATA5:	waitstate_bit = 1'b1;		
			DATA5:		datastate_bit = 1'b1;												
			WAITDATA6:	waitstate_bit = 1'b1;		
			DATA6:		datastate_bit = 1'b1;											
			WAITDATA7:	waitstate_bit = 1'b1;		
			DATA7:		datastate_bit = 1'b1;												
			WAITDATA8:	waitstate_bit = 1'b1;		
			DATA8:		datastate_bit = 1'b1;											
			WAITPARITY:	waitstate_bit = 1'b1;		
			PARITY:		parity_bit = 1'b1;										
			WAITSTOP:	waitstate_bit = 1'b1;		
			STOP:			stop_bit = 1'b1;										
			
			
			default:		;
			
	endcase

end

assign datastate = datastate_bit;
assign parity = parity_bit;
assign stop = stop_bit;
assign waitstate = waitstate_bit;

endmodule
