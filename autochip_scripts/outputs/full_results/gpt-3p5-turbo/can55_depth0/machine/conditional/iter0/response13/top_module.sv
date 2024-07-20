module top_module (
	input [7:0] a,
	input [7:0] b,
	input [7:0] c,
	input [7:0] d,
	output reg [7:0] min
);

	always_comb begin
		min = a; // Assign the value of a to min
		if (b < min) min = b; // Compare b with min and update min if b is less than min
		if (c < min) min = c; // Compare c with min and update min if c is less than min
		if (d < min) min = d; // Compare d with min and update min if d is less than min
	end

endmodule
