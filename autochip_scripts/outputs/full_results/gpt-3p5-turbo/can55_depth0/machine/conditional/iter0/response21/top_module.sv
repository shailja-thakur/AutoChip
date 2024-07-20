module top_module (
	input [7:0] a,
	input [7:0] b,
	input [7:0] c,
	input [7:0] d,
	output reg [7:0] min
);

	always_comb begin
		min = a;  // Assign the value of input a to min
		
		// Compare input b with min and update min if b is smaller
		if (b < min)
			min = b;
		
		// Compare input c with min and update min if c is smaller
		if (c < min)
			min = c;
		
		// Compare input d with min and update min if d is smaller
		if (d < min)
			min = d;
	end
	
endmodule
