module top_module (
	input [7:0] a,
	input [7:0] b,
	input [7:0] c,
	input [7:0] d,
	output reg [7:0] min
);

	always_comb begin
		min = a; // Assign the value of a to min
		
		if (b < min) begin // Compare b with min
			min = b; // Update min if b is less than min
		end
		
		if (c < min) begin // Compare c with min
			min = c; // Update min if c is less than min
		end
		
		if (d < min) begin // Compare d with min
			min = d; // Update min if d is less than min
		end
	end

endmodule
