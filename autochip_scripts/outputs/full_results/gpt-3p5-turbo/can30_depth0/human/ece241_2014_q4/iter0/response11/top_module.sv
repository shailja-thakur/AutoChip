module top_module (
	input clk,
	input x,
	output z
);
	reg d1, d2, d3;
	assign d1 = x ^ d1;
	assign d2 = ~d2 & x;
	assign d3 = ~d3 | x;
	assign z = ~(d1 ^ d2 ^ d3);
	
	always @(posedge clk) begin
		d1 <= d1;
		d2 <= d2;
		d3 <= d3;
	end
endmodule
