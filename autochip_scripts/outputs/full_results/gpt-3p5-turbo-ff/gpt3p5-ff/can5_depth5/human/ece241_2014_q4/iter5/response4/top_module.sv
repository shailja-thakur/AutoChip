module top_module (
	input clk,
	input x,
	output z
);
	reg d1, d2, d3 ;
	
	initial begin
		d1 = 1'b0;
		d2 = 1'b0;
		d3 = 1'b0;
	end
	
	always @(posedge clk)
	begin
		if (~x)
			begin
				d1 <= 1'b0;
				d2 <= 1'b0;
				d3 <= 1'b0;
			end
		else
			begin
				d1 <= x ^ d1 ;
				d2 <= ~d2 & ~d1 ;
				d3 <= ~d3 | d2 ;
			end
	end
	
	assign z = ~(d1 ^ d2 ^ d3);
endmodule
