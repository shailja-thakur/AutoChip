module top_module (
	input clk,
	input x,
	output z
);

	// Define the D flip-flops
	reg d1, d2, d3;
	
	// Combinational logic
	assign d1 = x;
	assign d2 = ~d2;
	assign d3 = ~d3;
	
	// Output logic
	assign z = ~(d1 ^ d2 ^ d3);
	
	// Clock always block to trigger the flip-flops
	always @(posedge clk) begin
		d1 <= d1;
		d2 <= d2;
		d3 <= d3;
	end

endmodule
