module Comparador
#(
	parameter Size = 16
)
(
	/* Inputs */
	input [Size - 1 : 0]A,
	input [Size - 1 : 0]B,
	
	/* Outputs */
	output OUT
	
);

bit OUT_bit;

always_comb begin: Comp

	if(A ==B)
		OUT_bit = 1'b1;
	else
		OUT_bit = 1'b0;

end

assign OUT = OUT_bit;

endmodule
