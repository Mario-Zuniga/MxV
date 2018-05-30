module CounterWithFunction_INPUT
#(
	// Parameter Declarations
	parameter MAXIMUM_VALUE = 7,
	parameter NBITS_FOR_COUNTER = CeilLog2(MAXIMUM_VALUE)
)

(
	// Input Ports
	input clk,
	input reset,
	input sys_rst,
	input enable,
	input [NBITS_FOR_COUNTER-1:0] MAXVAL,
	
	// Output Ports
	output flag,
	output[NBITS_FOR_COUNTER-1:0] CountOut 
);

bit MaxValue_Bit;

logic [NBITS_FOR_COUNTER-1 : 0] Count_logic;

	always_ff@(posedge clk or negedge reset) begin
		if (reset == 1'b0)
			Count_logic <= {NBITS_FOR_COUNTER{1'b0}};
			
		else if (sys_rst == 1'b1)
			Count_logic <= {NBITS_FOR_COUNTER{1'b0}};
			
		else begin
				if(enable == 1'b1)
					if(Count_logic == MAXVAL-1)
						Count_logic <= 0;
					else
						Count_logic <= Count_logic + 1'b1;
		end
	end

//--------------------------------------------------------------------------------------------

always_comb
	if(Count_logic == MAXVAL-3)
		MaxValue_Bit = 1;
	else
		MaxValue_Bit = 0;

		
//---------------------------------------------------------------------------------------------
assign flag = MaxValue_Bit;

assign CountOut = Count_logic;
//----------------------------------------------------------------------------------------------

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

