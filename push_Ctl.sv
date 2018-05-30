module push_Ctl
(
	input clk,
	input reset,
	input [7:0]N,
	input pass_push,
	input pass_rest,
	
	input Prep_Valid,
	input Data_Valid,
	input Stop,
	
	output enable_push,
	output enable_rest,
	output [3:0]i,
	output push,
	output pop_outside,
	output start
);

enum logic [4:0] {IDLE1, IDLE2, IDLE3, IDLE4, BIT, PUSH1, REST1, PUSH2, REST2, PUSH3, REST3, PUSH4, REST4, PUSH5, REST5, PUSH6, REST6, PUSH7, REST7, PUSH8, REST8, CHECK, WAIT, READY}state;

bit enable_push_bit;
bit enable_rest_bit;
bit push_bit;
bit start_bit;
bit pop_outside_bit;

logic [3:0] i_logic = 4'd0;

always_ff@(posedge clk, negedge reset) begin

	if(reset == 1'b0) begin
		state <= IDLE1;
		i_logic <= 4'd0;
	end
		
	else
	begin
		case(state)
			IDLE1:		if (Prep_Valid == 1'b1)	begin i_logic <= 4'd0;		state <= IDLE2; end
			IDLE2:		if (Stop == 1'b1)																						state <= IDLE3;
			IDLE3:		if	(Data_Valid == 1'b1)																				state <= IDLE4;
			IDLE4:		if (Stop == 1'b1)																						state <= BIT;
			BIT:			if (i_logic == N)	begin i_logic <= 4'd8;	state <= PUSH1; end else					state <= PUSH1;
			PUSH1:		/*if (pass_push == 1'b1)*/																				state <= REST1;
			REST1:		if (pass_rest == 1'b1)					begin if(N == 8'd1) state <= CHECK;		else	state <= PUSH2; end
			PUSH2:		/*if (pass_push == 1'b1)*/																				state <= REST2;
			REST2:		if (pass_rest == 1'b1)					begin if(N == 8'd2) state <= CHECK;		else	state <= PUSH3; end
			PUSH3:		/*if (pass_push == 1'b1)	*/																			state <= REST3;
			REST3:		if (pass_rest == 1'b1)					begin if(N == 8'd3) state <= CHECK;		else	state <= PUSH4; end
			PUSH4:		/*if (pass_push == 1'b1)*/																				state <= REST4;
			REST4:		if (pass_rest == 1'b1)					begin if(N == 8'd4) state <= CHECK;		else	state <= PUSH5; end
			PUSH5:		/*if (pass_push == 1'b1)*/																				state <= REST5;
			REST5:		if (pass_rest == 1'b1)					begin if(N == 8'd5) state <= CHECK;		else	state <= PUSH6; end
			PUSH6:		/*if (pass_push == 1'b1)*/																				state <= REST6;
			REST6:		if (pass_rest == 1'b1)					begin if(N == 8'd6) state <= CHECK;		else	state <= PUSH7; end
			PUSH7:		/*if (pass_push == 1'b1)*/																				state <= REST7;
			REST7:		if (pass_rest == 1'b1)					begin if(N == 8'd7) state <= CHECK;		else	state <= PUSH8; end
			PUSH8:		/*if (pass_push == 1'b1)*/																				state <= REST8;
			REST8:		if (pass_rest == 1'b1)																				state <= CHECK;
			CHECK:		if (i_logic >= N) state <= WAIT;		else begin	i_logic <= i_logic + 4'd1;			state <= BIT; end 
			WAIT:																														state <= READY;
			READY:																													state <= IDLE1;
			default: 																												state <= IDLE1;
		endcase
	end
end

always_comb begin

	enable_push_bit = 1'b0;
	enable_rest_bit = 1'b0;
	push_bit = 1'b0;
	start_bit = 1'b0;
	pop_outside_bit = 1'b0;
	
	case(state)
		IDLE1:		begin
						enable_push_bit = 1'b0;
						enable_rest_bit = 1'b0;
						push_bit = 1'b0;
						start_bit = 1'b0;
						
						end
		
///////////////////////////////////	

		IDLE2:		begin
						enable_push_bit = 1'b0;
						enable_rest_bit = 1'b0;
						push_bit = 1'b0;
						start_bit = 1'b0;
						end
		
///////////////////////////////////

		BIT:			begin
						enable_push_bit = 1'b0;
						enable_rest_bit = 1'b0;
						push_bit = 1'b0;
						start_bit = 1'b0;
						end
		
///////////////////////////////////

		PUSH1:		begin
						enable_push_bit = 1'b1;
						enable_rest_bit = 1'b0;
						push_bit = 1'b1;
						start_bit = 1'b0;
						pop_outside_bit = 1'b1;
						end
		
///////////////////////////////////

		REST1:		begin
						enable_push_bit = 1'b0;
						enable_rest_bit = 1'b1;
						push_bit = 1'b0;
						start_bit = 1'b0;
						end
		
///////////////////////////////////

		PUSH2:		begin
						enable_push_bit = 1'b1;
						enable_rest_bit = 1'b0;
						push_bit = 1'b1;
						start_bit = 1'b0;
						pop_outside_bit = 1'b1;
						end
		
///////////////////////////////////

		REST2:		begin
						enable_push_bit = 1'b0;
						enable_rest_bit = 1'b1;
						push_bit = 1'b0;
						start_bit = 1'b0;
						end
		
///////////////////////////////////

		PUSH3:		begin
						enable_push_bit = 1'b1;
						enable_rest_bit = 1'b0;
						push_bit = 1'b1;
						start_bit = 1'b0;
						pop_outside_bit = 1'b1;
						end
		
///////////////////////////////////

		REST3:		begin
						enable_push_bit = 1'b0;
						enable_rest_bit = 1'b1;
						push_bit = 1'b0;
						start_bit = 1'b0;
						end
		
///////////////////////////////////

		PUSH4:		begin
						enable_push_bit = 1'b1;
						enable_rest_bit = 1'b0;
						push_bit = 1'b1;
						start_bit = 1'b0;
						pop_outside_bit = 1'b1;
						end
		
///////////////////////////////////

		REST4:		begin
						enable_push_bit = 1'b0;
						enable_rest_bit = 1'b1;
						push_bit = 1'b0;
						start_bit = 1'b0;
						end
		
///////////////////////////////////

		PUSH5:		begin
						enable_push_bit = 1'b1;
						enable_rest_bit = 1'b0;
						push_bit = 1'b1;
						start_bit = 1'b0;
						pop_outside_bit = 1'b1;
						end
		
///////////////////////////////////

		REST5:		begin
						enable_push_bit = 1'b0;
						enable_rest_bit = 1'b1;
						push_bit = 1'b0;
						start_bit = 1'b0;
						end
		
///////////////////////////////////

		PUSH6:		begin
						enable_push_bit = 1'b1;
						enable_rest_bit = 1'b0;
						push_bit = 1'b1;
						start_bit = 1'b0;
						pop_outside_bit = 1'b1;
						end
		
///////////////////////////////////

		REST6:		begin
						enable_push_bit = 1'b0;
						enable_rest_bit = 1'b1;
						push_bit = 1'b0;
						start_bit = 1'b0;
						end
		
///////////////////////////////////

		PUSH7:		begin
						enable_push_bit = 1'b1;
						enable_rest_bit = 1'b0;
						push_bit = 1'b1;
						start_bit = 1'b0;
						pop_outside_bit = 1'b1;
						end
		
///////////////////////////////////

		REST7:		begin
						enable_push_bit = 1'b0;
						enable_rest_bit = 1'b1;
						push_bit = 1'b0;
						start_bit = 1'b0;
						end
		
///////////////////////////////////

		PUSH8:		begin
						enable_push_bit = 1'b1;
						enable_rest_bit = 1'b0;
						push_bit = 1'b1;
						start_bit = 1'b0;
						pop_outside_bit = 1'b1;
						end
		
///////////////////////////////////

		REST8:		begin
						enable_push_bit = 1'b0;
						enable_rest_bit = 1'b1;
						push_bit = 1'b0;
						start_bit = 1'b0;
						end
		
///////////////////////////////////

		WAIT:			begin
						enable_push_bit = 1'b0;
						enable_rest_bit = 1'b0;
						push_bit = 1'b0;
						start_bit = 1'b0;
						end
		
///////////////////////////////////

		READY:		begin
						enable_push_bit = 1'b0;
						enable_rest_bit = 1'b0;
						push_bit = 1'b0;
						start_bit = 1'b1;
						end
		
///////////////////////////////////

		default:		;
	endcase
end
	
assign enable_push = enable_push_bit;
assign enable_rest = enable_rest_bit;
assign push = push_bit;
assign start = start_bit;	
assign i = i_logic;
assign pop_outside = pop_outside_bit;

endmodule
