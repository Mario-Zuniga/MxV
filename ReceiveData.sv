 module ReceiveData #(parameter UARTSIZE = 8)
(
	/* Inputs */
	input clk,
	input reset,
	input RX,

	/* Output */
	output LOCKEDST,
	output LOCKEDL,
	output LOCKEDCMD_N_DATA,
	output LOCKEDCMD_PREPARE_RET,
	output LOCKEDN,
	output TX
	
	
);
 
 wire [UARTSIZE-1:0]UART1_ReceivedData_wire;
 wire UART1_RXInterrputFlag_wire;
 wire UART1_PARITYERRORFlag_wire;
 
 wire UART2_TX_wire;
 
 wire clearFLAG_UART;
 
 wire clkOut;
 
 /*START FRAME WIRES*/////////////////////////////////
 
 wire CTLSTU_INITFLAG1_wire;
 wire CTLSTU_INITFLAG2_wire;
 wire CTLSTU_VALIDSTARTFLAG_wire;
 wire CTLSTU_CLEARFLAG_wire;
 
 wire [UARTSIZE-1:0]REGST1_ReceivedData_wire;
 wire [UARTSIZE-1:0]REGST2_ReceivedData_wire;
 
 wire COMPF_VALIDSTART_wire;
 wire COMPE_VALIDSTART_wire;
 wire AND1_VALIDSTART_wire;
 
 wire LOCKEDFLAG_CTLSTU_wire;
 
 /*L FRAME WIRES*/////////////////////////////////
 wire CTLLU_INITFLAG1_wire;
 wire CTLLU_INITFLAG2_wire;
 wire CTLLU_VALIDLENGTHFLAG_wire;
 wire CTLLU_CLEARFLAG_wire;
 
 wire [UARTSIZE-1:0]REGL1_ReceivedData_wire;
 wire [UARTSIZE-1:0]REGL2_ReceivedData_wire;
 
 wire [UARTSIZE-1:0]ACII1_L_wire;
 wire LOCKEDFLAG_CTLLU_wire;
 
 wire UNLOCKPASTFLAG_CTLLU_wire;
 
  /*CMD FRAME WIRES*/////////////////////////////////
 wire CTLCMDU_INITFLAG1_wire;
 wire CTLCMDU_INITFLAG2_wire;
 wire CTLCMDU_VALIDNFLAG_wire;
 wire CTLCMDU_VALIDDATAFLAG_wire;
 wire CTLCMDU_VALIDPREPARFLAG_wire;
 wire CTLCMDU_VALIDRETRFLAG_wire;
 wire CTLCMDU_CLEARFLAG_wire;
 
 wire [UARTSIZE-1:0]REGCMD1_ReceivedData_wire;
 wire [UARTSIZE-1:0]REGCMD2_ReceivedData_wire;
 
 wire [UARTSIZE-1:0]ACII1_CMD_wire;
 wire LOCKED_N_DATA_FLAG_CTLCMDU_wire;
 wire LOCKED_PREPARE_RETR_FLAG_CTLCMDU_wire;
 
 wire UNLOCKPASTFLAG_CTLCMDU_wire;
 
  /*N FRAME WIRES*/////////////////////////////////
 wire CTLNU_INITFLAG1_wire;
 wire CTLNU_INITFLAG2_wire;
 wire CTLNU_VALIDNFLAG_wire;
 wire CTLNU_CLEARFLAG_wire;
 
 wire [UARTSIZE-1:0]REGN1_ReceivedData_wire;
 wire [UARTSIZE-1:0]REGN2_ReceivedData_wire;
 
 wire [UARTSIZE-1:0]ACII3_N_wire;
 wire LOCKEDFLAG_CTLNU_wire;
 
 wire UNLOCKPASTFLAG_CTLNU_wire;
 
 /*DATA FRAME WIRES*/////////////////////////////////
 wire CTLDATAU_INITFLAG1_wire;
 wire CTLDATAU_INITFLAG2_wire;
 wire CTLDATAU_COUNTFLAG_wire;
 wire CTLDATAU_DONECOUNTFLAG_wire;
 wire CTLDATAU_CLEARFLAG_wire;
 
 wire [UARTSIZE-1:0]REGDATA1_ReceivedData_wire;
 wire [UARTSIZE-1:0]REGDATA2_ReceivedData_wire;
 
 wire [UARTSIZE-1:0]ACII4_DATA_wire;
 wire LOCKEDFLAG_CTLDATAU_wire;
 
 wire UNLOCKPASTFLAG_CTLDATAU_wire;
 
 wire CTLDATAU_MAXREACH_wire;
 
  /*STOP FRAME WIRES*/////////////////////////////////
 
 wire CTLSTOPU_INITFLAG1_wire;
 wire CTLSTOPU_INITFLAG2_wire;
 wire CTLSTOPU_VALIDSTOPFLAG_wire;
 wire CTLSTOPU_CLEARFLAG_wire;
 
 wire [UARTSIZE-1:0]REGSTOP1_ReceivedData_wire;
 wire [UARTSIZE-1:0]REGSTOP2_ReceivedData_wire;
 
 wire COMPF_VALIDSTOP_wire;
 wire COMPE_VALIDSTOP_wire;
 wire AND2_VALIDSTOP_wire;
 
 wire UNLOCKPASTFLAG_CTLSTOPU_wire;
 wire VALID_OPFLAG_wire;
 
 ////////////////////////////////RXTOMXR
 wire [UARTSIZE-1:0] Data_Input_MDR_wire;
 wire FIFO_EXTRACT_wire;
 wire Send_wire;
 wire [UARTSIZE-1:0]Result_wire;
 wire [UARTSIZE-1:0]ResultREG_wire;
 
 ////////////////////////////////MXRTOTX
 wire CAPTURE1FLAG_wire;
 wire CAPTURE2FLAG_wire;
 wire CAPTURE3FLAG_wire;
 wire CAPTURE4FLAG_wire;
 wire CAPTURE5FLAG_wire;
 wire CAPTURE6FLAG_wire;
 wire CAPTURE7FLAG_wire;
 wire CAPTURE8FLAG_wire;
 
 wire CTLMXVTX1_COUNT_wire;
 wire MAXFLAG_CWF2_wire;
 
 wire [UARTSIZE-1:0]VECTOR1_wire;
 wire [UARTSIZE-1:0]VECTOR2_wire;
 wire [UARTSIZE-1:0]VECTOR3_wire;
 wire [UARTSIZE-1:0]VECTOR4_wire;
 wire [UARTSIZE-1:0]VECTOR5_wire;
 wire [UARTSIZE-1:0]VECTOR6_wire;
 wire [UARTSIZE-1:0]VECTOR7_wire;
 wire [UARTSIZE-1:0]VECTOR8_wire;
 
 wire [UARTSIZE-1:0] ONES_B1_wire;
 wire [UARTSIZE-1:0] TENS_B1_wire;
 wire [UARTSIZE-1:0] HUNDREDS_B1_wire;
 
 wire [UARTSIZE-1:0] ONES_B2_wire;
 wire [UARTSIZE-1:0] TENS_B2_wire;
 wire [UARTSIZE-1:0] HUNDREDS_B2_wire;
 
 wire [UARTSIZE-1:0] ONES_B3_wire;
 wire [UARTSIZE-1:0] TENS_B3_wire;
 wire [UARTSIZE-1:0] HUNDREDS_B3_wire;
 
 wire [UARTSIZE-1:0] ONES_B4_wire;
 wire [UARTSIZE-1:0] TENS_B4_wire;
 wire [UARTSIZE-1:0] HUNDREDS_B4_wire;
 
 wire [UARTSIZE-1:0] ONES_B5_wire;
 wire [UARTSIZE-1:0] TENS_B5_wire;
 wire [UARTSIZE-1:0] HUNDREDS_B5_wire;
 
 wire [UARTSIZE-1:0] ONES_B6_wire;
 wire [UARTSIZE-1:0] TENS_B6_wire;
 wire [UARTSIZE-1:0] HUNDREDS_B6_wire;
 
 wire [UARTSIZE-1:0] ONES_B7_wire;
 wire [UARTSIZE-1:0] TENS_B7_wire;
 wire [UARTSIZE-1:0] HUNDREDS_B7_wire;
 
 wire [UARTSIZE-1:0] ONES_B8_wire;
 wire [UARTSIZE-1:0] TENS_B8_wire;
 wire [UARTSIZE-1:0] HUNDREDS_B8_wire;
 
 wire [UARTSIZE-1:0] CTLSENDTX1_DATATX_wire;
 wire CTLSENDTX1_TRANS_wire;
 wire CTLSENDTX1_COUNT_wire;
 wire MAXFLAG_CWF3_wire;
 
 wire TX_wire;
 
 /*RECEIVER UART*///////////////////////////////////////////////
 
 UARTfullduplex_withCLKDIV #(8) UART1  
