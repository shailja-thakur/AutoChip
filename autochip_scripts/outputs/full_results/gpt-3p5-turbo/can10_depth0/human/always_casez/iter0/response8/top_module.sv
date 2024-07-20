module top_module (
	input [7:0] in,
	output reg [2:0] pos
);

always @(*) begin
	if (in[0] == 1) pos = 3'b000;
	else if (in[1] == 1) pos = 3'b001;
	else if (in[2] == 1) pos = 3'b010;
	else if (in[3] == 1) pos = 3'b011;
	else if (in[4] == 1) pos = 3'b100;
	else if (in[5] == 1) pos = 3'b101;
	else if (in[6] == 1) pos = 3'b110;
	else if (in[7] == 1) pos = 3'b111;
	else pos = 3'b000;
end

endmodule
