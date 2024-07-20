module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	 reg [8:0] result;   // Register to store the result of addition, including overflow bit
	 wire overflow;      // Output wire for overflow detection

	 always @* begin
	 	result = a + b;
	 	overflow = (result[8] == 1);   // Check if MSB of result is 1 for overflow detection
	 end

	 assign s = result[7:0];    // Assign the lower 8 bits of result to s

endmodule
