module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:1] out_any,
	output [3:0] out_different
);

	reg [3:0] in_shifted; // shift left version of input vector
	reg [3:0] in_wrapped; // wrap around version of input vector

	always @* begin
		in_shifted[0] = in[3]; // shift left, last bit wraps around to first bit
		in_shifted[1] = in[0];
		in_shifted[2] = in[1];
		in_shifted[3] = in[2];

		in_wrapped[0] = in[3]; // wrap around, last bit wraps around to first bit
		in_wrapped[1] = in[0];
		in_wrapped[2] = in[1];
		in_wrapped[3] = in[2];
	end

	assign out_both[0] = in[0] & in_shifted[0];
	assign out_both[1] = in[1] & in_shifted[1];
	assign out_both[2] = in[2] & in_shifted[2];

	assign out_any[1] = in[1] | in[0];
	assign out_any[2] = in[2] | in[1];
	assign out_any[3] = in[3] | in[2];

	assign out_different[0] = in[0] != in_wrapped[0];
	assign out_different[1] = in[1] != in_wrapped[1];
	assign out_different[2] = in[2] != in_wrapped[2];
	assign out_different[3] = in[3] != in_wrapped[3];

endmodule
