module top_module (
	input clk,
	input x,
	output z
);
	reg q1, q2, q3;
	wire d1, d2, d3;

	// D flip-flop 1
	assign d1 = x ^ q1;   // XOR gate
	always @(posedge clk) begin
		q1 <= d1;
	end

	// D flip-flop 2
	assign d2 = x & ~q2;  // AND gate
	always @(posedge clk) begin
		q2 <= d2;
	end

	// D flip-flop 3
	assign d3 = x | ~q3;  // OR gate
	always @(posedge clk) begin
		q3 <= d3;
	end

	// XNOR gate with 3 inputs
	assign z = ~(q1 ^ q2 ^ q3);

endmodule
