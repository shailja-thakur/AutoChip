module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Declare internal wires
	wire [8:0] temp_sum;
	
	// Declare internal variables
	reg [7:0] a_ext, b_ext;
	reg [8:0] sum_ext;
	reg overflow;
	
	// Extend the sign of the input numbers
	assign a_ext = {a[7], a};
	assign b_ext = {b[7], b};
	
	// Perform the addition using extended numbers
	assign temp_sum = a_ext + b_ext;
	
	// Check for overflow
	always @(*) begin
		if (temp_sum[8] != temp_sum[7])
			overflow = 1;
		else
			overflow = 0;
	end
	
	// Assign the 8-bit sum
	assign s = temp_sum[7:0];
	
endmodule
