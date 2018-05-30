module RegisterValue
#(
	parameter Size  = 8, parameter Size_Total = 576
)
(
	input clk,
	input reset,
	input [Size - 1 : 0] in,
	input load,
	input leave,
	
	output [Size - 1 : 0] out
);

reg [Size_Total-1:0] Register_logic;
logic [Size-1:0] out_logic;

always@(posedge clk, negedge reset) begin

	if(reset == 1'b0) begin
		Register_logic <= {Size_Total{1'b0}};
		out_logic <= 8'b0;
	end
	
	else
	
	if(load == 1'b1) begin
		Register_logic <= Register_logic << 4'd8;
		Register_logic[Size-1:0] <= in;
	end
	
	else
	
	if(leave == 1'b1) begin
		out_logic <= Register_logic[7:0];
		Register_logic <= Register_logic >> 4'd8;
	end
	
end

assign out = out_logic;

endmodule
