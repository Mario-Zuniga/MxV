module UART #(parameter UARTSIZE = 8)
(
	/* Inputs */
	input [UARTSIZE-1:0]Data,
	input Trans,
	input clk,
	input clk2,
	input reset,
	input RX,
	input clearInterrupt,
	
	/* Output */
	output TX,
	output [UARTSIZE-1:0] ReceivedData,
	output RXInterrputFlag,
	output PARITYERRORFlag
	
);

////////////////////////////////////////////////////////////UARTTX WIRES
wire maxflagC1TX_wire;
wire frameTX_wire;
wire datastateTX_wire;
wire startTX_wire;
wire parityTX_wire;

wire RegFrameTX_wire; 
wire RegDataStTX_wire;
wire RegParityTX_wire;

wire SRTX_wire;
wire MuxDataStTX_wire;
wire MuxParityTX_wire;

wire [UARTSIZE-1:0]ParityCheck_wire;
wire [UARTSIZE-1:0]ParityCheckREG_wire;
wire TXREG_wire;
///////////////////////////////////////////////////////////UARTRX WIRES
wire maxflagC1RX_wire;
wire datastateRX_wire;
wire parityRX_wire;
wire stopRX_wire;
wire waitstateRX_wire;
wire [UARTSIZE-1:0] SRRX_wire;
wire PARITYREGRX_wire;
wire ParityCheckRX_wire;
wire COMP1RX_wire;
wire PARITYERRORRX_wire;
wire RXINTERRUPTREG_wire;


//////////////////////////////////////////////////////////////UARTTX
 Ctl_Unit CTLTX

(
	//Inputs
	.clk(clk),
	.reset(reset),
	.trans(Trans),
	.maxflag(maxflagC1TX_wire),
	
	//Outputs
	.frame(frameTX_wire),
	.datastate(datastateTX_wire),
	.start(startTX_wire),
	.parity(parityTX_wire)
);

 CounterWithFunction
#(8)
C1TX
(
	// Input Ports
	.clk(clk),
	.reset(reset),
	.enable(datastateTX_wire),
	
	// Output Ports
	.flag(maxflagC1TX_wire),
	.CountOut() 
);

 Register #(1) RegFrameTX
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.sys_reset(1'b0),
	.Data_Input(frameTX_wire),

	// Output Ports
	.Data_Output(RegFrameTX_wire)
);

 Register #(1) RegDataStTX
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.sys_reset(1'b0),
	.Data_Input(datastateTX_wire),

	// Output Ports
	.Data_Output(RegDataStTX_wire)
);

 Register #(1) RegParityTX
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.sys_reset(1'b0),
	.Data_Input(parityTX_wire),

	// Output Ports
	.Data_Output(RegParityTX_wire)
);

 ShiftRegisterRight #(8) SRTX
(
	.clk(clk),
	.reset(reset),
	.sys_reset(1'b0),
	.serialInput(1'b0),
	.load(startTX_wire),
	.shift(datastateTX_wire),
	.parallelInput(Data),
	
	.serialOutput(SRTX_wire),
	.parallelOutput()
	
);


 Multiplexer2to1 #(1) MuxDataStTX
(
	.Selector(RegDataStTX_wire),
	.MUX_Data0(RegFrameTX_wire),
	.MUX_Data1(SRTX_wire),
	
	.MUX_Output(MuxDataStTX_wire)

);

 Multiplexer2to1 #(1) MuxParityTX
(
	.Selector(RegParityTX_wire),
	.MUX_Data0(MuxDataStTX_wire),
	.MUX_Data1(ParityCheck_wire[0]),
	
	.MUX_Output(MuxParityTX_wire)

);


 Register #(8) ParityCheckREG
(
	.clk(clk),
	.reset(reset),
	.enable(startTX_wire),
	.sys_reset(1'b0),
	.Data_Input(ParityCheck_wire),

	// Output Ports
	.Data_Output(ParityCheckREG_wire)
);
//assign ParityCheck_wire = Data % (8'd2);
assign ParityCheck_wire = ^Data;


 Register #(1) TXREG
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.sys_reset(1'b0),
	.Data_Input(MuxParityTX_wire),

	// Output Ports
	.Data_Output(TXREG_wire)
);

assign TX =	TXREG_wire;

///////////////////////////////////////////////////////////////////////UARTRX



 ShiftRegisterRight #(8) SRRX
(
	.clk(clk2),
	.reset(reset),
	.sys_reset(1'b0),
	.serialInput(RX),
	.load(1'b0),
	.shift(datastateRX_wire),
	.parallelInput(),
	
	.serialOutput(),
	.parallelOutput(SRRX_wire)
	
);

 Ctl_Unit_RX CTLRX

(
	//Inputs
	.clk(clk2),
	.reset(reset),
	.frame(RX),
	.maxflag(maxflagC1RX_wire),
	
	//Outputs
	.datastate(datastateRX_wire),
	.parity(parityRX_wire),
	.stop(stopRX_wire),
	.waitstate(waitstateRX_wire)
);

CounterWithFunction
#(9)
C1RX
(
	// Input Ports
	.clk(clk2),
	.reset(reset),
	.enable(waitstateRX_wire),
	
	// Output Ports
	.flag(maxflagC1RX_wire),
	.CountOut() 
);


Register #(1) PARITYREGRX
(
	.clk(clk2),
	.reset(reset),
	.enable(parityRX_wire),
	.sys_reset(1'b0),
	.Data_Input(RX),

	// Output Ports
	.Data_Output(PARITYREGRX_wire)
);

assign ParityCheckRX_wire = ^SRRX_wire;

 ComparadorR#(1) COMP1RX
(
	/* Inputs */
	.A(ParityCheckRX_wire),
	.B(PARITYREGRX_wire),
	
	/* Outputs */
	.C(COMP1RX_wire)
	
);

Register #(1) PARITYERRORRX
(
	.clk(clk2),
	.reset(reset),
	.enable(stopRX_wire),
	.sys_reset(1'b0),
	.Data_Input(COMP1RX_wire),

	// Output Ports
	.Data_Output(PARITYERRORRX_wire)
);

Register #(1) RXINTERRUPTREG
(
	.clk(clk2),
	.reset(reset),
	.enable(stopRX_wire),
	.sys_reset(clearInterrupt),
	.Data_Input(RX),

	// Output Ports
	.Data_Output(RXINTERRUPTREG_wire)
);

assign ReceivedData = SRRX_wire;
assign RXInterrputFlag = RXINTERRUPTREG_wire;
assign PARITYERRORFlag= PARITYERRORRX_wire;

endmodule
