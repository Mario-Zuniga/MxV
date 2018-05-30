
module OneShot

(
	//Inputs
	input clk,
	input reset,
	input Button,
	
	//Outputs
	output ButtonShot
);


/*  */
enum logic [1:0] {IDLE, ONE_SHOT, LOW} state;
/*  */
bit ButtonShotBit;


/* Cycle to assign to the next state */
always_ff@(posedge clk, negedge reset) begin

	if(reset == 1'b0)
		state <= IDLE;
		
	else
	begin
		case(state)
			IDLE:				if(Button == 1'b1) 	state <= ONE_SHOT;
			ONE_SHOT:									state <= LOW;
			LOW:				if(Button == 1'b0) 	state <= IDLE;
		
			default:		state <= IDLE;
				
		endcase
	end
end



always_comb begin

	ButtonShotBit	 = 	1'b0;

	case(state) 		
	
			ONE_SHOT:	ButtonShotBit = 1'b1;							
			
			default:	;
	endcase

end

assign ButtonShot = ButtonShotBit;

endmodule
