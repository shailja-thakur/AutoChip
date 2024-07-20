module top_module (
	input clk,
	input x,
	output z
);

	// Intermediate wires for flip-flop outputs
	wire q1, q2, q3;
	
	// Complemented outputs of the flip-flops
	wire nq1 = ~q1;
	wire nq2 = ~q2;
	wire nq3 = ~q3;
	
	// Inputs to the D flip-flops
	wire d1 = x ^ q1;
	wire d2 = x & nq2;
	wire d3 = x | nq3;
	
	// D flip-flops
	DFF ff1 (
		.clk(clk), 
		.d(d1), 
		.q(q1)
	);
	
	DFF ff2 (
		.clk(clk), 
		.d(d2), 
		.q(q2)
	);
	
	DFF ff3 (
		.clk(clk), 
		.d(d3), 
		.q(q3)
	);

	// Three-input XNOR gate
	assign z = ~(q1 ^ q2 ^ q3);

endmodule
module DFF (
	input clk,
	input d,
	output reg q
);
	always @(posedge clk) begin
		q <= d;
	end
endmodule
