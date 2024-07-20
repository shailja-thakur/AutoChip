module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	reg [98:0] in_left_shifted; // Shifted version of input vector by 1 bit to the left
	reg [99:1] in_right_shifted; // Shifted version of input vector by 1 bit to the right

	// Generate shifted versions of the input vector
	always @(*) begin
		in_left_shifted[98] = 1'b0; // Since in[99] has no neighbour to the left, it is always 0
		for (int i = 0; i < 98; i = i + 1) begin
			in_left_shifted[i] = in[i+1];
		end

		for (int i = 0; i < 99; i = i + 1) begin
			in_right_shifted[i] = in[i];
		end
		in_right_shifted[99] = 1'b0; // Since in[0] has no neighbour to the right, it is always 0
	end

	// (1) out_both
	assign out_both = in & in_left_shifted;

	// (2) out_any
	assign out_any = in | in_right_shifted[99:1];

	// (3) out_different
	assign out_different = in ^ in_left_shifted;

endmodule
