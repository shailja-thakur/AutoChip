module top_module (
	input [7:0] in,
	output reg [2:0] pos
);

	always @* begin
		case (in)
			8'b0000_0001: pos = 1;
			8'b0000_0010: pos = 2;
			8'b0000_0100: pos = 3;
			8'b0000_1000: pos = 4;
			8'b0001_0000: pos = 5;
			8'b0010_0000: pos = 6;
			8'b0100_0000: pos = 7;
			8'b1000_0000: pos = 8;
			default: pos = 0;
		endcase
	end

endmodule
