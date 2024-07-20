module top_module (
	input clk,
	input x,
	output z
);

	reg d1, d2, d3;  // D flip-flops
	wire xor_out, and_out, or_out;  // Outputs of gates

	// XOR gate input
	assign xor_out = x ^ d1;

	// AND gate input
	assign and_out = x & ~d2;

	// OR gate input
	assign or_out = x | ~d3;

	// D flip-flops with synchronous reset (assumed to be initially reset to zero)
	always @(posedge clk) begin
		d1 <= xor_out;
		d2 <= and_out;
		d3 <= or_out;
	end

	// 3-input XNOR gate
	assign z = ~(d1 ^ d2 ^ d3);

endmodule
