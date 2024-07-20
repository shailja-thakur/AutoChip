module top_module (
	input [7:0] a,
	input [7:0] b,
	input [7:0] c,
	input [7:0] d,
	output reg [7:0] min
);

	always_comb begin
		min = a; // Assign the value of 'a' to 'min'

		if (b < min) begin // Compare 'b' with 'min'
			min = b; // Update 'min' with the new minimum value
		end

		if (c < min) begin // Compare 'c' with 'min'
			min = c; // Update 'min' with the new minimum value
		end

		if (d < min) begin // Compare 'd' with 'min'
			min = d; // Update 'min' with the new minimum value
		end
	end

endmodule
