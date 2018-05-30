module Clock_Divider

#(
	// Parameter Declarations
	parameter REF_FREQUNCY = 50000000,
	parameter FIXED_FREQUENCY= 50000
)

(
	// Input Ports
	input clk,
	input reset,
	

	// Output Ports
	output clk_FPGA_out
);

 logic clk_FPGA_out_logic;
 logic clk_FPGA_out_logic_flag;
 
 wire flag_con;
 
 	generate
		if (FIXED_FREQUENCY<=12500000) 
		begin
			Sync_Counter #(REF_FREQUNCY,FIXED_FREQUENCY*2) SC1 (.clk(clk),.reset(reset),.flag(flag_con));
		end
		else 
		begin
			Sync_Counter #(REF_FREQUNCY,FIXED_FREQUENCY) SC1 (.clk(clk),.reset(reset),.flag(flag_con));
		end
	endgenerate
 
 
 always_ff@(posedge clk or negedge reset) begin
	if (reset == 1'b0)
		clk_FPGA_out_logic<= 1'b0;
	else
	begin
		if (flag_con==1)
			clk_FPGA_out_logic<= ~clk_FPGA_out_logic;
	end
 
 end
 
 always_comb
 begin
	if(FIXED_FREQUENCY<=12500000)
		clk_FPGA_out_logic_flag = clk_FPGA_out_logic;
	else
		clk_FPGA_out_logic_flag = flag_con;
 end
 
 
 assign clk_FPGA_out = clk_FPGA_out_logic_flag;
 
 

 

endmodule



