module Sync_Counter
#(
	// Parameter Declarations
	parameter REF_FREQUNCY = 0,
	parameter FIXED_FREQUENCY= 0,
   parameter MAXIMUM_VALUE = REF_FREQUNCY/FIXED_FREQUENCY,
	parameter NBITS_FOR_COUNTER = CeilLog2(MAXIMUM_VALUE)
)

(
	// Input Ports
	input clk,
	input reset,
	
	// Output Ports
	output flag
);

bit MaxValue_Bit;

logic [NBITS_FOR_COUNTER-1 : 0] Count_logic;

	always_ff@(posedge clk or negedge reset) begin
		if (reset == 1'b0)
			Count_logic <= {NBITS_FOR_COUNTER{1'b0}};
		else begin
				
			if(Count_logic == MAXIMUM_VALUE - 1)
					Count_logic <= 0;
			else
					Count_logic <= Count_logic + 1'b1;
		end
	end

//--------------------------------------------------------------------------------------------

always_comb
	if(Count_logic == MAXIMUM_VALUE-1)
		MaxValue_Bit = 1;
	else
		MaxValue_Bit = 0;

		
//---------------------------------------------------------------------------------------------
assign flag = MaxValue_Bit;


 /*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/
   
 /*Log Function*/
     function integer CeilLog2;
       input integer data;
       integer i,result;
       begin
          for(i=0; 2**i < data; i=i+1)
             result = i + 1;
          CeilLog2 = result;
       end
    endfunction

/*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/

endmodule
