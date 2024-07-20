module top_module (
	input clk,
	input x,
	output z
);
	reg d1, d2, d3 ;
	always @(posedge clk)
	begin
		d1 <= x ^ d1 ;
		d2 <= ~d2 & d1 ;
		d3 <= ~d3 | d2 ;
	end
	assign z = ~(d1 ^ d2 ^ d3);
endmodule
