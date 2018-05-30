module counterPush
#(
	// Parameter Declarations
	parameter NBITS_FOR_COUNTER = 3
)

(
	// Input Ports
	input clk,
	input reset,
	input enable,
	
	// Output Ports
	output logic pass

);


logic [NBITS_FOR_COUNTER-1 : 0] Count_logic = 3'd0;
bit pass_bit;

	always_ff@(posedge clk or negedge reset) begin: ThisIsACounter
	
		if (reset == 1'b0)
			Count_logic <= {NBITS_FOR_COUNTER{1'b0}};
			
		else
			if(enable == 1'b0)
				Count_logic <= 3'd0;
				
		else
		
			if(enable == 1'b1) begin
					Count_logic <= Count_logic + 1'b1;
					
			if(Count_logic == 3'd1)
				pass <= 1'b1;
			else
				pass <= 1'b0;
		end
				
	end: ThisIsACounter


endmodule