(
	/* Inputs */
	.Data(CTLSENDTX1_DATATX_wire),
	.Trans(CTLSENDTX1_TRANS_wire),
	.clk(clk),
	.reset(reset),
	.RX(RX),
	.clearInterrupt(clearFLAG_UART),
	
	/* Output */
	.TX(TX_wire),
	.ReceivedData(UART1_ReceivedData_wire),
	.RXInterrputFlag(UART1_RXInterrputFlag_wire),
	.PARITYERRORFlag(UART1_PARITYERRORFlag_wire)
	
);

 OrMR #(1) OR1
(
	.A(CTLSTU_CLEARFLAG_wire),
	.B(CTLLU_CLEARFLAG_wire),
	.C(CTLCMDU_CLEARFLAG_wire),
	.D(CTLNU_CLEARFLAG_wire),
	.E(CTLSTOPU_CLEARFLAG_wire),
	.F(CTLDATAU_CLEARFLAG_wire),
	
	.OUT(clearFLAG_UART)

);


Clock_Divider#(50000000,2500000) CLKDIVSYSTEM

(
	// Input Ports
	.clk(clk),
	.reset(reset),
	

	// Output Ports
	.clk_FPGA_out(clkOut)
);

/*START FRAME *//////////////////////////////////////////////////

 Ctl_Unit_StartField CTLSTU

