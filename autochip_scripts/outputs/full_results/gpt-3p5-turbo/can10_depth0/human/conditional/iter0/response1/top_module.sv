module top_module (
	input [7:0] a,
	input [7:0] b,
	input [7:0] c,
	input [7:0] d,
	output reg [7:0] min
);

always @*
begin
	min = a; // Initialize min with the first number
	if (b < min) // Check if b is smaller than min
		min = b; // If true, update min with b
	if (c < min) // Check if c is smaller than min
		min = c; // If true, update min with c
	if (d < min) // Check if d is smaller than min
		min = d; // If true, update min with d
end

endmodule
