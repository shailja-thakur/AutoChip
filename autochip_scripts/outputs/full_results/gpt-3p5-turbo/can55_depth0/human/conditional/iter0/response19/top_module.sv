module top_module (
	input [7:0] a,
	input [7:0] b,
	input [7:0] c,
	input [7:0] d,
	output reg [7:0] min
);

always @* begin
	min = a; // set min to a initially
	if (b < min) // check if b is less than min
		min = b; // update min to b if true
	if (c < min) // check if c is less than min
		min = c; // update min to c if true
	if (d < min) // check if d is less than min
		min = d; // update min to d if true
end

endmodule
