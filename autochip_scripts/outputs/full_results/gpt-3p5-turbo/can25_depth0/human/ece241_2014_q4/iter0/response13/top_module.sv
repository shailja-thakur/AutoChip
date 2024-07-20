module top_module (
	input clk,
	input x,
	output z
);

	reg d1, d2, d3;     	// D flip-flops
	wire xnor_out;      	// Output of the XNOR gate

	assign z = xnor_out;	// Assigning XNOR gate output to 'z' output
	
	always @(posedge clk)	// Sequential circuit sensitive to clock edge
	begin
		// First D flip-flop
		d1 <= x ^ d1;
		
		// Second D flip-flop
		d2 <= ~d2 & d1;
		
		// Third D flip-flop
		d3 <= ~d3 | d2;
	end

	// XNOR Gate
	assign xnor_out = d1 ^ d2 ^ d3;

endmodule
