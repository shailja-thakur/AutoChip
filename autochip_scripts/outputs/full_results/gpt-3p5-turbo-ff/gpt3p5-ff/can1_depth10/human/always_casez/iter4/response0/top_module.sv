module top_module (
	input [7:0] in,
	output reg [2:0] pos
);

	always @* begin
		casez (in)
			0: pos = 0;
			1: pos = 1;
			2: pos = 2;
			3: pos = 3;
			4: pos = 4;
			5: pos = 5;
			6: pos = 6;
			7: pos = 7;
			default: pos = 8;
		endcase
	end

endmodule
