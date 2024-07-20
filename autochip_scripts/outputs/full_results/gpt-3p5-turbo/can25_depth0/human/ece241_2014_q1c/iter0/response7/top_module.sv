module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	reg [7:0] signed_sum;

	always @(a, b) begin
		signed_sum = a + b;
		
		if (signed_sum > 127 || signed_sum < -128) 
			overflow = 1;
		else
			overflow = 0;
		
		s = signed_sum[7:0];
	end
	
endmodule
