module top_module (
	input [254:0] in,
	output reg [7:0] out
);

	always @(*) begin
		out = 0; // Initialize the output to 0
		// Iterate through all bits of the input signal
		for (integer i = 0; i < 255; i = i + 1) begin
			out = out + in[i];
		end
	end

endmodule
