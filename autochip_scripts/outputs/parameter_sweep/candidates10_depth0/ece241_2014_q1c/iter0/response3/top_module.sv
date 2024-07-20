module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	// Declare internal signals
	reg [8:0] sum;

	// Combinational logic to calculate sum and detect overflow
	assign {s, overflow} = a + b;

	// Always block to handle signed overflow
	always @(a, b) begin
		if ((a[7] == 1 && b[7] == 1 && s[7] == 0) || (a[7] == 0 && b[7] == 0 && s[7] == 1))
			overflow = 1;
		else
			overflow = 0;
	end

endmodule
