module SendControl
(
	input clk,
	input reset,
	input empty,
	
	input [7:0] result1,
	input [7:0] result2,
	input [7:0] result3,
	input [7:0] result4,
	
	output [7:0] result_send,
	output pulse
	
);

enum logic [4:0] {IDLE, WAIT_FIN, ONE, ONE_REST, TWO, TWO_REST, THREE, THREE_REST, FOUR, FOUR_REST, FOUR_SAFE}state;

bit pulse_send;
logic [7:0] result_logic;

always_ff@(posedge clk, negedge reset) begin

	
	if(reset == 1'b0)
		state <= IDLE;
		
	else
	begin
		case(state)
			IDLE: 		if (empty == 1'b0)			state <= WAIT_FIN;
			WAIT_FIN:	if (empty == 1'b1)			state <= ONE;
			ONE:												state <= ONE_REST;
			ONE_REST:										state <= TWO;
			TWO:												state <= TWO_REST;
			TWO_REST:										state <= THREE;
			THREE:											state <= THREE_REST;
			THREE_REST:										state <= FOUR;
			FOUR:												state <= FOUR_REST;
			FOUR_REST:										state <= FOUR_SAFE;
			FOUR_SAFE:										state <= IDLE;
			
			default											state <= IDLE;
		endcase
	end
end

always_comb begin

pulse_send = 1'b0;
result_logic = 8'd0;
	
	case(state)
	//////////////////////////////////////
			IDLE:			begin
							pulse_send = 1'b0;
							result_logic = 1'b0;
							end
					
	//////////////////////////////////////
			WAIT_FIN:	begin
							pulse_send = 1'b0;
							result_logic = 8'b0;
							end
					
					
	//////////////////////////////////////
			ONE:			begin
							pulse_send = 1'b1;
							result_logic = result1;
							end
					
					
	//////////////////////////////////////
			ONE_REST:	begin
							pulse_send = 1'b0;
							result_logic = result1;
							end
					
					
	//////////////////////////////////////
			TWO:			begin
							pulse_send = 1'b1;
							result_logic = result2;
							end
					
					
	//////////////////////////////////////
			TWO_REST:	begin
							pulse_send = 1'b0;
							result_logic = result2;
							end
					
					
	//////////////////////////////////////
			THREE:		begin
							pulse_send = 1'b1;
							result_logic = result3;
							end
					
					
	//////////////////////////////////////
			THREE_REST:	begin
							pulse_send = 1'b0;
							result_logic = result3;
							end
					
					
	//////////////////////////////////////
			FOUR:			begin
							pulse_send = 1'b1;
							result_logic = result4;
							end
					
					
	//////////////////////////////////////
			FOUR_REST:	begin
							pulse_send = 1'b0;
							result_logic = result4;
							end
							
	//////////////////////////////////////
			FOUR_SAFE:	begin
							pulse_send = 1'b0;
							result_logic = result4;
							end
					
			default:		;
					
	endcase
	
end

assign result_send = result_logic;
assign pulse = pulse_send;

endmodule
