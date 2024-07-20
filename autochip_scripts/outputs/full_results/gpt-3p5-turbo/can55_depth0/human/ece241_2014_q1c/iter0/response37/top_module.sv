module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	reg [7:0] s_temp;
	wire carry_out;
	wire sign_overflow;
	
	assign s = s_temp;
	assign overflow = sign_overflow;
	
	always @(a or b) begin
		s_temp = a + b;
	end
	
	assign carry_out = (a[7] & b[7]) | (a[7] & ~s_temp[7]) | (b[7] & ~s_temp[7]);
	assign sign_overflow = (a[7] == b[7]) & (a[7] != s_temp[7]);
	
endmodule
