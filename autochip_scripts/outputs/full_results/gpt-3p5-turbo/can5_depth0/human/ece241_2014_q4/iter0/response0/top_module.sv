module top_module (
	input clk,
	input x,
	output z
);
	// Define D flip-flops
	reg d1, d2, d3;
	// Define flip-flop outputs
	wire q1, q2, q3;
	// Define gate outputs
	wire x_xor_q1, x_and_not_q2, x_or_not_q3;
	
	// Define D flip-flops
	always @(posedge clk) begin
		if (reset) begin
			d1 <= 0;
			d2 <= 0;
			d3 <= 0;
		end else begin
			d1 <= x;
			d2 <= x;
			d3 <= x;
		end
	end
	
	// Define gate outputs
	assign x_xor_q1 = x ^ q1;
	assign x_and_not_q2 = x & ~q2;
	assign x_or_not_q3 = x | ~q3;
	
	// Define XNOR gate
	assign z = ~(x_xor_q1 ^ x_and_not_q2 ^ x_or_not_q3);
	
endmodule
