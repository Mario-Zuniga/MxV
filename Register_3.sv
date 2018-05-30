module Register_3
#(
	parameter Word_Length = 8
)
(
	// Input Ports
	input clk,
	input reset,
	input enable,
	input sys_reset,
	input [Word_Length-1:0] Data_Input,
	input Signal1_Input,
	input Signal2_Input,
	input Signal3_Input,
	input Signal4_Input,

	// Output Ports
	output logic [Word_Length-1:0] Data_Output,
	output logic Signal1_Output,
	output logic Signal2_Output,
	output logic Signal3_Output,
	output logic Signal4_Output
);

always_ff@(posedge clk or negedge reset) begin:ThisIsARegister
	if(reset == 1'b0) begin
		Data_Output <= {Word_Length{1'b0}};
		Signal1_Output <= 1'b0;
		Signal2_Output <= 1'b0;
		Signal3_Output <= 1'b0;
		Signal4_Output <= 1'b0;
	end
		
	else if(sys_reset == 1'b1) begin
		Data_Output <= {Word_Length{1'b0}};
		Signal1_Output <= 1'b0;
		Signal2_Output <= 1'b0;
		Signal3_Output <= 1'b0;
		Signal4_Output <= 1'b0;
	end
		
	else 
		if (enable == 1'b1) begin
			Data_Output <= Data_Input;
			Signal1_Output <= Signal1_Input;
			Signal2_Output <= Signal2_Input;
			Signal3_Output <= Signal3_Input;
			Signal4_Output <= Signal4_Input;
		end
			
end:ThisIsARegister


endmodule
