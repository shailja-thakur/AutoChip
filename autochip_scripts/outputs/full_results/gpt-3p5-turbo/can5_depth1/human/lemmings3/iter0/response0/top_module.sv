module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	input dig,
	output walk_left,
	output walk_right,
	output aaah,
	output digging
);

	reg [1:0] state;
	reg walk_left;
	reg walk_right;
	reg aaah;
	reg digging;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b00;    // Initialize state to walk_left
			walk_left <= 1'b1; // Start walking left
			walk_right <= 1'b0;
			aaah <= 1'b0;
			digging <= 1'b0;
		end else begin
			case (state)
				2'b00: begin // walk_left state
					if (bump_right) begin // If bumped on right, change direction to walk_right
						state <= 2'b01;    // Set state to walk_right
						walk_left <= 1'b0;
						walk_right <= 1'b1; // Start walking right
						aaah <= 1'b0;
						digging <= 1'b0;
					end else if (ground == 1'b0) begin // If no ground, start falling
						state <= 2'b10;    // Set state to fall
						walk_left <= 1'b0;
						walk_right <= 1'b0;
						aaah <= 1'b1;      // Start aaah
						digging <= 1'b0;
					end else if (dig == 1'b1) begin // If dig signal is asserted
						state <= 2'b11;    // Set state to dig
						walk_left <= 1'b0;
						walk_right <= 1'b0;
						aaah <= 1'b0;
						digging <= 1'b1;   // Start digging
					end else begin
						// No state change, keep walking left
						state <= 2'b00;
						walk_left <= 1'b1;
						walk_right <= 1'b0;
						aaah <= 1'b0;
						digging <= 1'b0;
					end
				end

				2'b01: begin // walk_right state
					if (bump_left) begin // If bumped on left, change direction to walk_left
						state <= 2'b00;    // Set state to walk_left
						walk_left <= 1'b1; // Start walking left
						walk_right <= 1'b0;
						aaah <= 1'b0;
						digging <= 1'b0;
					end else if (ground == 1'b0) begin // If no ground, start falling
						state <= 2'b10;    // Set state to fall
						walk_left <= 1'b0;
						walk_right <= 1'b0;
						aaah <= 1'b1;      // Start aaah
						digging <= 1'b0;
					end else if (dig == 1'b1) begin // If dig signal is asserted
						state <= 2'b11;    // Set state to dig
						walk_left <= 1'b0;
						walk_right <= 1'b0;
						aaah <= 1'b0;
						digging <= 1'b1;   // Start digging
					end else begin
						// No state change, keep walking right
						state <= 2'b01;
						walk_left <= 1'b0;
						walk_right <= 1'b1;
						aaah <= 1'b0;
						digging <= 1'b0;
					end
				end

				2'b10: begin // fall state
					if (ground == 1'b1) begin // If ground reappears, resume walking in the same direction
						if (state == 2'b00) begin
							state <= 2'b00;    // Set state to walk_left
							walk_left <= 1'b1; // Start walking left
							walk_right <= 1'b0;
							aaah <= 1'b0;
							digging <= 1'b0;
						end else if (state == 2'b01) begin
							state <= 2'b01;    // Set state to walk_right
							walk_left <= 1'b0;
							walk_right <= 1'b1; // Start walking right
							aaah <= 1'b0;
							digging <= 1'b0;
						end else begin
							// No state change, keep falling
							state <= 2'b10;
							walk_left <= 1'b0;
							walk_right <= 1'b0;
							aaah <= 1'b1;      // Keep aaah
							digging <= 1'b0;
						end
					end else begin
						// No state change, keep falling
						state <= 2'b10;
						walk_left <= 1'b0;
						walk_right <= 1'b0;
						aaah <= 1'b1;      // Keep aaah
						digging <= 1'b0;
					end
				end

				2'b11: begin // dig state
					if (ground == 1'b0) begin // If no ground, continue digging
						state <= 2'b11;
						walk_left <= 1'b0;
						walk_right <= 1'b0;
						aaah <= 1'b0;
						digging <= 1'b1;   // Keep digging
					end else begin
						state <= 2'b00;    // Set state to walk_left
						walk_left <= 1'b1; // Start walking left
						walk_right <= 1'b0;
						aaah <= 1'b0;
						digging <= 1'b0;
					end
				end
			endcase
		end
	end
endmodule
