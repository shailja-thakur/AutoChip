module top_module (
	input clk,
	input x,
	output z
);
	reg d1, d2, d3;
	wire d1_not, d2_not, d3_not;
	assign d1_not = ~d1;
	assign d2_not = ~d2;
	assign d3_not = ~d3;
	
	assign z = ~(d1 ^ d2 ^ d3);
	
	always @(posedge clk) begin
		d1 <= x;
		d2 <= x & d1_not;
		d3 <= x | d2_not;
	end
endmodule
