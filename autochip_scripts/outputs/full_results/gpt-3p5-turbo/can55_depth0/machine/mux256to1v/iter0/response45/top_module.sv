module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	// Declare internal variables
	reg [9:0] index;
	reg [1023:0] block;

	// Calculate index
	always @(*) begin
		index = sel * 4;
	end

	// Extract block from input vector
	always @(*) begin
		block = in[index +: 4];
	end

	// Assign output
	assign out = block;

endmodule
