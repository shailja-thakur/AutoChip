module top_module (
	input clk,
	input x,
	output z
);

	// Intermediate signals
	wire q1, q2, q3;
	wire d1, d2, d3;
	wire q1_bar, q2_bar, q3_bar;
	wire xnor_out;

	// D flip-flops definition
	dff dff1 ( .clk(clk), .d(d1), .q(q1) );
	dff dff2 ( .clk(clk), .d(d2), .q(q2) );
	dff dff3 ( .clk(clk), .d(d3), .q(q3) );

	// Complementary outputs of flip-flops
	assign q1_bar = ~q1;
	assign q2_bar = ~q2;
	assign q3_bar = ~q3;

	// Logic for D's input 
	assign d1 = x ^ q1;
	assign d2 = x & q2_bar;
	assign d3 = x | q3_bar;

	// Final XNOR output
	assign xnor_out = ~(q1 ^ q2 ^ q3);
	assign z = xnor_out;

endmodule
module dff (
	input clk,
	input d,
	output reg q
);
	always @(posedge clk) begin
		q <= d;
	end
endmodule
