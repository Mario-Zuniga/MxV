
module Binary_Decoder(
	
	//Input Ports
	input [7:0] In_Bits,
	
	//Output Ports
	output [7:0] ONES, TENS,
	output [7:0] HUNDREDS
);
	
	
	//Wires to Inputs and Outputs of Shifter_three_adder module 
	wire [3:0] D1,D2,D3,D4,D5,D6,D7;
	wire [3:0] C1,C2,C3,C4,C5,C6,C7;


	//We use a 8-bit binary combinational topology extracted from a block diagramhttps://www.hobbielektronika.hu/forum/getfile.php?id=236582
	assign D1 = {1'b0,In_Bits[7:5]};
	Binary_shift_three_adder SHIFTED1(D1,C1);

	assign D2 = {C1[2:0],In_Bits[4]};
	Binary_shift_three_adder SHIFTED2(D2,C2);

	assign D3 = {C2[2:0],In_Bits[3]};
	Binary_shift_three_adder SHIFTED3(D3,C3);

	assign D4 = {C3[2:0],In_Bits[2]};
	Binary_shift_three_adder SHIFTED4(D4,C4);

	assign D5 = {C4[2:0],In_Bits[1]};
	Binary_shift_three_adder SHIFTED5(D5,C5);

	assign D6 = {1'b0,C1[3],C2[3],C3[3]};
	Binary_shift_three_adder SHIFTED6(D6,C6);

	assign D7 = {C6[2:0],C4[3]};
	Binary_shift_three_adder SHIFTED7(D7,C7);

	//We assign our Outputs 
	assign ONES = ({4'b0,C5[2:0],In_Bits[0]})+8'd48;
	assign TENS = ({4'b0,C7[2:0],C5[3]})+8'd48;
	assign HUNDREDS = ({6'b0,C6[3],C7[3]})+8'd48;

endmodule
