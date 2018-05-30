
module ASCIIConverter
(
	input [7:0] A,
	input [7:0] B,
	
	output [7:0]OUT

);

 logic [7:0]OUT_Logic;

 always_comb
 begin
	OUT_Logic = ((A-8'd48)*(8'd10))+((B-8'd48));
 end
 
 assign OUT = OUT_Logic;


endmodule
