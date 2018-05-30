module MxV
#(
	parameter Size  = 8
)
(
	// Inputs
	input clk,
	input reset,
	input [Size-1:0] Data,
	input [Size-1:0]N,
	
	input N_Valid,
	input Prep_Valid,
	input Data_Valid,
	input Stop,
	
	// Outputs
	output pop_outside,
	output send,
	output [Size-1:0] result
);

// Wires
wire [Size-1:0] FIFO_Out_1_wire;
wire [Size-1:0] FIFO_Out_2_wire;
wire [Size-1:0] FIFO_Out_3_wire;
wire [Size-1:0] FIFO_Out_4_wire;
wire [Size-1:0] FIFO_Out_5_wire;
wire [Size-1:0] FIFO_Out_6_wire;
wire [Size-1:0] FIFO_Out_7_wire;
wire [Size-1:0] FIFO_Out_8_wire;
wire [Size-1:0] FIFO_Out_Vec_wire;
wire [Size-1:0] FIFO_Out_Vec2_wire;

wire [Size-1:0] result1_wire;
wire [Size-1:0] result2_wire;
wire [Size-1:0] result3_wire;
wire [Size-1:0] result4_wire;

wire [Size-1:0] result4_pipe1_wire;
wire [Size-1:0] result4_pipe2_wire;
wire [Size-1:0] result4_pipe3_wire;
wire [Size-1:0] result4_pipe4_wire;
wire [Size-1:0] result3_pipe1_wire;
wire [Size-1:0] result3_pipe2_wire;

wire pop_wire;
wire sys_reset_wire;
wire operation_wire;
wire fifo_wire;
wire reset_ope_wire;
wire push_wire;
wire [3:0] i_wire;
wire start_wire;

wire fifo_pipe1_wire;
wire fifo_pipe2_wire;
wire fifo_pipe3_wire;

wire pop_pipe1_wire;
wire pop_pipe2_wire;
wire pop_pipe3_wire;

wire [7:0] FIFO_Out_8_pipe2_wire;
wire [7:0] FIFO_Out_8_pipe1_wire;

wire ope_pipe1_wire;
wire ope_pipe2_wire;
wire ope_pipe3_wire;

wire empty1_wire;
wire empty2_wire;
wire empty3_wire;
wire empty4_wire;
wire empty5_wire;
wire empty6_wire;
wire empty7_wire;
wire empty8_wire;
wire emptyVec1_wire;
wire emotyVec2_wire;


wire empty_Vec_wire;
wire empty_Vec_pipe1_wire;
wire empty_Vec_pipe2_wire;

wire send1_wire;
wire send2_wire;
wire send3_wire;
wire send4_wire;

wire empty_ope1_wire;
wire empty_ope2_wire;
wire empty_ope3_wire;
wire empty_ope4_wire;

wire [Size-1:0] data_pipe1_wire;
wire [Size-1:0] data_pipe2_wire;
wire [Size-1:0] data_pipe3_wire;

wire [Size-1:0] data_mux1_wire;
wire [Size-1:0] data_mux2_wire;
wire [Size-1:0] data_mux3_wire;
wire [Size-1:0] data_mux4_wire;
wire [Size-1:0] data_mux5_wire;


wire pop_fifo1_wire;
wire pop_fifo2_wire;
wire pop_fifo3_wire;
wire pop_fifo4_wire;
wire pop_fifo5_wire;
wire pop_fifo6_wire;
wire pop_fifo7_wire;
wire pop_fifo8_wire;
wire pop_vec1_wire;
wire pop_vec2_wire;

wire empty_ope1_pipe1_wire;
wire empty_ope1_pipe2_wire;
wire empty_ope2_pipe1_wire;
wire empty_ope2_pipe2_wire;
wire empty_ope3_pipe1_wire;
wire empty_ope3_pipe2_wire;
wire empty_ope4_pipe1_wire;
wire empty_ope4_pipe2_wire;


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

wire [7:0] N_wire;
wire [7:0] N_pass;

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


