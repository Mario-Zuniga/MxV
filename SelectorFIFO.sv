module SelectorFIFO
(
	
	input [3:0] i,
	input [7:0] Data,
	input push,
	
	output logic [7:0] FIFO_1,
	output logic [7:0] FIFO_2,
	output logic [7:0] FIFO_3,
	output logic [7:0] FIFO_4,
	output logic [7:0] FIFO_5,
	output logic [7:0] FIFO_6,
	output logic [7:0] FIFO_7,
	output logic [7:0] FIFO_8,
	
	output logic [7:0] FIFO_Vec1,
	output logic [7:0] FIFO_Vec2,
	
	output logic push1,
	output logic push2,
	output logic push3,
	output logic push4,
	output logic push5,
	output logic push6,
	output logic push7,
	output logic push8,
	output logic pushVec2,
	output logic pushVec1
);

always_comb begin

/////////////////////////// 1
	if(i == 4'd0) begin
		FIFO_1 <= Data;
		FIFO_2 <= 8'd0;
		FIFO_3 <= 8'd0;
		FIFO_4 <= 8'd0;
		FIFO_5 <= 8'd0;
		FIFO_6 <= 8'd0;
		FIFO_7 <= 8'd0;
		FIFO_8 <= 8'd0;
		FIFO_Vec1 <= 8'd0;
		FIFO_Vec2 <= 8'd0;
		
		push1 <= push;
		push2 <= 1'b0;
		push3 <= 1'b0;
		push4 <= 1'b0;
		push5 <= 1'b0;
		push6 <= 1'b0;
		push7 <= 1'b0;
		push8 <= 1'b0;
		pushVec1 <= 1'b0;
		pushVec2 <= 1'b0;
	end

/////////////////////////////// 2
	else if(i == 4'd1) begin
		FIFO_1 <= 8'd0;
		FIFO_2 <= Data;
		FIFO_3 <= 8'd0;
		FIFO_4 <= 8'd0;
		FIFO_5 <= 8'd0;
		FIFO_6 <= 8'd0;
		FIFO_7 <= 8'd0;
		FIFO_8 <= 8'd0;
		FIFO_Vec1 <= 8'd0;
		FIFO_Vec2 <= 8'd0;
		
		push1 <= 1'b0;
		push2 <= push;
		push3 <= 1'b0;
		push4 <= 1'b0;
		push5 <= 1'b0;
		push6 <= 1'b0;
		push7 <= 1'b0;
		push8 <= 1'b0;
		pushVec1 <= 1'b0;
		pushVec2 <= 1'b0;
	end
	
////////////////////////////// 3
	else if(i == 4'd2) begin
		FIFO_1 <= 8'd0;
		FIFO_2 <= 8'd0;
		FIFO_3 <= Data;
		FIFO_4 <= 8'd0;
		FIFO_5 <= 8'd0;
		FIFO_6 <= 8'd0;
		FIFO_7 <= 8'd0;
		FIFO_8 <= 8'd0;
		FIFO_Vec1 <= 8'd0;
		FIFO_Vec2 <= 8'd0;
		
		push1 <= 1'b0;
		push2 <= 1'b0;
		push3 <= push;
		push4 <= 1'b0;
		push5 <= 1'b0;
		push6 <= 1'b0;
		push7 <= 1'b0;
		push8 <= 1'b0;
		pushVec1 <= 1'b0;
		pushVec2 <= 1'b0;
	end
	
///////////////////////////// 4
	else if(i == 4'd3) begin
		FIFO_1 <= 8'd0;
		FIFO_2 <= 8'd0;
		FIFO_3 <= 8'd0;
		FIFO_4 <= Data;
		FIFO_5 <= 8'd0;
		FIFO_6 <= 8'd0;
		FIFO_7 <= 8'd0;
		FIFO_8 <= 8'd0;
		FIFO_Vec1 <= 8'd0;
		FIFO_Vec2 <= 8'd0;
		
		push1 <= 1'b0;
		push2 <= 1'b0;
		push3 <= 1'b0;
		push4 <= push;
		push5 <= 1'b0;
		push6 <= 1'b0;
		push7 <= 1'b0;
		push8 <= 1'b0;
		pushVec1 <= 1'b0;
		pushVec2 <= 1'b0;
	end

////////////////////////////// 5
	else if(i == 4'd4) begin
		FIFO_1 <= 8'd0;
		FIFO_2 <= 8'd0;
		FIFO_3 <= 8'd0;
		FIFO_4 <= 8'd0;
		FIFO_5 <= Data;
		FIFO_6 <= 8'd0;
		FIFO_7 <= 8'd0;
		FIFO_8 <= 8'd0;
		FIFO_Vec1 <= 8'd0;
		FIFO_Vec2 <= 8'd0;
		
		push1 <= 1'b0;
		push2 <= 1'b0;
		push3 <= 1'b0;
		push4 <= 1'b0;
		push5 <= push;
		push6 <= 1'b0;
		push7 <= 1'b0;
		push8 <= 1'b0;
		pushVec1 <= 1'b0;
		pushVec2 <= 1'b0;
	end
	
///////////////////////////// 6
	else if(i == 4'd5) begin
		FIFO_1 <= 8'd0;
		FIFO_2 <= 8'd0;
		FIFO_3 <= 8'd0;
		FIFO_4 <= 8'd0;
		FIFO_5 <= 8'd0;
		FIFO_6 <= Data;
		FIFO_7 <= 8'd0;
		FIFO_8 <= 8'd0;
		FIFO_Vec1 <= 8'd0;
		FIFO_Vec2 <= 8'd0;
		
		push1 <= 1'b0;
		push2 <= 1'b0;
		push3 <= 1'b0;
		push4 <= 1'b0;
		push5 <= 1'b0;
		push6 <= push;
		push7 <= 1'b0;
		push8 <= 1'b0;
		pushVec1 <= 1'b0;
		pushVec2 <= 1'b0;
	end
	
///////////////////////////// 7
	else if(i == 4'd6) begin
		FIFO_1 <= 8'd0;
		FIFO_2 <= 8'd0;
		FIFO_3 <= 8'd0;
		FIFO_4 <= 8'd0;
		FIFO_5 <= 8'd0;
		FIFO_6 <= 8'd0;
		FIFO_7 <= Data;
		FIFO_8 <= 8'd0;
		FIFO_Vec1 <= 8'd0;
		FIFO_Vec2 <= 8'd0;
		
		push1 <= 1'b0;
		push2 <= 1'b0;
		push3 <= 1'b0;
		push4 <= 1'b0;
		push5 <= 1'b0;
		push6 <= 1'b0;
		push7 <= push;
		push8 <= 1'b0;
		pushVec1 <= 1'b0;
		pushVec2 <= 1'b0;
	end
	
///////////////////////////// 8
	else if(i == 4'd7) begin
		FIFO_1 <= 8'd0;
		FIFO_2 <= 8'd0;
		FIFO_3 <= 8'd0;
		FIFO_4 <= 8'd0;
		FIFO_5 <= 8'd0;
		FIFO_6 <= 8'd0;
		FIFO_7 <= 8'd0;
		FIFO_8 <= Data;
		FIFO_Vec1 <= 8'd0;
		FIFO_Vec2 <= 8'd0;
		
		push1 <= 1'b0;
		push2 <= 1'b0;
		push3 <= 1'b0;
		push4 <= 1'b0;
		push5 <= 1'b0;
		push6 <= 1'b0;
		push7 <= 1'b0;
		push8 <= push;
		pushVec1 <= 1'b0;
		pushVec2 <= 1'b0;
	end
	
///////////////////////////// Vectores
	else if(i == 4'd8) begin
		FIFO_1 <= 8'd0;
		FIFO_2 <= 8'd0;
		FIFO_3 <= 8'd0;
		FIFO_4 <= 8'd0;
		FIFO_5 <= 8'd0;
		FIFO_6 <= 8'd0;
		FIFO_7 <= 8'd0;
		FIFO_8 <= 8'd0;
		FIFO_Vec1 <= Data;
		FIFO_Vec2 <= Data;
		
		push1 <= 1'b0;
		push2 <= 1'b0;
		push3 <= 1'b0;
		push4 <= 1'b0;
		push5 <= 1'b0;
		push6 <= 1'b0;
		push7 <= 1'b0;
		push8 <= 1'b0;
		pushVec1 <= push;
		pushVec2 <= push;
	end
	
	else begin
		FIFO_1 <= 8'd0;
		FIFO_2 <= 8'd0;
		FIFO_3 <= 8'd0;
		FIFO_4 <= 8'd0;
		FIFO_5 <= 8'd0;
		FIFO_6 <= 8'd0;
		FIFO_7 <= 8'd0;
		FIFO_8 <= 8'd0;
		FIFO_Vec1 <= 8'd0;
		FIFO_Vec2 <= 8'd0;
		
		push1 <= 1'b0;
		push2 <= 1'b0;
		push3 <= 1'b0;
		push4 <= 1'b0;
		push5 <= 1'b0;
		push6 <= 1'b0;
		push7 <= 1'b0;
		push8 <= 1'b0;
		pushVec1 <= 1'b0;
		pushVec2 <= 1'b0;
	end

end

endmodule
