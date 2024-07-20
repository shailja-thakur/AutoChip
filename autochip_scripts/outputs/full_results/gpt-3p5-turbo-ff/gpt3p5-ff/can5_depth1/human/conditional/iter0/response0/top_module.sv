module top_module (
	input [7:0] a,
	input [7:0] b,
	input [7:0] c,
	input [7:0] d,
	output reg [7:0] min
);
	
	always @* begin
		if (a < b && a < c && a < d) // Check if a is the smallest
			min = a;
		else if (b < c && b < d) // Check if b is the smallest
			min = b;
		else if (c < d) // Check if c is the smallest
			min = c;
		else // d is the smallest
			min = d;
	end
	
endmodule
