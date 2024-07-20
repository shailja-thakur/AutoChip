module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	reg [7:0] s;
	wire overflow;
	reg signed [7:0] a_signed, b_signed;
	
	assign a_signed = $signed(a);
	assign b_signed = $signed(b);
	
	always @* begin
		s = a_signed + b_signed;
		if (s > 127 || s < -128)
			overflow = 1;
		else
			overflow = 0;
	end
	
endmodule
