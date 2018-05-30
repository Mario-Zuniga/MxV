module Selector
(
	input select,
	input pop,
	
	output A,
	output B
);

bit A_bit;
bit B_bit;

always_comb begin

	if(select == 1'b0) begin
		A_bit <= pop;
		B_bit <= 1'b0;
	end
	
	else begin
		B_bit <= pop;
		A_bit <= 1'b0;
	end

end

assign A = A_bit;
assign B = B_bit;

endmodule