(
	//Inputs
	.clk(clkOut),
	.reset(reset),
	.RXINT(UART1_RXInterrputFlag_wire),
	.VALIDSTART(AND1_VALIDSTART_wire),
	.UNLOCKME(UNLOCKPASTFLAG_CTLLU_wire),
	
	//Outputs
	.INITFLAG1(CTLSTU_INITFLAG1_wire),
	.INITFLAG2(CTLSTU_INITFLAG2_wire),
	.VALIDSTARTFLAG(CTLSTU_VALIDSTARTFLAG_wire),
	.CLEARFLAG(CTLSTU_CLEARFLAG_wire),
	.LOCKEDFLAG(LOCKEDFLAG_CTLSTU_wire)
	
);


 Register #(8) REGST1
(
	// Input Ports
	.clk(clkOut),
	.reset(reset),
	.enable(CTLSTU_INITFLAG1_wire),
	.sys_reset(1'b0),
	.Data_Input(UART1_ReceivedData_wire),

	// Output Ports
	.Data_Output(REGST1_ReceivedData_wire)
);


 Register #(8) REGST2
(
	// Input Ports
	.clk(clkOut),
	.reset(reset),
	.enable(CTLSTU_INITFLAG2_wire),
	.sys_reset(1'b0),
	.Data_Input(UART1_ReceivedData_wire),

	// Output Ports
	.Data_Output(REGST2_ReceivedData_wire)
);

 ComparadorR #(8) COMPF
(
	/* Inputs */
	.A(REGST1_ReceivedData_wire),
	.B(8'd70),
	
	/* Outputs */
	.C(COMPF_VALIDSTART_wire)
	
);

 ComparadorR #(8) COMPE
(
	/* Inputs */
	.A(REGST2_ReceivedData_wire),
	.B(8'd69),
	
	/* Outputs */
	.C(COMPE_VALIDSTART_wire)
	
);


 AndM #(1) AND1
(
	.A(~COMPF_VALIDSTART_wire),
	.B(~COMPE_VALIDSTART_wire),
	
	.OUT(AND1_VALIDSTART_wire)

);


/*LENGTH FRAME *//////////////////////////////////////////////////

Ctl_Unit_LField CTLLU

(
	//Inputs
	.clk(clkOut),
	.reset(reset),
	.RXINT(UART1_RXInterrputFlag_wire),
	.VALIDSTART(CTLSTU_VALIDSTARTFLAG_wire),
	.UNLOCKME(UNLOCKPASTFLAG_CTLCMDU_wire),
	
	//Outputs
	.INITFLAG1(CTLLU_INITFLAG1_wire),
	.INITFLAG2(CTLLU_INITFLAG2_wire),
	.VALIDLENGTHFLAG(CTLLU_VALIDLENGTHFLAG_wire),
	.CLEARFLAG(CTLLU_CLEARFLAG_wire),
	.LOCKEDFLAG(LOCKEDFLAG_CTLLU_wire),
	.UNLOCKPASTFLAG(UNLOCKPASTFLAG_CTLLU_wire)
	
);

Register #(8) REGL1
(
	// Input Ports
	.clk(clkOut),
	.reset(reset),
	.enable(CTLLU_INITFLAG1_wire),
	.sys_reset(1'b0),
	.Data_Input(UART1_ReceivedData_wire),

	// Output Ports
	.Data_Output(REGL1_ReceivedData_wire)
);


 Register #(8) REGL2
(
	// Input Ports
	.clk(clkOut),
	.reset(reset),
	.enable(CTLLU_INITFLAG2_wire),
	.sys_reset(1'b0),
	.Data_Input(UART1_ReceivedData_wire),

	// Output Ports
	.Data_Output(REGL2_ReceivedData_wire)
);


 ASCIIConverter ACII1
(
	.A(REGL1_ReceivedData_wire),
	.B(REGL2_ReceivedData_wire),
	
	.OUT(ACII1_L_wire)

);

/*CMD FRAME *//////////////////////////////////////////////////

Ctl_Unit_CMDField CTLCMDU

(
	//Inputs
	.clk(clkOut),
	.reset(reset),
	.RXINT(UART1_RXInterrputFlag_wire),
	.VALIDLENGTH(CTLLU_VALIDLENGTHFLAG_wire),
	.VALIDCMDVAL(ACII1_CMD_wire),
	.UNLOCKME_N_DATA(UNLOCKPASTFLAG_CTLNU_wire&UNLOCKPASTFLAG_CTLDATAU_wire),
	.UNLOCKME_PREPARE_RETR(UNLOCKPASTFLAG_CTLSTOPU_wire),
	
	//Outputs
	.INITFLAG1(CTLCMDU_INITFLAG1_wire),
	.INITFLAG2(CTLCMDU_INITFLAG2_wire),
	.VALIDNFLAG(CTLCMDU_VALIDNFLAG_wire),
	.VALIDDATAFLAG(CTLCMDU_VALIDDATAFLAG_wire),
	.VALIDPREPARFLAG(CTLCMDU_VALIDPREPARFLAG_wire),
	.VALIDRETRFLAG(CTLCMDU_VALIDRETRFLAG_wire),
	.CLEARFLAG(CTLCMDU_CLEARFLAG_wire),
	.LOCKED_N_DATA_FLAG(LOCKED_N_DATA_FLAG_CTLCMDU_wire),
	.LOCKED_PREPARE_RETR_FLAG(LOCKED_PREPARE_RETR_FLAG_CTLCMDU_wire),
	.UNLOCKPASTFLAG(UNLOCKPASTFLAG_CTLCMDU_wire)
	
);

Register #(8) REGCMD1
(
	// Input Ports
	.clk(clkOut),
	.reset(reset),
	.enable(CTLCMDU_INITFLAG1_wire),
	.sys_reset(1'b0),
	.Data_Input(UART1_ReceivedData_wire),

	// Output Ports
	.Data_Output(REGCMD1_ReceivedData_wire)
);


 Register #(8) REGCMD2
(
	// Input Ports
	.clk(clkOut),
	.reset(reset),
	.enable(CTLCMDU_INITFLAG2_wire),
	.sys_reset(1'b0),
	.Data_Input(UART1_ReceivedData_wire),

	// Output Ports
	.Data_Output(REGCMD2_ReceivedData_wire)
);


 ASCIIConverter ACII2
(
	.A(REGCMD1_ReceivedData_wire),
	.B(REGCMD2_ReceivedData_wire),
	
	.OUT(ACII1_CMD_wire)

);
 
 /*N FRAME *//////////////////////////////////////////////////
Ctl_Unit_LField CTLNU

(
	//Inputs
	.clk(clkOut),
	.reset(reset),
	.RXINT(UART1_RXInterrputFlag_wire),
	.VALIDSTART(CTLCMDU_VALIDNFLAG_wire),
	.UNLOCKME(UNLOCKPASTFLAG_CTLSTOPU_wire),
	
	//Outputs
	.INITFLAG1(CTLNU_INITFLAG1_wire),
	.INITFLAG2(CTLNU_INITFLAG2_wire),
	.VALIDLENGTHFLAG(CTLNU_VALIDNFLAG_wire),
	.CLEARFLAG(CTLNU_CLEARFLAG_wire),
	.LOCKEDFLAG(LOCKEDFLAG_CTLNU_wire),
	.UNLOCKPASTFLAG(UNLOCKPASTFLAG_CTLNU_wire)
	
);

Register #(8) REGN1
(
	// Input Ports
	.clk(clkOut),
	.reset(reset),
	.enable(CTLNU_INITFLAG1_wire),
	.sys_reset(1'b0),
	.Data_Input(UART1_ReceivedData_wire),

	// Output Ports
	.Data_Output(REGN1_ReceivedData_wire)
);


 Register #(8) REGN2
(
	// Input Ports
	.clk(clkOut),
	.reset(reset),
	.enable(CTLNU_INITFLAG2_wire),
	.sys_reset(1'b0),
	.Data_Input(UART1_ReceivedData_wire),

	// Output Ports
	.Data_Output(REGN2_ReceivedData_wire)
);


 ASCIIConverter ACII3
(
	.A(REGN1_ReceivedData_wire),
	.B(REGN2_ReceivedData_wire),
	
	.OUT(ACII3_N_wire)

);


/*DATA FRAME *//////////////////////////////////////////////////
Ctl_Unit_DATAField CTLDATAU

(
	//Inputs
	.clk(clkOut),
	.reset(reset),
	.RXINT(UART1_RXInterrputFlag_wire),
	.VALIDCMD(CTLCMDU_VALIDDATAFLAG_wire),
	.MAXREACH(CTLDATAU_MAXREACH_wire),
	.UNLOCKME(UNLOCKPASTFLAG_CTLSTOPU_wire),
	
	//Outputs
	.INITFLAG1(CTLDATAU_INITFLAG1_wire),
	.INITFLAG2(CTLDATAU_INITFLAG2_wire),
	.COUNTFLAG(CTLDATAU_COUNTFLAG_wire),
	.DONECOUNTFLAG(CTLDATAU_DONECOUNTFLAG_wire),
	.CLEARFLAG(CTLDATAU_CLEARFLAG_wire),
	.LOCKEDFLAG(LOCKEDFLAG_CTLDATAU_wire),
	.UNLOCKPASTFLAG(UNLOCKPASTFLAG_CTLDATAU_wire)
	
);

 CounterWithFunction_INPUT #(255) CWF1

(
	// Input Ports
	.clk(clkOut),
	.reset(reset),
	.sys_rst(CTLDATAU_DONECOUNTFLAG_wire),
	.enable(CTLDATAU_COUNTFLAG_wire),
	.MAXVAL(ACII1_L_wire),
	
	// Output Ports
	.flag(CTLDATAU_MAXREACH_wire),
	.CountOut() 
);

Register #(8) REGDATA1
(
	// Input Ports
	.clk(clkOut),
	.reset(reset),
	.enable(CTLDATAU_INITFLAG1_wire),
	.sys_reset(1'b0),
	.Data_Input(UART1_ReceivedData_wire),

	// Output Ports
	.Data_Output(REGDATA1_ReceivedData_wire)
);


 Register #(8) REGDATA2
(
	// Input Ports
	.clk(clkOut),
	.reset(reset),
	.enable(CTLDATAU_INITFLAG2_wire),
	.sys_reset(1'b0),
	.Data_Input(UART1_ReceivedData_wire),

	// Output Ports
	.Data_Output(REGDATA2_ReceivedData_wire)
);


 ASCIIConverter ACII4
(
	.A(REGDATA1_ReceivedData_wire),
	.B(REGDATA2_ReceivedData_wire),
	
	.OUT(ACII4_DATA_wire)

);

/*STOP FRAME *//////////////////////////////////////////////////
	
 Ctl_Unit_StopField CTLSTOPU

(
	//Inputs
	.clk(clkOut),
	.reset(reset),
	.RXINT(UART1_RXInterrputFlag_wire),
	.VALIDOP(VALID_OPFLAG_wire),
	.VALIDSTOP(AND2_VALIDSTOP_wire),
	
	//Outputs
	.INITFLAG1(CTLSTOPU_INITFLAG1_wire),
	.INITFLAG2(CTLSTOPU_INITFLAG2_wire),
	.VALIDSTOPFLAG(CTLSTOPU_VALIDSTOPFLAG_wire),
	.CLEARFLAG(CTLSTOPU_CLEARFLAG_wire),
	.UNLOCKPASTFLAG(UNLOCKPASTFLAG_CTLSTOPU_wire)
	
);
	
	 OrMR #(1) OR2
(
	.A(CTLCMDU_VALIDPREPARFLAG_wire),
	.B(CTLCMDU_VALIDRETRFLAG_wire),
	.C(CTLNU_VALIDNFLAG_wire),
	.D(CTLDATAU_DONECOUNTFLAG_wire),
	.E(1'b0),
	.F(1'b0),
	
	.OUT(VALID_OPFLAG_wire)

);


 Register #(8) REGSTOP1
(
	// Input Ports
	.clk(clkOut),
	.reset(reset),
	.enable(CTLSTOPU_INITFLAG1_wire),
	.sys_reset(1'b0),
	.Data_Input(UART1_ReceivedData_wire),

	// Output Ports
	.Data_Output(REGSTOP1_ReceivedData_wire)
);


 Register #(8) REGSTOP2
(
	// Input Ports
	.clk(clkOut),
	.reset(reset),
	.enable(CTLSTOPU_INITFLAG2_wire),
	.sys_reset(1'b0),
	.Data_Input(UART1_ReceivedData_wire),

	// Output Ports
	.Data_Output(REGSTOP2_ReceivedData_wire)
);

 ComparadorR #(8) COMPESTOP
(
	/* Inputs */
	.A(REGSTOP1_ReceivedData_wire),
	.B(8'd69),
	
	/* Outputs */
	.C(COMPE_VALIDSTOP_wire)
	
);

 ComparadorR #(8) COMPFSTOP
(
	/* Inputs */
	.A(REGSTOP2_ReceivedData_wire),
	.B(8'd70),
	
	/* Outputs */
	.C(COMPF_VALIDSTOP_wire)
	
);


 AndM #(1) AND2
(
	.A(~COMPE_VALIDSTOP_wire),
	.B(~COMPF_VALIDSTOP_wire),
	
	.OUT(AND2_VALIDSTOP_wire)

);


/*FIFO RECIEVE*/////////////////////////////////////////////////////////

 FIFO #(8, 7) FIFORECIVER
(
	/* Inputs */
	.clk(clkOut),
	.reset(reset),
	.DataInput(ACII4_DATA_wire),
	.push(CTLDATAU_COUNTFLAG_wire),
	.pop(FIFO_EXTRACT_wire), 
	
	/* Output */
	.full(),
	.empty(),
	.DataOutput(Data_Input_MDR_wire)
);


 MxV #( 8) MxV1
(
	// Inputs
	.clk(clkOut),
	.reset(reset),
	.Data(Data_Input_MDR_wire),
	.N(ACII3_N_wire),
	
	.N_Valid(CTLNU_VALIDNFLAG_wire),
	.Prep_Valid(CTLCMDU_VALIDPREPARFLAG_wire),
	.Data_Valid(CTLCMDU_VALIDDATAFLAG_wire),
	.Stop(CTLSTOPU_VALIDSTOPFLAG_wire),
	
	// Outputs
	.pop_outside(FIFO_EXTRACT_wire),
	.send(Send_wire),
	.result(Result_wire)
);

 Register #(8) RESULTREG1
(
	// Input Ports
	.clk(clkOut),
	.reset(reset),
	.enable(1'b1),
	.sys_reset(1'b0),
	.Data_Input(Result_wire),

	// Output Ports
	.Data_Output(ResultREG_wire)
);




/*UART TX*/////////////////////////////////////////

 Ctl_Unit_MXVtoTX CTLMXVTX1

(
	//Inputs
	.clk(clkOut),
	.reset(reset),
	.PULSE(Send_wire),
	.N(ACII3_N_wire),
	.MAXFLAG(MAXFLAG_CWF2_wire),
	
	//Outputs
	.CAPTURE1FLAG(CAPTURE1FLAG_wire),
	.CAPTURE2FLAG(CAPTURE2FLAG_wire),
	.CAPTURE3FLAG(CAPTURE3FLAG_wire),
	.CAPTURE4FLAG(CAPTURE4FLAG_wire),
	.CAPTURE5FLAG(CAPTURE5FLAG_wire),
	.CAPTURE6FLAG(CAPTURE6FLAG_wire),
	.CAPTURE7FLAG(CAPTURE7FLAG_wire),
	.CAPTURE8FLAG(CAPTURE8FLAG_wire),
	.COUNT(CTLMXVTX1_COUNT_wire)
	
);

CounterWithFunction_INPUT #(32) CWF2

(
	// Input Ports
	.clk(clkOut),
	.reset(reset),
	.sys_rst(CAPTURE1FLAG_wire),
	.enable(CTLMXVTX1_COUNT_wire),
	.MAXVAL(5'd30),
	
	// Output Ports
	.flag(MAXFLAG_CWF2_wire),
	.CountOut() 
);

 Register #(8) VECTORREG1
(
	// Input Ports
	.clk(clkOut),
	.reset(reset),
	.enable(CAPTURE1FLAG_wire),
	.sys_reset(CTLDATAU_DONECOUNTFLAG_wire),
	.Data_Input(ResultREG_wire),

	// Output Ports
	.Data_Output(VECTOR1_wire)
);

 Register #(8) VECTORREG2
(
	// Input Ports
	.clk(clkOut),
	.reset(reset),
	.enable(CAPTURE2FLAG_wire),
	.sys_reset(CTLDATAU_DONECOUNTFLAG_wire),
	.Data_Input(ResultREG_wire),

	// Output Ports
	.Data_Output(VECTOR2_wire)
);

 Register #(8) VECTORREG3
(
	// Input Ports
	.clk(clkOut),
	.reset(reset),
	.enable(CAPTURE3FLAG_wire),
	.sys_reset(CTLDATAU_DONECOUNTFLAG_wire),
	.Data_Input(ResultREG_wire),

	// Output Ports
	.Data_Output(VECTOR3_wire)
);

 Register #(8) VECTORREG4
(
	// Input Ports
	.clk(clkOut),
	.reset(reset),
	.enable(CAPTURE4FLAG_wire),
	.sys_reset(CTLDATAU_DONECOUNTFLAG_wire),
	.Data_Input(ResultREG_wire),

	// Output Ports
	.Data_Output(VECTOR4_wire)
);

 Register #(8) VECTORREG5
(
	// Input Ports
	.clk(clkOut),
	.reset(reset),
	.enable(CAPTURE5FLAG_wire),
	.sys_reset(CTLDATAU_DONECOUNTFLAG_wire),
	.Data_Input(ResultREG_wire),

	// Output Ports
	.Data_Output(VECTOR5_wire)
);

 Register #(8) VECTORREG6
(
	// Input Ports
	.clk(clkOut),
	.reset(reset),
	.enable(CAPTURE6FLAG_wire),
	.sys_reset(CTLDATAU_DONECOUNTFLAG_wire),
	.Data_Input(ResultREG_wire),

	// Output Ports
	.Data_Output(VECTOR6_wire)
);

 Register #(8) VECTORREG7
(
	// Input Ports
	.clk(clkOut),
	.reset(reset),
	.enable(CAPTURE7FLAG_wire),
	.sys_reset(CTLDATAU_DONECOUNTFLAG_wire),
	.Data_Input(ResultREG_wire),

	// Output Ports
	.Data_Output(VECTOR7_wire)
);

 Register #(8) VECTORREG8
(
	// Input Ports
	.clk(clkOut),
	.reset(reset),
	.enable(CAPTURE8FLAG_wire),
	.sys_reset(CTLDATAU_DONECOUNTFLAG_wire),
	.Data_Input(ResultREG_wire),

	// Output Ports
	.Data_Output(VECTOR8_wire)
);

 Binary_Decoder B1(
	
	//Input Ports
	.In_Bits(VECTOR1_wire),
	
	//Output Ports
	.ONES(ONES_B1_wire), 
	.TENS(TENS_B1_wire),
	.HUNDREDS(HUNDREDS_B1_wire)
);

 Binary_Decoder B2(
	
	//Input Ports
	.In_Bits(VECTOR2_wire),
	
	//Output Ports
	.ONES(ONES_B2_wire), 
	.TENS(TENS_B2_wire),
	.HUNDREDS(HUNDREDS_B2_wire)
);

 Binary_Decoder B3(
	
	//Input Ports
	.In_Bits(VECTOR3_wire),
	
	//Output Ports
	.ONES(ONES_B3_wire), 
	.TENS(TENS_B3_wire),
	.HUNDREDS(HUNDREDS_B3_wire)
);

 Binary_Decoder B4(
	
	//Input Ports
	.In_Bits(VECTOR4_wire),
	
	//Output Ports
	.ONES(ONES_B4_wire), 
	.TENS(TENS_B4_wire),
	.HUNDREDS(HUNDREDS_B4_wire)
);

 Binary_Decoder B5(
	
	//Input Ports
	.In_Bits(VECTOR5_wire),
	
	//Output Ports
	.ONES(ONES_B5_wire), 
	.TENS(TENS_B5_wire),
	.HUNDREDS(HUNDREDS_B5_wire)
);

 Binary_Decoder B6(
	
	//Input Ports
	.In_Bits(VECTOR6_wire),
	
	//Output Ports
	.ONES(ONES_B6_wire), 
	.TENS(TENS_B6_wire),
	.HUNDREDS(HUNDREDS_B6_wire)
);

 Binary_Decoder B7(
	
	//Input Ports
	.In_Bits(VECTOR7_wire),
	
	//Output Ports
	.ONES(ONES_B7_wire), 
	.TENS(TENS_B7_wire),
	.HUNDREDS(HUNDREDS_B7_wire)
);

 Binary_Decoder B8(
	
	//Input Ports
	.In_Bits(VECTOR8_wire),
	
	//Output Ports
	.ONES(ONES_B8_wire), 
	.TENS(TENS_B8_wire),
	.HUNDREDS(HUNDREDS_B8_wire)
);


 Ctl_Unit_SENDTX	CTLSENDTX1

(
	//Inputs
	.clk(clkOut),
	.reset(reset),
	.W1(CTLMXVTX1_COUNT_wire),
	.ONES_B1(ONES_B1_wire),
	.TENS_B1(TENS_B1_wire),
	.HUNDREDS_B1(HUNDREDS_B1_wire),
	.ONES_B2(ONES_B2_wire),
	.TENS_B2(TENS_B2_wire),
	.HUNDREDS_B2(HUNDREDS_B2_wire),
	.ONES_B3(ONES_B3_wire),
	.TENS_B3(TENS_B3_wire),
	.HUNDREDS_B3(HUNDREDS_B3_wire),
	.ONES_B4(ONES_B4_wire),
	.TENS_B4(TENS_B4_wire),
	.HUNDREDS_B4(HUNDREDS_B4_wire),
	.ONES_B5(ONES_B5_wire),
	.TENS_B5(TENS_B5_wire),
	.HUNDREDS_B5(HUNDREDS_B5_wire),
	.ONES_B6(ONES_B6_wire),
	.TENS_B6(TENS_B6_wire),
	.HUNDREDS_B6(HUNDREDS_B6_wire),
	.ONES_B7(ONES_B7_wire),
	.TENS_B7(TENS_B7_wire),
	.HUNDREDS_B7(HUNDREDS_B7_wire),
	.ONES_B8(ONES_B8_wire),
	.TENS_B8(TENS_B8_wire),
	.HUNDREDS_B8(HUNDREDS_B8_wire),
	.MAXFLAG(MAXFLAG_CWF3_wire),
	
	//Outputs
	.COUNT(CTLSENDTX1_COUNT_wire),
	.DATATX(CTLSENDTX1_DATATX_wire),
	.TRANS(CTLSENDTX1_TRANS_wire)
	
	
);

CounterWithFunction_INPUT #(32) CWF3

(
	// Input Ports
	.clk(clkOut),
	.reset(reset),
	.sys_rst(CTLSENDTX1_TRANS_wire),
	.enable(CTLSENDTX1_COUNT_wire),
	.MAXVAL(5'd20),
	
	// Output Ports
	.flag(MAXFLAG_CWF3_wire),
	.CountOut() 
);

assign LOCKEDST= LOCKEDFLAG_CTLSTU_wire;
assign LOCKEDL= LOCKEDFLAG_CTLLU_wire;
assign LOCKEDCMD_N_DATA= LOCKED_N_DATA_FLAG_CTLCMDU_wire;
assign LOCKEDCMD_PREPARE_RET= LOCKED_PREPARE_RETR_FLAG_CTLCMDU_wire;
assign LOCKEDN= (LOCKEDFLAG_CTLNU_wire|LOCKEDFLAG_CTLDATAU_wire);
assign TX = TX_wire;


endmodule
