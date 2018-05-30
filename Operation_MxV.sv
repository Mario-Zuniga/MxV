module Operation_MxV
#(
	parameter Size  = 8
)
(
	// Input
	input [Size-1 : 0]A,
	input [Size-1 : 0]B,
	input show,
	input clk,
	input reset,
	input sys_reset,
	input operation,
	
	// Output
	output logic [Size-1 : 0]C,
	output logic send
);

logic [Size-1 : 0] C_logic;
logic [Size-1 : 0] store_logic;
//logic [Size-1 : 0] final_logic;
//bit send_bit = 1'b0;


always_ff@(posedge clk, negedge reset) begin

	if(reset == 1'b0) begin
		C_logic <= 8'b0;
		store_logic <= 8'b0;
		//final_logic <= 8'b0;
		//send_bit <= 1'b0;
	end
		
	else if(sys_reset == 1'b1) begin
		C_logic <= 8'b0;
		store_logic <= 8'b0;
		//final_logic <= 8'b0;
		//send_bit <= 1'b0;
	end
	
	else if(operation == 1'b1)begin
		C_logic <= A * B;
		store_logic <= store_logic + C_logic;
		//send_bit <= 1'b0;
	end
	
	else if(show == 1'b1) begin
		C <= store_logic;
		send <= 1'b1;
	end
		
end

/*
assign C = final_logic;
assign send = send_bit;
*/
endmodule
