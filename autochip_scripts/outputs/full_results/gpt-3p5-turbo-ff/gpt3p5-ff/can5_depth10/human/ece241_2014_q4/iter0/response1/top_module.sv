module top_module (
	input clk,
	input x,
	output z
);

	reg d1, d2, d3;
	wire q1, q2, q3;

	// XOR gate
	xor xor_gate (x, q1, d1);
	
	// AND gate
	and and_gate (x, q2, d2);
	
	// OR gate
	or or_gate (x, q3, d3);
	
	// D flip-flops
	always @(posedge clk)
	begin
		d1 <= q1;
		d2 <= ~q2;
		d3 <= ~q3;
	end
	
	// XNOR gate
	xnor xnor_gate (q1, q2, q3, z);

endmodule
