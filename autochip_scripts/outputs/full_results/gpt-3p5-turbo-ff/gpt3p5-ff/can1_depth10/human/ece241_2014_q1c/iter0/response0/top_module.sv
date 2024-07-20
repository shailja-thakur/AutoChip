module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Internal wires and registers
	wire [8:0] sum;
	reg overflow_reg;

	// Calculating the sum of a and b
	assign sum = a + b;

	// Checking for overflow
	always @* begin
		if ((a[7] == b[7]) && (sum[8] != a[7])) begin
			overflow_reg = 1;
		end else begin
			overflow_reg = 0;
		end
	end

	// Assigning outputs
	assign s = sum[7:0];
	assign overflow = overflow_reg;

endmodule
