module PruebaPush
(
	input clk,
	input reset,
	input [2:0] CMD,
	input [3:0] N,
	input [7:0] Data,
	
	output [7:0]fifo1,
	output [7:0]fifo2,
	output [7:0]fifo3,
	output [7:0]fifo4,
	output [7:0]fifo5,
	output [7:0]fifo6,
	output [7:0]fifo7,
	output [7:0]fifo8,
	output [7:0]fifoVec1,
	output [7:0]fifoVec2
	
);

wire push_wire;
wire [3:0] i_wire;
wire start_wire;
wire pop_wire;

wire [7:0] Data1_wire;
wire [7:0] Data2_wire;
wire [7:0] Data3_wire;
wire [7:0] Data4_wire;
wire [7:0] Data5_wire;
wire [7:0] Data6_wire;
wire [7:0] Data7_wire;
wire [7:0] Data8_wire;
wire [7:0] DataVec1_wire;
wire [7:0] DataVec2_wire;

wire push1_wire;
wire push2_wire;
wire push3_wire;
wire push4_wire;
wire push5_wire;
wire push6_wire;
wire push7_wire;
wire push8_wire;

wire pushVec1_wire;
wire pushVec2_wire;

wire enable_push_wire;
wire enable_rest_wire;
wire pass_push_wire;
wire pass_rest_wire;

////////////////////////////////////////

push_Ctl Ctl
(
	.clk(clk),
	.reset(reset),
	.CMD(CMD),
	.N(N),
	.pass_push(pass_push_wire),
	.pass_rest(pass_rest_wire),
	
	.enable_push(enable_push_wire),
	.enable_rest(enable_rest_wire),
	.i(i_wire),
	.push(push_wire),
	.start(start_wire)
);

/////////////////////////////////////////

counterPush #( 3 ) Counter_Push
(
	.clk(clk),
	.reset(reset),
	.enable(enable_push_wire),
	
	.pass(pass_push_wire)
);

/////////////////////////////////////////

CounterRest #( 3 ) Counter_Rest

(
	.clk(clk),
	.reset(reset),
	.enable(enable_rest_wire),
	
	.pass(pass_rest_wire)
);

///////////////////////////////////////////
SelectorFIFO Select_FIFO
(
	.i(i_wire),
	.Data(Data),
	.push(push_wire),
	
	.FIFO_1(Data1_wire),
	.FIFO_2(Data2_wire),
	.FIFO_3(Data3_wire),
	.FIFO_4(Data4_wire),
	.FIFO_5(Data5_wire),
	.FIFO_6(Data6_wire),
	.FIFO_7(Data7_wire),
	.FIFO_8(Data8_wire),
	
	.FIFO_Vec1(DataVec1_wire),
	.FIFO_Vec2(DataVec2_wire),
	
	.push1(push1_wire),
	.push2(push2_wire),
	.push3(push3_wire),
	.push4(push4_wire),
	.push5(push5_wire),
	.push6(push6_wire),
	.push7(push7_wire),
	.push8(push8_wire),
	.pushVec2(pushVec1_wire),
	.pushVec1(pushVec2_wire)
);

// FIFO's of the system
FIFO #(8, 3) FIFO_Matriz_Linea1
(
	.clk(clk),
	.reset(reset),
	.DataInput(Data),
	.push(push1_wire),
	.pop(pop_wire), 
	
	.full(),
	.empty(),
	.DataOutput(fifo1)
);


FIFO #(8, 3) FIFO_Matriz_Linea2
(
	.clk(clk),
	.reset(reset),
	.DataInput(Data),
	.push(push2_wire),
	.pop(pop_wire),
	
	.full(),
	.empty(),
	.DataOutput(fifo2)
);


FIFO #(8, 3) FIFO_Matriz_Linea3
(
	.clk(clk),
	.reset(reset),
	.DataInput(Data),
	.push(push3_wire),
	.pop(pop_wire),
	
	.full(),
	.empty(),
	.DataOutput(fifo3)
);


FIFO #(8, 3) FIFO_Matriz_Linea4
(
	.clk(clk),
	.reset(reset),
	.DataInput(Data),
	.push(push4_wire),
	.pop(pop_wire),
	
	.full(),
	.empty(),
	.DataOutput(fifo4)
);


FIFO #(8, 3) FIFO_Matriz_Linea5
(
	.clk(clk),
	.reset(reset),
	.DataInput(Data),
	.push(push5_wire),
	.pop(pop_wire), 
	
	.full(),
	.empty(),
	.DataOutput(fifo5)
);


FIFO #(8, 3) FIFO_Matriz_Linea6
(
	.clk(clk),
	.reset(reset),
	.DataInput(Data),
	.push(push6_wire),
	.pop(pop_wire), 
	
	.full(),
	.empty(),
	.DataOutput(fifo6)
);


FIFO #(8, 3) FIFO_Matriz_Linea7
(
	.clk(clk),
	.reset(reset),
	.DataInput(Data),
	.push(push7_wire),
	.pop(pop_wire),
	
	.full(),
	.empty(),
	.DataOutput(fifo7)
);


FIFO #(8, 3) FIFO_Matriz_Linea8
(
	.clk(clk),
	.reset(reset),
	.DataInput(Data),
	.push(push8_wire),
	.pop(pop_wire),
	
	.full(),
	.empty(),
	.DataOutput(fifo8)
);


FIFO #(8, 3) FIFO_Vector1
(
	.clk(clk),
	.reset(reset),
	.DataInput(Data),
	.push(pushVec1_wire),
	.pop(pop_wire), 
	
	.full(),
	.empty(),
	.DataOutput(fifoVec1)
);


FIFO #(8, 3) FIFO_Vector2
(
	.clk(clk),
	.reset(reset),
	.DataInput(Data),
	.push(pushVec2_wire),
	.pop(pop_wire), 
	
	.full(),
	.empty(),
	.DataOutput(fifoVec2)
);

MxV_Ctl_Unit Pop_Ctl
(
	.clk(clk),
	.reset(reset),
	.start(start_wire),
	.N(N),
	
	.sys_reset(),
	.operation(),
	.fifo(),
	.reset_ope(),
	.pop(pop_wire)
);

endmodule
