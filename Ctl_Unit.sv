
module Ctl_Unit

(
	//Inputs
	input clk,
	input reset,
	input trans,
	input maxflag,
	
	//Outputs
	output frame,
	output datastate,
	output start,
	output parity
);


/*  */
enum logic [2:0] {IDLE, START, DATA, PARITY, STOP} state;
/*  */
bit frame_bit;
bit start_bit;
bit datastate_bit;
bit parity_bit;


/* Cycle to assign to the next state */
always_ff@(posedge clk, negedge reset) begin

	if(reset == 1'b0)
		state <= IDLE;
		
	else
	begin
		case(state)
			IDLE:				if(trans == 1'b1) 		state <= START;
			START:											state <= DATA;
			DATA:				if(maxflag == 1'b1)		state <= PARITY;
			PARITY:											state <= STOP;
			STOP:				if(trans == 1'b0) 		state <= IDLE;
		
			default:		state <= IDLE;
				
		endcase
	end
end



always_comb begin

	frame_bit = 1'b0;
	start_bit = 1'b0;
	datastate_bit = 1'b0;
	parity_bit = 1'b0;

	case(state) 
	
			IDLE:		begin
						frame_bit = 1'b1;	
						end	
			START:	begin
						start_bit = 1'b1;	
						frame_bit = 1'b0;
						end						
			DATA:		begin
						datastate_bit = 1'b1;	
						end		
			PARITY:	begin
						parity_bit = 1'b1;	
						end										
			STOP:		begin
						frame_bit = 1'b1;	
						end										
									
			
			default:	;
	endcase

end

assign frame = frame_bit;
assign datastate = datastate_bit;
assign start = start_bit;
assign parity = parity_bit;

endmodule
