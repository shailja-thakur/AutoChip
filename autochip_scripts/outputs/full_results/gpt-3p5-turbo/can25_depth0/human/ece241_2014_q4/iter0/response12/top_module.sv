module top_module (
	input clk,
	input x,
	output z
);
	// Define three D flip-flops
	reg d1, d2, d3;
	
	// Define three intermediate wires
	wire w1, w2, w3;
	
	// Define the output wire
	wire z;
	
	// Assign inputs to flip-flops
	always @(posedge clk) begin
		d1 <= x ^ d1;
		d2 <= ~d2 & d1;
		d3 <= ~d3 | d1;
	end
	
	// Assign flip-flop outputs to intermediate wires
	assign w1 = d1;
	assign w2 = ~d2;
	assign w3 = ~d3;
	
	// Compute the output Z
	assign z = ~(w1 ^ w2 ^ w3);
endmodule
