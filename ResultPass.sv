module ResultPass
#(
	parameter Size=8
)
(
	input [Size-1:0] result1,
	input [Size-1:0] result2,
	input [Size-1:0] result3,
	input [Size-1:0] result4,
	
	input empty1,
	input empty2,
	input empty3,
	input empty4,
	
	output logic send,
	output logic [Size-1:0] result_send,
	output logic [Size-1:0] result_trash1,
	output logic [Size-1:0] result_trash2,
	output logic [Size-1:0] result_trash3
);



always_comb begin

	if(empty1 == 1'b1 && empty2 == 1'b0 && empty3 == 1'b0 && empty4 == 1'b0) begin
		result_send <= result1;
		result_trash1 <= result2;
		result_trash2 <= result3;
		result_trash3 <= result4;
		send <= 1'b1;
	end
	
	else
	
	if(empty1 == 1'b1 && empty2 == 1'b1 && empty3 == 1'b0 && empty4 == 1'b0) begin
		result_send <= result2;
		result_trash1 <= result1;
		result_trash2 <= result3;
		result_trash3 <= result4;
		send <= 1'b1;
	end
	
	if(empty1 == 1'b1 && empty2 == 1'b1 && empty3 == 1'b1 && empty4 == 1'b0) begin
		result_send <= result3;
		result_trash1 <= result1;
		result_trash2 <= result3;
		result_trash3 <= result4;
		send <= 1'b1;
	end
	
	if(empty1 == 1'b1 && empty2 == 1'b1 && empty3 == 1'b1 && empty4 == 1'b1) begin
		result_send <= result4;
		result_trash1 <= result2;
		result_trash2 <= result1;
		result_trash3 <= result3;
		send <= 1'b1;
	end
	
	else begin
		result_send <= 1'b0;
		result_trash1 <= 1'b0;
		result_trash2 <= 1'b0;
		result_trash3 <= 1'b0;
		send <= 1'b0;
	
	end

end



endmodule
