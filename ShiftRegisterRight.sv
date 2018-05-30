module ShiftRegisterRight
#(
	parameter WORD_LENGTH = 8
)
(
	input clk,
	input reset,
	input sys_reset,
	input serialInput,
	input load,
	input shift,
	input [WORD_LENGTH - 1 : 0] parallelInput,
	
	output serialOutput,
	output [WORD_LENGTH - 1 : 0] parallelOutput
	

);

reg [WORD_LENGTH - 1 : 0] shiftRegister_logic;
bit serialOutput_bit;

always@(posedge clk, negedge reset) begin
	
	if(reset == 1'b0)
		shiftRegister_logic <= {WORD_LENGTH{1'b0}};
		
	else if(sys_reset == 1'b1)
	shiftRegister_logic <= {WORD_LENGTH{1'b0}};
	
	else
	
		case ({load, shift})
			2'b01:
				begin
				serialOutput_bit <= shiftRegister_logic[0];
				shiftRegister_logic <= {serialInput, shiftRegister_logic[WORD_LENGTH - 1 : 1]};
				end
			2'b10:
				shiftRegister_logic <= parallelInput;
			default:
				shiftRegister_logic <= shiftRegister_logic;
		endcase
end


assign serialOutput =  serialOutput_bit;
assign parallelOutput = shiftRegister_logic;


endmodule