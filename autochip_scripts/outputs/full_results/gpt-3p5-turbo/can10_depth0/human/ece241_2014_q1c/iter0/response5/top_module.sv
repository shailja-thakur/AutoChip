module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	
	reg [8:0] sum;
	always @(a, b)
	begin
		// Overflow occurs when the sum of two positive numbers is negative or the sum of two negative numbers is positive.
		if ((a[7] & b[7] & ~sum[8]) || (~a[7] & ~b[7] & sum[8]))
			overflow <= 1;
		else
			overflow <= 0;
		
		// Saturate the sum at -128 and 127.
		if (sum > 127) 
			s <= 127;
		else if (sum < -128) 
			s <= -128;
		else 
			s <= sum[7:0];
	end
	
	assign sum = a + b;
endmodule
