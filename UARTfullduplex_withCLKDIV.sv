 module UARTfullduplex_withCLKDIV #(parameter UARTSIZE = 8)
(
	/* Inputs */
	input [UARTSIZE-1:0]Data,
	input Trans,
	input clk,
	input reset,
	input RX,
	input clearInterrupt,
	
	/* Output */
	output TX,
	output [UARTSIZE-1:0] ReceivedData,
	output RXInterrputFlag,
	output PARITYERRORFlag
	
);
 
wire clkOutF;
wire clkOutF2;


 UART #(8) UART1
(
	/* Inputs */
	.Data(Data),
	.Trans(Trans),
	.clk(clkOutF),
	.clk2(clkOutF2),
	.reset(reset),
	.RX(RX),
	.clearInterrupt(clearInterrupt),
	
	/* Output */
	.TX(TX),
	.ReceivedData(ReceivedData),
	.RXInterrputFlag(RXInterrputFlag),
	.PARITYERRORFlag(PARITYERRORFlag)
	
);





Clock_Divider#(50000000,2500000) CLKDIV1

(
	// Input Ports
	.clk(clk),
	.reset(reset),
	

	// Output Ports
	.clk_FPGA_out(clkOutF)
);

Clock_Divider#(50000000,2500000*10) CLKDIV2

(
	// Input Ports
	.clk(clk),
	.reset(reset),
	

	// Output Ports
	.clk_FPGA_out(clkOutF2)
);

endmodule
