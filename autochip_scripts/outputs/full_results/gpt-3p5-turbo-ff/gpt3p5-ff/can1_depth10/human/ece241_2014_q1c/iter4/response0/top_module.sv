module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Internal wires and registers
	wire [8:0] sum;
	reg [8:0] a_ext, b_ext;
	reg overflow_reg;

	// Extending the sign bit of a and b
	assign a_ext = {{8{a[7]}}, a};
	assign b_ext = {{8{b[7]}}, b};

	// Calculating the sum of a_ext and b_ext
	assign sum = a_ext + b_ext;

	// Checking for overflow
	always @* begin
		if (((a_ext[7:0] > 0) && (b_ext[7:0] > 0) && (sum[7:0] < 0)) ||
		    ((a_ext[7:0] < 0) && (b_ext[7:0] < 0) && (sum[7:0] >= 0))) begin
			overflow_reg = 1;
		end else begin
			overflow_reg = 0;
		end
	end

	// Assigning outputs
	assign s = sum[7:0];
	assign overflow = overflow_reg;

endmodule
