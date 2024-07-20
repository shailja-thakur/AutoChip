module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	reg [7:0] s_reg;
	wire overflow;

	always @* begin
		s_reg = a + b;
		if (s_reg[7] != a[7] && s_reg[7] != b[7]) begin
			overflow = 1;
		end else begin
			overflow = 0;
		end
	end

	assign s = s_reg;

endmodule
