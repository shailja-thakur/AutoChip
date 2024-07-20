module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	reg signed [7:0] a_reg;
	reg signed [7:0] b_reg;
	reg signed [7:0] s_reg;

	always @(a, b) begin
		a_reg <= a;
		b_reg <= b;
		s_reg <= a_reg + b_reg;
	end

	assign s = s_reg;
	assign overflow = (s_reg > 127) || (s_reg < -128);

endmodule
