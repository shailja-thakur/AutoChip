module top_module(
	input x,
	input y,
	output reg z);

	always @ (*) begin
		z = (x ^ y) & x;
	end

endmodule
