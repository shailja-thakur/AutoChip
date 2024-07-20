module top_module (
	input [7:0] a,
	input [7:0] b,
	input [7:0] c,
	input [7:0] d,
	output reg [7:0] min
);

	always @(*) begin
		min = a; // Start by assuming a is the smallest
		if (b < min) 
			min = b; // update min if b is smaller
		if (c < min) 
			min = c; // update min if c is smaller
		if (d < min) 
			min = d; // update min if d is smaller
	end

endmodule
