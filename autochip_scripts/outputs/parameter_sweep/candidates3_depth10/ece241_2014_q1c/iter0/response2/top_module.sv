module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	// Internal wire to hold the intermediate value of sum
	wire [8:0] sum;
	
	// Internal wire to hold the overflow flag
	wire overflow_flag;
	
	// Assign the sum of a and b to the sum wire
	assign sum = a + b;
	
	// Check if overflow has occurred
	assign overflow_flag = (sum[8] != sum[7]);
	
	// Assign the output signals
	assign s = sum[7:0];
	assign overflow = overflow_flag;
endmodule
