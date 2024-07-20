module top_module (
	input [7:0] a,
	input [7:0] b,
	input [7:0] c,
	input [7:0] d,
	output reg [7:0] min
);

always @(*) begin
	min = a; // Initialize min with a

	if (b < min) // Compare b with min
		min = b;

	if (c < min) // Compare c with min
		min = c;

	if (d < min) // Compare d with min
		min = d;
}

endmodule
