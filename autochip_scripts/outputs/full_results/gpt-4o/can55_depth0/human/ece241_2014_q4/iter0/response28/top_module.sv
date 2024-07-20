module top_module (
	input clk,
	input x,
	output z
);

	// Internal signals
	reg q1, q2, q3;
	wire xor_out, and_out, or_out;
	wire q1_bar, q2_bar, q3_bar;
	wire xn1, xn2, xn3;

	// Combinational logic
	assign q1_bar = ~q1;
	assign q2_bar = ~q2;
	assign q3_bar = ~q3;
	
	assign xor_out = x ^ q1;
	assign and_out = x & q2_bar;
	assign or_out = x | q3_bar;

	always @(posedge clk) begin
		// Sequential logic
		q1 <= xor_out;
		q2 <= and_out;
		q3 <= or_out;
	end
	
	// XNOR logic
	assign xn1 = ~(q1 ^ q2 ^ q3);
	assign z = xn1;

endmodule
