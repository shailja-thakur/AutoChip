module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Declare internal variables
	reg [8:0] sum;

	// Perform the addition operation
	always @(*) begin
		sum = a + b;
	end

	// Determine if overflow has occurred
	assign overflow = (sum[8] != sum[7]);

	// Assign the result to the output
	assign s = sum[7:0];

endmodule