//////////////////////////////////////
Register #( 8 ) Reg_N
(
	.clk(clk),
	.reset(reset),
	.enable(N_Valid),
	.sys_reset(),
	.Data_Input(N),

	.Data_Output(N_pass)
);

Register #( 8 ) Reg_N2
(
	.clk(clk),
	.reset(reset),
	.enable(Stop),
	.sys_reset(),
	.Data_Input(N_pass),

	.Data_Output(N_wire)
);

///////////////////////////////////////

push_Ctl Ctl
(
	.clk(clk),
	.reset(reset),
	.N(N_wire),
	.pass_push(pass_push_wire),
	.pass_rest(pass_rest_wire),
	
	.Prep_Valid(Prep_Valid),
	.Data_Valid(Data_Valid),
	.Stop(Stop),
	
	.pop_outside(pop_outside),
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






///////////////////////////////////////

// Mux for choice data 

Multiplexer2to1 #( 8 ) Mux_1or5
(
	.Selector(fifo_wire),
	.MUX_Data0(FIFO_Out_1_wire),
	.MUX_Data1(FIFO_Out_5_wire),
	
	.MUX_Output(data_mux1_wire)

);

Multiplexer2to1 #( 8 ) Mux_2or6
(
	.Selector(fifo_wire),
	.MUX_Data0(FIFO_Out_2_wire),
	.MUX_Data1(FIFO_Out_6_wire),
	
	.MUX_Output(data_mux2_wire)

);

Multiplexer2to1 #( 8 ) Mux_3or7
(
	.Selector(fifo_wire),
	.MUX_Data0(FIFO_Out_3_wire),
	.MUX_Data1(FIFO_Out_7_wire),
	
	.MUX_Output(data_mux3_wire)

);

Multiplexer2to1 #( 8 ) Mux_4or8
(
	.Selector(fifo_wire),
	.MUX_Data0(FIFO_Out_4_wire),
	.MUX_Data1(FIFO_Out_8_pipe2_wire),
	
	.MUX_Output(data_mux4_wire)

);

Multiplexer2to1 #( 8 ) Mux_Vec1orVec2
(
	.Selector(fifo_wire),
	.MUX_Data0(FIFO_Out_Vec_wire),
	.MUX_Data1(FIFO_Out_Vec2_wire),
	
	.MUX_Output(data_mux5_wire)

);


/////////////////////////////////////////

// Control Unit
MxV_Ctl_Unit MxV_Control
(
	// Inputs
	.clk(clk),
	.reset(reset),
	.start(start_wire),
	.N(N_wire),
	
	// Outputs
	.sys_reset(sys_reset_wire),
	.operation(operation_wire),
	.fifo(fifo_wire),
	.reset_ope(reset_ope_wire),
	.pop(pop_wire)
);


// Selector of FIFOs for pop
Selector Sel_1or5
(
	.select(fifo_wire),
	.pop(pop_wire),
	// A if fifo 1
	// B is fifo 5
	.A(pop_fifo1_wire),
	.B(pop_fifo5_wire)
);


Selector Sel_2or6
(
	.select(fifo_pipe1_wire),
	.pop(pop_pipe1_wire),
	// A if fifo 2
	// B is fifo 6
	.A(pop_fifo2_wire),
	.B(pop_fifo6_wire)
);


Selector Sel_3or7
(
	.select(fifo_pipe2_wire),
	.pop(pop_pipe2_wire),
	// A if fifo 3
	// B is fifo 7
	.A(pop_fifo3_wire),
	.B(pop_fifo7_wire)
);


Selector Sel_4or8
(
	.select(fifo_pipe3_wire),
	.pop(pop_pipe3_wire),
	// A if fifo 4
	// B is fifo 8
	.A(pop_fifo4_wire),
	.B(pop_fifo8_wire)
);


Selector Sel_Vec1orVec2
(
	.select(fifo_wire),
	.pop(pop_wire),
	// A if fifo Vec1
	// B is fifo Vec2
	.A(pop_vec1_wire),
	.B(pop_vec2_wire)
);


//////////////////////////////////
// Selector for empty fifo

Multiplexer2to1 #( 1 ) Empty_1or5
(
	.Selector(fifo_wire),
	.MUX_Data0(empty1_wire),
	.MUX_Data1(empty5_wire),
	
	.MUX_Output(empty_ope1_wire)

);

Register #( 1 ) R_empty1_5
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.sys_reset(),
	.Data_Input(empty_ope1_wire),

	.Data_Output(empty_ope1_pipe1_wire)
);

