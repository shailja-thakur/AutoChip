module top_module (
	input [7:0] in,
	output reg [2:0] pos
);

always @* begin
	if (in[0] == 1'b1)
		pos = 3'b0;
	else if (in[1] == 1'b1)
		pos = 3'b1;
	else if (in[2] == 1'b1)
		pos = 3'b10;
	else if (in[3] == 1'b1)
		pos = 3'b11;
	else if (in[4] == 1'b1)
		pos = 3'b100;
	else if (in[5] == 1'b1)
		pos = 3'b101;
	else if (in[6] == 1'b1)
		pos = 3'b110;
	else if (in[7] == 1'b1)
		pos = 3'b111;
	else
		pos = 3'b000;
end

endmodule
