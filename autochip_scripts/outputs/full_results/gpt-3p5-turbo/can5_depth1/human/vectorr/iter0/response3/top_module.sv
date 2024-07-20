module top_module (
	input [7:0] in,
	output [7:0] out
);
	
	// Use a loop to reverse the bit ordering
	// Iterate from MSB to LSB and assign the bits to the output vector in reverse order
	// Keep track of the iteration using a counter variable
	
	// Create a counter variable
	reg [2:0] counter;
	
	always @(*) begin
		// Reverse the bit ordering
		for (counter = 0; counter < 8; counter = counter + 1) begin
			out[counter] = in[7 - counter];
		end
	end
	
endmodule
