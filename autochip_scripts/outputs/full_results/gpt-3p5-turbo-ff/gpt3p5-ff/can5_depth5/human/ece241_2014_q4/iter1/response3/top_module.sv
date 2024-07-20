module top_module (
	input clk,
	input x,
	output z
);
	reg d1, d2, d3 ;
	always @(posedge clk or x)
	begin
		if(x)
		begin
			d1 <= d1 ^ d1 ;
			d2 <= ~d2 & d2 ;
			d3 <= ~d3 | d3 ;
		end
		else
		begin
			d1 <= d1 ;
			d2 <= d2 ;
			d3 <= d3 ;
		end
	end
	assign z = ~(d1 ^ d2 ^ d3);
endmodule
