module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	reg [9:0] start_index;
	reg [3:0] block;

	always @(*) begin
		start_index = sel << 2;
		block = in[start_index +: 4];
	end

	assign out = block;

endmodule
