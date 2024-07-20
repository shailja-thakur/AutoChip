module top_module (
	input [7:0] in,
	output [2:0] pos
);

reg [7:0] in_temp;
always @ (*) begin
	in_temp = in;
	pos = 3'b0;
	if (in_temp[0] == 1'b1) pos = 3'b0;
	else if (in_temp[1] == 1'b1) pos = 3'b1;
	else if (in_temp[2] == 1'b1) pos = 3'b2;
	else if (in_temp[3] == 1'b1) pos = 3'b3;
	else if (in_temp[4] == 1'b1) pos = 3'b4;
	else if (in_temp[5] == 1'b1) pos = 3'b5;
	else if (in_temp[6] == 1'b1) pos = 3'b6;
	else if (in_temp[7] == 1'b1) pos = 3'b7;
	end
endmodule
