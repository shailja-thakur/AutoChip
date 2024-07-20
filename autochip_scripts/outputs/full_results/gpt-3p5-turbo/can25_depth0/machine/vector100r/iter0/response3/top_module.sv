module top_module (
	input [99:0] in,
	output reg [99:0] out
);

	always_comb begin
		out = 0; // Resetting the output register
		for (int i=0; i<$bits(out); i=i+1) begin
			out[i] = in[$bits(in)-i-1]; // Reversing the bits of the input
		end
	end

endmodule
