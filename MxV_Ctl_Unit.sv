module MxV_Ctl_Unit
(
	// Inputs
	input clk,
	input reset,
	input start,
	input [7:0]N,
	
	// Outputs
	output sys_reset,
	output operation,
	output fifo,
	output reset_ope,
	output pop
);


enum logic [4:0] {IDLE, WAIT, WAIT2, WAIT3, WAIT4, WAIT5, RESET, ONE, TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE, TEN, ELEVEN, TWELVE, THIRTEEN, FOURTEEN, FIFTEEN, SIXTEEN, SEVENTEEN, FINAL, FINAL_SAFE, READY} state;

bit sys_reset_bit;
bit operation_bit;
bit pop_bit;
bit fifo_bit;
bit reset_ope_bit;

logic i = 0;

always_ff@(posedge clk, negedge reset) begin

	
	if(reset == 1'b0) begin
		state <= IDLE;
		i <= 1'b0;
	end
	else
	begin
		case(state)
			IDLE:	if(start ==1'b1) begin i <= 1'b0;			state <= WAIT; end
			WAIT:																								state <= WAIT2;
			WAIT2:																							state <= WAIT3;
			WAIT3:																							state <= WAIT4;
			WAIT4:																							state <= WAIT5;
			WAIT5:																							state <= RESET;
			RESET:																							state <= ONE;
			ONE:																								state <= TWO;
			TWO:			if(N == 8'd1) state <= SEVENTEEN;		else							state <= THREE;
			THREE:																							state <= FOUR;
			FOUR:			if(N == 8'd2) state <= SEVENTEEN;		else							state <= FIVE;
			FIVE:																								state <= SIX;
			SIX:			if(N == 8'd3) state <= SEVENTEEN;		else							state <= SEVEN;
			SEVEN:																							state <= EIGHT;
			EIGHT:		if(N == 8'd4) state <= SEVENTEEN;		else							state <= NINE;
			NINE:																								state <= TEN;
			TEN:			if(N == 8'd5) state <= SEVENTEEN;		else							state <= ELEVEN;
			ELEVEN:																							state <= TWELVE;
			TWELVE:		if(N == 8'd6) state <= SEVENTEEN;		else							state <= THIRTEEN;
			THIRTEEN:																						state <= FOURTEEN;
			FOURTEEN:	if(N == 8'd7) state <= SEVENTEEN;		else							state <= FIFTEEN;
			FIFTEEN:																							state <= SIXTEEN;
			SIXTEEN:																							state <= SEVENTEEN;
			SEVENTEEN:																						state <= FINAL;
			FINAL:		if(i == 1'b1) state <= FINAL_SAFE;	else begin i <= i + 1'b1;	state <= WAIT; end
			FINAL_SAFE:																						state <= READY;
			READY:		if(start == 1'b0)																state <= IDLE;
			default																							state <= IDLE;
			endcase
			
		end
			
end

/*
	fifo_bit -> 0 Turn of fifos 1 to 4
	fifo_bit -> 1 Turn of fifos 1 to 4
*/

always_comb begin

	sys_reset_bit = 1'b0;
   operation_bit = 1'b0;
   pop_bit = 1'b0;
	fifo_bit = 1'b0;
	reset_ope_bit = 1'b0;
	
	case(state)
	
		WAIT5:		begin
						reset_ope_bit = 1'b1;
						sys_reset_bit = 1'b0;
						operation_bit = 1'b0;
						pop_bit = 1'b0;
						if(i == 1'b0)
							fifo_bit = 1'b0;
						else
							fifo_bit = 1'b1;
						end
	
		RESET:		begin
						sys_reset_bit = 1'b1;
						operation_bit = 1'b0;
						pop_bit = 1'b0;
						if(i == 1'b0)
							fifo_bit = 1'b0;
						else
							fifo_bit = 1'b1;
						end
		
///////////////////////////////////		
		
		ONE:			begin
						sys_reset_bit = 1'b0;
						operation_bit = 1'b0;
						pop_bit = 1'b1;
						if(i == 1'b0)
							fifo_bit = 1'b0;
						else
							fifo_bit = 1'b1;
						end

///////////////////////////////////			
		
		TWO:			begin
						sys_reset_bit = 1'b0;
						operation_bit = 1'b0;
						pop_bit = 1'b0;
						if(i == 1'b0)
							fifo_bit = 1'b0;
						else
							fifo_bit = 1'b1;
						end
		
///////////////////////////////////	
		
		THREE:		begin
						sys_reset_bit = 1'b0;
						operation_bit = 1'b0;
						pop_bit = 1'b1;
						if(i == 1'b0)
							fifo_bit = 1'b0;
						else
							fifo_bit = 1'b1;
						end
		
///////////////////////////////////			
		
		FOUR:			begin
						sys_reset_bit = 1'b0;
						operation_bit = 1'b1;
						pop_bit = 1'b0;
						if(i == 1'b0)
							fifo_bit = 1'b0;
						else
							fifo_bit = 1'b1;
						end
		
///////////////////////////////////	
		
		FIVE:			begin
						sys_reset_bit = 1'b0;
						operation_bit = 1'b0;
						pop_bit = 1'b1;
						if(i == 1'b0)
							fifo_bit = 1'b0;
						else
							fifo_bit = 1'b1;
						end
		
///////////////////////////////////	
		
		SIX:			begin
						sys_reset_bit = 1'b0;
						operation_bit = 1'b1;
						pop_bit = 1'b0;
						if(i == 1'b0)
							fifo_bit = 1'b0;
						else
							fifo_bit = 1'b1;
						end
		
///////////////////////////////////	
		
		SEVEN:		begin
						sys_reset_bit = 1'b0;
						operation_bit = 1'b0;
						pop_bit = 1'b1;
						if(i == 1'b0)
							fifo_bit = 1'b0;
						else
							fifo_bit = 1'b1;
						end
		
///////////////////////////////////	
		
		EIGHT:		begin
						sys_reset_bit = 1'b0;
						operation_bit = 1'b1;
						pop_bit = 1'b0;
						if(i == 1'b0)
							fifo_bit = 1'b0;
						else
							fifo_bit = 1'b1;
						end
		
///////////////////////////////////	
		
		NINE:			begin
						sys_reset_bit = 1'b0;
						operation_bit = 1'b0;
						pop_bit = 1'b1;
						if(i == 1'b0)
							fifo_bit = 1'b0;
						else
							fifo_bit = 1'b1;
						end
		
///////////////////////////////////	
		
		TEN:			begin
						sys_reset_bit = 1'b0;
						operation_bit = 1'b1;
						pop_bit = 1'b0;
						if(i == 1'b0)
							fifo_bit = 1'b0;
						else
							fifo_bit = 1'b1;
						end
		
///////////////////////////////////	
		
		ELEVEN:		begin
						sys_reset_bit = 1'b0;
						operation_bit = 1'b0;
						pop_bit = 1'b1;
						if(i == 1'b0)
							fifo_bit = 1'b0;
						else
							fifo_bit = 1'b1;
						end
		
///////////////////////////////////	
		
		TWELVE:		begin
						sys_reset_bit = 1'b0;
						operation_bit = 1'b1;
						pop_bit = 1'b0;
						if(i == 1'b0)
							fifo_bit = 1'b0;
						else
							fifo_bit = 1'b1;
						end
						
///////////////////////////////////	

		THIRTEEN:	begin
						sys_reset_bit = 1'b0;
						operation_bit = 1'b0;
						pop_bit = 1'b1;
						if(i == 1'b0)
							fifo_bit = 1'b0;
						else
							fifo_bit = 1'b1;
						end
		
///////////////////////////////////	
		
		FOURTEEN:	begin
						sys_reset_bit = 1'b0;
						operation_bit = 1'b1;
						pop_bit = 1'b0;
						if(i == 1'b0)
							fifo_bit = 1'b0;
						else
							fifo_bit = 1'b1;
						end
		
///////////////////////////////////	
		
		FIFTEEN:		begin
						sys_reset_bit = 1'b0;
						operation_bit = 1'b0;
						pop_bit = 1'b1;
						if(i == 1'b0)
							fifo_bit = 1'b0;
						else
							fifo_bit = 1'b1;
						end
	
///////////////////////////////////		
						
		SIXTEEN:		begin
						sys_reset_bit = 1'b0;
						operation_bit = 1'b1;
						pop_bit = 1'b0;
						if(i == 1'b0)
							fifo_bit = 1'b0;
						else
							fifo_bit = 1'b1;
						end
						
///////////////////////////////////		
						
		SEVENTEEN:	begin
						sys_reset_bit = 1'b0;
						operation_bit = 1'b1;
						pop_bit = 1'b0;
						if(i == 1'b0)
							fifo_bit = 1'b0;
						else
							fifo_bit = 1'b1;
						end
						
		FINAL:		begin
						sys_reset_bit = 1'b0;
						operation_bit = 1'b1;
						pop_bit = 1'b0;
						if(i == 1'b0)
							fifo_bit = 1'b0;
						else
							fifo_bit = 1'b1;
						end
						
		FINAL_SAFE:	begin
						sys_reset_bit = 1'b0;
						operation_bit = 1'b0;
						pop_bit = 1'b0;
						if(i == 1'b0)
							fifo_bit = 1'b0;
						else
							fifo_bit = 1'b1;
						end
		
		default:		;
	
	endcase

end

assign sys_reset = sys_reset_bit;
assign operation = operation_bit;
assign pop = pop_bit;
assign fifo = fifo_bit;
assign reset_ope = reset_ope_bit;

endmodule

