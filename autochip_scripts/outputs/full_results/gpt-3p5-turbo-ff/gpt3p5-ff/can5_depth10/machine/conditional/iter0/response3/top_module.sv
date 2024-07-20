module top_module (
	input [7:0] a,
	input [7:0] b,
	input [7:0] c,
	input [7:0] d,
	output reg [7:0] min
);

	always_comb begin
		min = a; // Assign the initial value of a to min
		
		// Compare b with min
		if (b < min) begin
			min = b;
		end

		// Compare c with min
		if (c < min) begin
			min = c;
		end

		// Compare d with min
		if (d < min) begin
			min = d;
		end
	end
	
endmodule
