module top_module (
	input clk,
	input x,
	output z
);
	reg d1, d2, d3;
	wire d1_comp, d2_comp, d3_comp;
	assign d1_comp = ~d1;
	assign d2_comp = ~d2;
	assign d3_comp = ~d3;
	assign z = ~(d1 ^ d2 ^ d3);
	
	always @(posedge clk) begin
		d1 <= x ^ d1;
		d2 <= d1_comp & d2;
		d3 <= d3_comp | d3;
	end
	
endmodule
