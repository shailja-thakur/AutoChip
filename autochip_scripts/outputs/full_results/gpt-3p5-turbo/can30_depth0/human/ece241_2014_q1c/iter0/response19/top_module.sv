module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	
	reg signed [7:0] temp;
	
	always @ (a, b) begin
		temp = a + b;
		if (temp > 127 || temp < -128)
			overflow = 1;
		else
			overflow = 0;
		s = temp;
	end
	
endmodule
