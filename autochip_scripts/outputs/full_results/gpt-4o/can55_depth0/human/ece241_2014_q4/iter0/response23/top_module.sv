module top_module (
	input clk,
	input x,
	output z
);

	wire d1, d2, d3;
	reg q1, q2, q3;

	// XOR gate with x and q1
	assign d1 = x ^ q1;

	// AND gate with x and ~q2
	assign d2 = x & ~q2;

	// OR gate with x and ~q3
	assign d3 = x | ~q3;

	// D flip-flops with asynchronous reset (initial states are 0)
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q1 <= 1'b0;
			q2 <= 1'b0;
			q3 <= 1'b0;
		end
		else begin
			q1 <= d1;
			q2 <= d2;
			q3 <= d3;
		end
	end

	// 3-input XNOR gate
	assign z = ~(q1 ^ q2 ^ q3);

endmodule
