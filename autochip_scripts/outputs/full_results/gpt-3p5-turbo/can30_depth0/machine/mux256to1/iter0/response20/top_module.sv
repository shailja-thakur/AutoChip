module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

	reg [7:0] index;

	always @(sel) begin
		case(sel)
			8'b00000000: index = 0;
			8'b00000001: index = 1;
			8'b00000010: index = 2;
			8'b00000011: index = 3;
			8'b00000100: index = 4;
			8'b00000101: index = 5;
			8'b00000110: index = 6;
			8'b00000111: index = 7;
			default: index = 0;
		endcase
	end

	assign out = in[index];

endmodule
