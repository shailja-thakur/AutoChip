module top_module (
	input clk,
	input x,
	output z
);
	
	reg d1, d2, d3;    // D flip-flop outputs
	
	always @(posedge clk) begin
		d1 <= x ^ d1;
		d2 <= ~d2 & x;
		d3 <= ~d3 | x;
	end

	assign z = ~(d1 ^ d2 ^ d3);   // XNOR gate
	
endmodule
