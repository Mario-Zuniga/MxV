
module Ctl_Unit_MXVtoTX

(
	//Inputs
	input clk,
	input reset,
	input PULSE,
	input [7:0] N,
	input MAXFLAG,
	
	//Outputs
	output CAPTURE1FLAG,
	output CAPTURE2FLAG,
	output CAPTURE3FLAG,
	output CAPTURE4FLAG,
	output CAPTURE5FLAG,
	output CAPTURE6FLAG,
	output CAPTURE7FLAG,
	output CAPTURE8FLAG,
	output COUNT
	
);


/* agregar 25 ws o contador */
enum logic [4:0] {IDLE, CAPTURE1, LOWCAPTURE1, CAPTURE2, LOWCAPTURE2, CAPTURE3, LOWCAPTURE3, CAPTURE4, LOWCAPTURE4, CAPTURE5, LOWCAPTURE5, CAPTURE6, LOWCAPTURE6, CAPTURE7, LOWCAPTURE7, CAPTURE8, LOWCAPTURE8, W1} state;
/*  */
bit CAPTURE1_bit;
bit CAPTURE2_bit;
bit CAPTURE3_bit;
bit CAPTURE4_bit;
bit CAPTURE5_bit;
bit CAPTURE6_bit;
bit CAPTURE7_bit;
bit CAPTURE8_bit;
bit COUNT_bit;


/* Cycle to assign to the next 	 */
always_ff@(posedge clk, negedge reset) begin

	if(reset == 1'b0)
		state	<= CAPTURE1;
		
	else if(N>8'd8)
		state <= CAPTURE1;
		
	else
	begin
		case(state)

			CAPTURE1:	if(N>8'd0)	
							begin
							if(PULSE==1)						state <= LOWCAPTURE1;
							end
							else									state <= W1;
							
			LOWCAPTURE1:if(PULSE==0)						state <= CAPTURE2;
							
			CAPTURE2:	if(N>8'd1)	
							begin
							if(PULSE==1)						state <= LOWCAPTURE2;
							end
							else									state <= W1;
							
			LOWCAPTURE2:if(PULSE==0)						state <= CAPTURE3;
							
			CAPTURE3:	if(N>8'd2)	
							begin
							if(PULSE==1)						state <= LOWCAPTURE3;
							end
							else									state <= W1;
							
			LOWCAPTURE3:if(PULSE==0)						state <= CAPTURE4;
							
			CAPTURE4:	if(N>8'd3)	
							begin
							if(PULSE==1)						state <= LOWCAPTURE4;
							end
							else									state <= W1;
							
			LOWCAPTURE4:if(PULSE==0)						state <= CAPTURE5;
							
			CAPTURE5:	if(N>8'd4)	
							begin
							if(PULSE==1)						state <= LOWCAPTURE5;
							end
							else									state <= W1;
							
			LOWCAPTURE5:if(PULSE==0)						state <= CAPTURE6;
							
			CAPTURE6:	if(N>8'd5)	
							begin
							if(PULSE==1)						state <= LOWCAPTURE6;
							end
							else									state <= W1;
							
			LOWCAPTURE6:if(PULSE==0)						state <= CAPTURE7;
							
			CAPTURE7:	if(N>8'd6)	
							begin
							if(PULSE==1)						state <= LOWCAPTURE7;
							end
							else									state <= W1;
			
			LOWCAPTURE7:if(PULSE==0)						state <= CAPTURE8;
			
			CAPTURE8:	if(N>8'd7)	
							begin
							if(PULSE==1)						state <= LOWCAPTURE8;
							end
							else									state <= W1;
			
			LOWCAPTURE8:if(PULSE==0)						state <= CAPTURE1;
							
			W1:			if(MAXFLAG==1)						state <= CAPTURE1;
			
			
			
			default:		state <= CAPTURE1;
				
		endcase
	end
end



always_comb begin

 CAPTURE1_bit = 1'b0;
 CAPTURE2_bit = 1'b0;
 CAPTURE3_bit = 1'b0;
 CAPTURE4_bit = 1'b0;
 CAPTURE5_bit = 1'b0;
 CAPTURE6_bit = 1'b0;
 CAPTURE7_bit = 1'b0;
 CAPTURE8_bit = 1'b0;
 COUNT_bit	  = 1'b0;


	case(state) 
		
			LOWCAPTURE1:	CAPTURE1_bit = 1'b1;
			LOWCAPTURE2:	CAPTURE2_bit = 1'b1;
			LOWCAPTURE3:	CAPTURE3_bit = 1'b1;
			LOWCAPTURE4:	CAPTURE4_bit = 1'b1;
			LOWCAPTURE5:	CAPTURE5_bit = 1'b1;
			LOWCAPTURE6:	CAPTURE6_bit = 1'b1;
			LOWCAPTURE7:	CAPTURE7_bit = 1'b1;
			LOWCAPTURE8:	CAPTURE8_bit = 1'b1;		
			W1:				COUNT_bit	 = 1'b1;	
			
			default:	;
	endcase

end

assign CAPTURE1FLAG = CAPTURE1_bit;
assign CAPTURE2FLAG = CAPTURE2_bit;
assign CAPTURE3FLAG = CAPTURE3_bit;
assign CAPTURE4FLAG = CAPTURE4_bit;
assign CAPTURE5FLAG = CAPTURE5_bit;
assign CAPTURE6FLAG = CAPTURE6_bit;
assign CAPTURE7FLAG = CAPTURE7_bit;
assign CAPTURE8FLAG = CAPTURE8_bit;
assign COUNT		  = COUNT_bit;

endmodule
