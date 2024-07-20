module top_module (
	input [7:0] a,
	input [7:0] b,
	input [7:0] c,
	input [7:0] d,
	output reg [7:0] min
);

always @* begin
	min = a; // Initialize the minimum to the first number
	if (b < min) min = b; // Compare b with the current minimum
	if (c < min) min = c; // Compare c with the current minimum
	if (d < min) min = d; // Compare d with the current minimum
end

endmodule
