module FIFO
#(parameter DATA_WIDTH=4, parameter ADDR_WIDTH=3)
(
	/* Inputs */
	input clk,
	input reset,
	input [(DATA_WIDTH-1):0] DataInput,
	input push,
	input pop, 
	
	/* Output */
	output full,
	output empty,
	output [(DATA_WIDTH-1):0]DataOutput
);

wire pushPulse;
wire popPulse;

wire  [(ADDR_WIDTH-1):0]pushAddressVal;
wire  [(ADDR_WIDTH-1):0]popAddressVal;

wire  pushPulsePast;
wire  popPulsePast;

wire  popPulseSync;

wire equal;

wire 	[(DATA_WIDTH-1):0] q;

wire 	[(DATA_WIDTH-1):0] popVal;

wire fullValidation;
wire emptyValidation;

wire fullBit;
wire emptyBit;

wire pulse;

wire canPush;
wire canPop;

/*Pulse Creation--------------------------------------------------------------------------*/

One_Shot PushOneShot

(
	//Inputs
	.clk(clk),
	.reset(reset),
	.Start(push),
	
	//Outputs
	.Shot(pushPulse)
);


/*
One_Shot PopOneShot

(
	//Inputs
	.clk(clk),
	.reset(reset),
	.Start(pop),
	
	//Outputs
	.Shot(popPulse)
);
*/
/*
Register #(1) RegPushSafe
(
	// Input Ports
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.sys_reset(1'b0),
	.Data_Input(push),

	// Output Ports
	.Data_Output(pushPulse)
);
*/

Register #(1) RegPopSafe
(
	// Input Ports
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.sys_reset(1'b0),
	.Data_Input(pop),

	// Output Ports
	.Data_Output(popPulse)
);


 /*QUEUE LOGIC------------------------------------------------------------*/
 CounterWithFunction #(2**ADDR_WIDTH) pushAddress
(
	.clk(clk),
	.reset(reset),
	.enable(canPush),
	
	// Output Ports
	.flag(),
	.CountOut(pushAddressVal) 
);

CounterWithFunction #(2**ADDR_WIDTH) popAddress
(
	
	.clk(clk),
	.reset(reset),
	.enable(canPop),
	
	// Output Ports
	.flag(),
	.CountOut(popAddressVal) 
);

Register #(1) PushPulseReg1
(
	// Input Ports
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.sys_reset(1'b0),
	.Data_Input(canPush),

	// Output Ports
	.Data_Output(pushPulsePast)
);

Register #(1) PopPulseReg1
(
	// Input Ports
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.sys_reset(1'b0),
	.Data_Input(canPop),

	// Output Ports
	.Data_Output(popPulsePast)
);

 simple_dual_port_ram_single_clock
#(DATA_WIDTH, ADDR_WIDTH)
RAM1
(
	.data(DataInput),
	.read_addr(popAddressVal), 
	.write_addr(pushAddressVal),
	.we(pushPulsePast), //pushPulsePast
	.clk(clk),
	.q(q)
);

Register #(1) PopPulseReg2
(
	// Input Ports
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.sys_reset(1'b0),
	.Data_Input(popPulsePast), //popPulsePast

	// Output Ports
	.Data_Output(popPulseSync)
);


/*Equal and full/empty Validatio-------------------------------------------------------n*/

 Comparador #(ADDR_WIDTH) Comp1
(
	/* Inputs */
	.A(popAddressVal),
	.B(pushAddressVal),
	
	/* Outputs */
	.OUT(equal)
	
);

 AndM #(1) AND3
(
	.A(pushPulsePast),
	.B(equal),
	
	.OUT(fullValidation)

);

 AndM #(1) AND4
(
	.A(popPulsePast),
	.B(equal),
	
	.OUT(emptyValidation)

);

 OrM #(1) OR1
(
	.A(pushPulsePast),
	.B(popPulsePast),
	
	.OUT(pulse)

);

Register #(1) FullReg1
(
	// Input Ports
	.clk(clk),
	.reset(reset),
	.enable(pulse),
	.sys_reset(1'b0),
	.Data_Input(fullValidation),

	// Output Ports
	.Data_Output(fullBit)
);

Register_empty #(1) EmptyReg1
(
	// Input Ports
	.clk(clk),
	.reset(reset),
	.enable(pulse),
	.sys_reset(1'b0),
	.Data_Input(emptyValidation),

	// Output Ports
	.Data_Output(emptyBit)
);

/* Initial Valitation to count---------------------------------------------------*/

 AndM #(1) AND1
(
	.A(pushPulse),
	.B(~fullBit),
	
	.OUT(canPush)

);

 AndM #(1) AND2
(
	.A(popPulse),
	.B(~emptyBit),
	
	.OUT(canPop)

);

assign DataOutput = q;
assign full = fullBit;
assign empty = emptyBit;

endmodule
