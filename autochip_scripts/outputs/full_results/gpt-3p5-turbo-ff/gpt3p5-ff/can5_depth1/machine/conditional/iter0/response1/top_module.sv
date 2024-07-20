module top_module (
	input [7:0] a,
	input [7:0] b,
	input [7:0] c,
	input [7:0] d,
	output reg [7:0] min
);;

	always_comb begin
		// Initialize min with the value of a
		min = a;

		// Compare b with min and update min if necessary
		if (b < min)
			min = b;

		// Compare c with min and update min if necessary
		if (c < min)
			min = c;

		// Compare d with min and update min if necessary
		if (d < min)
			min = d;
	end

endmodule
