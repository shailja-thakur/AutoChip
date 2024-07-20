module top_module (
	input [99:0] in,
	output reg [99:0] out
);
	
	// Use a for loop to iterate through each bit of the input vector	
	// Assign the corresponding bit of the input vector to the output vector in reverse order	
	// Reverse bit ordering logic
	always @(in) begin
		for (integer i = 0; i < 100; i = i + 1) begin
			out[i] = in[99 - i];
		end
	end
	
endmodule
