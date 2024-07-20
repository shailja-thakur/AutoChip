module top_module (
	input [7:0] in,
	output reg [2:0] pos
);

	always @(*) begin
		if (in[0] == 1) pos = 0;
		else if (in[1] == 1) pos = 1;
		else if (in[2] == 1) pos = 2;
		else if (in[3] == 1) pos = 3;
		else if (in[4] == 1) pos = 4;
		else if (in[5] == 1) pos = 5;
		else if (in[6] == 1) pos = 6;
		else if (in[7] == 1) pos = 7;
		else pos = 8;
	end

endmodule
