module top_module (
	input [7:0] a,
	input [7:0] b,
	input [7:0] c,
	input [7:0] d,
	output reg [7:0] min
);

always_comb begin
	min = a; // assigning the value of a to min
	if (b < min) min = b; // comparing b with min and updating min if b is less than min
	if (c < min) min = c; // comparing c with min and updating min if c is less than min
	if (d < min) min = d; // comparing d with min and updating min if d is less than min
end

endmodule
