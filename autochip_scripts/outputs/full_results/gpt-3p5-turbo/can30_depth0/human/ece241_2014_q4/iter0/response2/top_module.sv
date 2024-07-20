module top_module (
	input clk,
	input x,
	output z
);
	
	reg d1, d2, d3;	// D flip-flops
	
	assign z = (~(d1 ^ x)) ^ (~(d2 & ~d2)) ^ (~(d3 | ~d3));
	
	always @(posedge clk) begin
		d1 <= x;
		d2 <= ~d2;
		d3 <= ~d3;
	end
endmodule
