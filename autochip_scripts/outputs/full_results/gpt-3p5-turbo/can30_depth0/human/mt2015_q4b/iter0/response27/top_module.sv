module top_module(
	input x,
	input y,
	output z);

	// Declare reg variables for storing previous values of x, y, and z
	reg prev_x;
	reg prev_y;
	reg prev_z;

	always @(*) begin
		// Check if x or y has changed values
		if (x != prev_x || y != prev_y) begin
			// Update the value of z based on the current values of x and y
			case ({x, y})
				2'b00: z = 1;
				2'b01: z = 0;
				2'b10: z = 0;
				2'b11: z = 1;
			endcase
		end
	end

	// Update the previous values of x, y, and z at the end of each simulation step
	always @(posedge clk) begin
		prev_x = x;
		prev_y = y;
		prev_z = z;
	end

endmodule
