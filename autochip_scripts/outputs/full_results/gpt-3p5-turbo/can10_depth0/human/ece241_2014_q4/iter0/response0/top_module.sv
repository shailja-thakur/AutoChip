module top_module (
	input clk,
	input x,
	output z
);
	reg d1, d2, d3;
	wire xor1, and1, or1;
	assign xor1 = x ^ d1;
	assign and1 = x & ~d2;
	assign or1 = x | ~d3;
	DFF dff1(.clk(clk), .d(xor1), .q(d1));
	DFF dff2(.clk(clk), .d(and1), .q(d2));
	DFF dff3(.clk(clk), .d(or1), .q(d3));
	assign z = ~(xor1 ^ and1 ^ or1);
endmodule
module DFF (
	input clk,
	input d,
	output q
);
	  reg q;
	  always @(posedge clk) begin
	  q <= d;
	end
endmodule
