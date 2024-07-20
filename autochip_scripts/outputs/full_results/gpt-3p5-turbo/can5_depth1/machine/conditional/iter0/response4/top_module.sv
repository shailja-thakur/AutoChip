module top_module (
	input [7:0] a,
	input [7:0] b,
	input [7:0] c,
	input [7:0] d,
	output reg [7:0] min
);

	always @* begin
		min = a;  // Initialize min with value of a

		// Compare b with min, update min if b is less
		if (b < min) begin
			min = b;
		end

		// Compare c with min, update min if c is less
		if (c < min) begin
			min = c;
		end

		// Compare d with min, update min if d is less
		if (d < min) begin
			min = d;
		end
	end

endmodule
