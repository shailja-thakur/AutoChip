module top_module (
	input [254:0] in,
	output reg [7:0] out
);

	integer i; // Define an integer for the loop index

	always @(*) begin
		out = 0; // Initialize the output to zero
		// Iterate through all bits in the input vector
		for (i = 0; i < 255; i = i + 1) begin
			out = out + in[i]; // Increment output by the value of the input bit
		end
	end

endmodule
