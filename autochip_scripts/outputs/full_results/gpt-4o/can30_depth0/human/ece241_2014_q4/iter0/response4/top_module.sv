module top_module (
	input clk,
	input x,
	output z
);
	// D flip-flop outputs
	reg q1, q2, q3;
	
	// D flip-flop inputs
	wire d1, d2, d3;
	
	// Intermediate XNOR input wires
	wire x1, x2, x3;
	
	// Logic for the gates connected to D flip-flop inputs
	assign d1 = x ^ q1;
	assign d2 = x & ~q2;
	assign d3 = x | ~q3;
	
	// D flip-flops
	always @(posedge clk) begin
		q1 <= d1;
		q2 <= d2;
		q3 <= d3;
	end
	
	// Logic for the XNOR gate
	assign x1 = q1;
	assign x2 = q2;
	assign x3 = q3;
	assign z = ~(x1 ^ x2 ^ x3);
	
endmodule
