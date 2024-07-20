module top_module (
	input clk,
	input x,
	output reg z
);

	reg dff1 = 0;
	reg dff2 = 0;
	reg dff3 = 0;
	
	assign z = !(dff1 ^ (x & ~dff2) | ~dff3);

	always @(posedge clk) begin
		dff1 <= x ^ dff1;
		dff2 <= ~dff2;
		dff3 <= ~dff3;
	end

endmodule