Register #( 1 ) R_empty1_5_2
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.sys_reset(),
	.Data_Input(empty_ope1_pipe1_wire),

	.Data_Output(empty_ope1_pipe2_wire)
);


Multiplexer2to1 #( 1 ) Empty_2or6
(
	.Selector(fifo_wire),
	.MUX_Data0(empty2_wire),
	.MUX_Data1(empty6_wire),
	
	.MUX_Output(empty_ope2_wire)

);

Register #( 1 ) R_empty2_6
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.sys_reset(),
	.Data_Input(empty_ope2_wire),

	.Data_Output(empty_ope2_pipe1_wire)
);

Register #( 1 ) R_empty2_6_2
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.sys_reset(),
	.Data_Input(empty_ope2_pipe1_wire),

	.Data_Output(empty_ope2_pipe2_wire)
);

Multiplexer2to1 #( 1 ) Empty_3or7
(
	.Selector(fifo_wire),
	.MUX_Data0(empty3_wire),
	.MUX_Data1(empty7_wire),
	
	.MUX_Output(empty_ope3_wire)

);


Register #( 1 ) R_empty3_7
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.sys_reset(),
	.Data_Input(empty_ope3_wire),

	.Data_Output(empty_ope3_pipe1_wire)
);

Register #( 1 ) R_empty3_7_2
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.sys_reset(),
	.Data_Input(empty_ope3_pipe1_wire),

	.Data_Output(empty_ope3_pipe2_wire)
);


Multiplexer2to1 #( 1 ) Empty_4or8
(
	.Selector(fifo_wire),
	.MUX_Data0(empty4_wire),
	.MUX_Data1(empty8_wire),
	
	.MUX_Output(empty_ope4_wire)

);

Register #( 1 ) R_empty4_8
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.sys_reset(),
	.Data_Input(empty_ope1_wire),

	.Data_Output(empty_ope4_pipe1_wire)
);

Register #( 1 ) R_empty4_8_2
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.sys_reset(),
	.Data_Input(empty_ope4_pipe1_wire),

	.Data_Output(empty_ope4_pipe2_wire)
);





Multiplexer2to1 #( 1 ) Empty_Vec1orVec2
(
	.Selector(fifo_wire),
	.MUX_Data0(emptyVec1_wire),
	.MUX_Data1(emptyVec2_wire),
	
	.MUX_Output(empty_Vec_wire)

);


Register #( 1 ) R_empty_Vec1orVec2
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.sys_reset(),
	.Data_Input(empty_Vec_wire),

	.Data_Output(empty_Vec_pipe1_wire)
);

Register #( 1 ) R_empty2_Vec1orVec2
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.sys_reset(),
	.Data_Input(empty_Vec_pipe1_wire),

	.Data_Output(empty_Vec_pipe2_wire)
);




//////////////////////////////////////

Register #( 8 ) R_8_1
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.sys_reset(),
	.Data_Input(FIFO_Out_8_wire),

	.Data_Output(FIFO_Out_8_pipe1_wire)
);

Register #( 8 ) R_8_2
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.sys_reset(),
	.Data_Input(FIFO_Out_8_pipe1_wire),

	.Data_Output(FIFO_Out_8_pipe2_wire)
);



//////////////////////////////////////



// FIFO's of the system
FIFO #(8, 3) FIFO_Matriz_Linea1
(
	.clk(clk),
	.reset(reset),
	.DataInput(Data),
	.push(push1_wire),
	.pop(pop_fifo1_wire), 
	
	.full(),
	.empty(empty1_wire),
	.DataOutput(FIFO_Out_1_wire)
);


