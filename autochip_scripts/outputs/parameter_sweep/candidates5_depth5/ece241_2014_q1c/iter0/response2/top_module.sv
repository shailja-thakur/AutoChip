module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Intermediate variables
	reg [7:0] sum;
	reg carry_in;
	reg carry_out;
	reg overflow;

	// Assignments for sum and carry_in
	assign sum = a + b;
	assign carry_in = a[7] & b[7];

	// Carry out and overflow calculation
	always @*
	begin
		carry_out = sum[8] | (sum[7] & carry_in);
		overflow = (a[7] == b[7] && sum[7] != a[7]) ? 1 : 0;
	end

	// Assignments for s and overflow outputs
	assign s = sum[7:0];
	assign overflow = (carry_in == carry_out) ? overflow : ~overflow;

endmodule
