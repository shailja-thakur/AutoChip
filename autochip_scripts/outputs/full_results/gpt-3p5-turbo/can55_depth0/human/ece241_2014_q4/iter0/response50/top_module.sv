module top_module (
	input clk,
	input x,
	output z
);

	// Define three D flip-flops
	reg d1, d2, d3;

	// Output of D flip-flops connected to three-input XNOR
	assign z = ~(d1 ^ d2 ^ d3);

	// Connect input x to three different gates
	assign d1 = x ^ d1;
	assign d2 = ~(x & d2);
	assign d3 = ~(x | d3);

	// Clock signal
	always @(posedge clk)
	begin
		d1 <= d1;
		d2 <= d2;
		d3 <= d3;
	end
	
endmodule