FIFO #(8, 3) FIFO_Matriz_Linea2
(
	.clk(clk),
	.reset(reset),
	.DataInput(Data),
	.push(push2_wire),
	.pop(pop_fifo2_wire),
	
	.full(),
	.empty(empty2_wire),
	.DataOutput(FIFO_Out_2_wire)
);


FIFO #(8, 3) FIFO_Matriz_Linea3
(
	.clk(clk),
	.reset(reset),
	.DataInput(Data),
	.push(push3_wire),
	.pop(pop_fifo3_wire),
	
	.full(),
	.empty(empty3_wire),
	.DataOutput(FIFO_Out_3_wire)
);


FIFO #(8, 3) FIFO_Matriz_Linea4
(
	.clk(clk),
	.reset(reset),
	.DataInput(Data),
	.push(push4_wire),
	.pop(pop_fifo4_wire),
	
	.full(),
	.empty(empty4_wire),
	.DataOutput(FIFO_Out_4_wire)
);


FIFO #(8, 3) FIFO_Matriz_Linea5
(
	.clk(clk),
	.reset(reset),
	.DataInput(Data),
	.push(push5_wire),
	.pop(pop_fifo5_wire), 
	
	.full(),
	.empty(empty5_wire),
	.DataOutput(FIFO_Out_5_wire)
);


FIFO #(8, 3) FIFO_Matriz_Linea6
(
	.clk(clk),
	.reset(reset),
	.DataInput(Data),
	.push(push6_wire),
	.pop(pop_fifo6_wire), 
	
	.full(),
	.empty(empty6_wire),
	.DataOutput(FIFO_Out_6_wire)
);


FIFO #(8, 3) FIFO_Matriz_Linea7
(
	.clk(clk),
	.reset(reset),
	.DataInput(Data),
	.push(push7_wire),
	.pop(pop_fifo7_wire),
	
	.full(),
	.empty(empty7_wire),
	.DataOutput(FIFO_Out_7_wire)
);


FIFO #(8, 3) FIFO_Matriz_Linea8
(
	.clk(clk),
	.reset(reset),
	.DataInput(Data),
	.push(push8_wire),
	.pop(pop_fifo8_wire),
	
	.full(),
	.empty(empty8_wire),
	.DataOutput(FIFO_Out_8_wire)
);


FIFO #(8, 3) FIFO_Vector1
(
	.clk(clk),
	.reset(reset),
	.DataInput(Data),
	.push(pushVec1_wire),
	.pop(pop_vec1_wire), 
	
	.full(),
	.empty(emptyVec1_wire),
	.DataOutput(FIFO_Out_Vec_wire)
);


FIFO #(8, 3) FIFO_Vector2
(
	.clk(clk),
	.reset(reset),
	.DataInput(Data),
	.push(pushVec2_wire),
	.pop(pop_vec2_wire), 
	
	.full(),
	.empty(emptyVec2_wire),
	.DataOutput(FIFO_Out_Vec2_wire)
);


// Operation MxV modules
Operation_MxV #( 8 ) Ope_MxV_1
(
	// Input
	.A(data_mux5_wire),
	.B(data_mux1_wire),
	.show(empty_ope1_wire),
	.clk(clk),
	.reset(reset),
	.sys_reset(reset_ope_wire),
	.operation(operation_wire),
	
	.C(result1_wire),
	.send(send1_wire)
);

Operation_MxV #( 8 ) Ope_MxV_2
(
	// Input
	.A(data_pipe1_wire),
	.B(data_mux2_wire),
	.show(empty_ope2_wire),
	.clk(clk),
	.reset(reset),
	.sys_reset(reset_ope_wire),
	.operation(ope_pipe1_wire),
	
	.C(result2_wire),
	.send(send2_wire)
);

Operation_MxV #( 8 ) Ope_MxV_3
(
	// Input
	.A(data_pipe2_wire),
	.B(data_mux3_wire),
	.show(empty_ope3_wire),
	.clk(clk),
	.reset(reset),
	.sys_reset(reset_ope_wire),
	.operation(ope_pipe2_wire),
	
	.C(result3_wire),
	.send(send3_wire)
);

