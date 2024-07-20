module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	reg [7:0] a_signed;
	reg [7:0] b_signed;

	assign a_signed = a;
	assign b_signed = b;

	always @* begin
		s = a_signed + b_signed;
		overflow = (a_signed[7] == b_signed[7] && s[7] != a_signed[7]) ? 1'b1 : 1'b0;
	end

endmodule
