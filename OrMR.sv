module OrMR
#(
	parameter INBits=33
)
(
	input [INBits-1:0] A,
	input [INBits-1:0] B,
	input [INBits-1:0] C,
	input [INBits-1:0] D,
	input [INBits-1:0] E,
	input [INBits-1:0] F,
	
	output [INBits-1:0]OUT

);

 logic [INBits-1:0]OUT_Logic;

 always_comb
 begin
	OUT_Logic = A|B|C|D|E|F;
 end
 
 assign OUT = OUT_Logic;

 
endmodule