Operation_MxV #( 8 ) Ope_MxV_4
(
	// Input
	.A(data_pipe3_wire),
	.B(data_mux4_wire),
	.show(empty_ope4_wire),
	.clk(clk),
	.reset(reset),
	.sys_reset(reset_ope_wire),
	.operation(ope_pipe3_wire),
	
	.C(result4_wire),
	.send(send4_wire)
);



// Registers for Flip-Flops
// Signal1 -> pop				Signal2 -> operation
// Signal3 -> sys_reset		Signal4 -> fifo
Register_3 #( 8 ) Reg_Pipe_1
(
	// Input Ports
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.sys_reset(sys_reset_wire),
	.Data_Input(data_mux5_wire),
	.Signal1_Input(pop_wire),
	.Signal2_Input(operation_wire),
	.Signal3_Input(),
	.Signal4_Input(fifo_wire),

	// Output Ports
	.Data_Output(data_pipe1_wire),
	.Signal1_Output(pop_pipe1_wire),
	.Signal2_Output(ope_pipe1_wire),
	.Signal3_Output(),
	.Signal4_Output(fifo_pipe1_wire)
);


Register_3 #( 8 ) Reg_Pipe_2
(
	// Input Ports
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.sys_reset(sys_reset_wire),
	.Data_Input(data_pipe1_wire),
	.Signal1_Input(pop_pipe1_wire),
	.Signal2_Input(ope_pipe1_wire),
	.Signal3_Input(),
	.Signal4_Input(fifo_pipe1_wire),

	// Output Ports
	.Data_Output(data_pipe2_wire),
	.Signal1_Output(pop_pipe2_wire),
	.Signal2_Output(ope_pipe2_wire),
	.Signal3_Output(),
	.Signal4_Output(fifo_pipe2_wire)
);


Register_3 #( 8 ) Reg_Pipe_3
(
	// Input Ports
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.sys_reset(sys_reset_wire),
	.Data_Input(data_pipe2_wire),
	.Signal1_Input(pop_pipe2_wire),
	.Signal2_Input(ope_pipe2_wire),
	.Signal3_Input(),
	.Signal4_Input(fifo_pipe2_wire),

	// Output Ports
	.Data_Output(data_pipe3_wire),
	.Signal1_Output(pop_pipe3_wire),
	.Signal2_Output(ope_pipe3_wire),
	.Signal3_Output(),
	.Signal4_Output(fifo_pipe3_wire)
);

SendControl Send_Ctl
(
	.clk(clk),
	.reset(reset),
	.empty(empty_Vec_pipe2_wire),
	
	.result1(result1_wire),
	.result2(result2_wire),
	.result3(result3_pipe2_wire),
	.result4(result4_pipe4_wire),
	
	.result_send(result),
	.pulse(send)
	
);


Register #( 8 ) Result3_pipe1
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.sys_reset(),
	.Data_Input(result3_wire),

	.Data_Output(result3_pipe1_wire)
);

Register #( 8 ) Result3_pipe2
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.sys_reset(),
	.Data_Input(result3_pipe1_wire),

	.Data_Output(result3_pipe2_wire)
);

Register #( 8 ) Result4_pipe1
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.sys_reset(),
	.Data_Input(result4_wire),

	.Data_Output(result4_pipe1_wire)
);

Register #( 8 ) Result4_pipe2
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.sys_reset(),
	.Data_Input(result4_pipe1_wire),

	.Data_Output(result4_pipe2_wire)
);

Register #( 8 ) Result4_pipe3
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.sys_reset(),
	.Data_Input(result4_pipe2_wire),

	.Data_Output(result4_pipe3_wire)
);

Register #( 8 ) Result4_pipe4
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.sys_reset(),
	.Data_Input(result4_pipe3_wire),

	.Data_Output(result4_pipe4_wire)
);


endmodule
