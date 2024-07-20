module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	reg signed [7:0] a_signed;
	reg signed [7:0] b_signed;
	
	assign a_signed = $signed(a);
	assign b_signed = $signed(b);
	
	always @* begin
		s = a + b;
		if (s > 127 || s < -128) begin
			overflow = 1;
		end else begin
			overflow = 0;
		end
	end
endmodule
