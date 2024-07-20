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

reg [4:0] state;
reg walk_left;
reg walk_right;
reg aaah;
reg digging;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= 5'b10000; // Reset state to walk left
		walk_left <= 1'b1;
		walk_right <= 1'b0;
		aaah <= 1'b0;
		digging <= 1'b0;
	end else begin
		case (state)
			5'b10000: begin // Walking left
				if (bump_right && !bump_left && ground) begin
					// Bumped on the right while walking left
					state <= 5'b01101; // Switch direction
					walk_right <= 1'b1;
					walk_left <= 1'b0;
				end else if (!bump_right && bump_left && ground) begin
					// Bumped on the left while walking left
					state <= 5'b01110; // Switch direction
					walk_left <= 1'b1;
					walk_right <= 1'b0;
				end else if (bump_right && bump_left && ground) begin
					// Bumped on both sides while walking left
					state <= 5'b00001; // Switch direction
					walk_right <= 1'b1;
					walk_left <= 1'b0;
				end else if (!ground) begin
					// Falling while walking left
					state <= 5'b01000; // Fall state
					aaah <= 1'b1;
				end else if (dig) begin
					// Start digging while walking left
					state <= 5'b00011; // Dig state
					digging <= 1'b1;
				end
			end
			5'b01110: begin // Walking right after bumping left while walking left
				if (bump_left) begin
					state <= 5'b01110; // Stay in current state
				end else if (!ground) begin
					// Falling after bumping left while walking left
					state <= 5'b01000; // Fall state
					aaah <= 1'b1;
				end else if (dig) begin
					// Start digging after bumping left while walking left
					state <= 5'b00011; // Dig state
					digging <= 1'b1;
				end else begin
					// Continue walking right after bumping left while walking left
					state <= 5'b01110;
					walk_right <= 1'b1;
					walk_left <= 1'b0;
				end
			end
			5'b01101: begin // Walking right after bumping right while walking left
				if (bump_right) begin
					state <= 5'b01101; // Stay in current state
				end else if (!ground) begin
					// Falling after bumping right while walking left
					state <= 5'b01000; // Fall state
					aaah <= 1'b1;
				end else if (dig) begin
					// Start digging after bumping right while walking left
					state <= 5'b00011; // Dig state
					digging <= 1'b1;
				end else begin
					// Continue walking right after bumping right while walking left
					state <= 5'b01101;
					walk_right <= 1'b1;
					walk_left <= 1'b0;
				end
			end
			5'b00001: begin // Walking right after bumping both sides while walking left
				if (bump_left && bump_right) begin
					state <= 5'b00001; // Stay in current state
				end else if (!ground) begin
					// Falling after bumping both sides while walking left
					state <= 5'b01000; // Fall state
					aaah <= 1'b1;
				end else if (dig) begin
					// Start digging after bumping both sides while walking left
					state <= 5'b00011; // Dig state
					digging <= 1'b1;
				end else begin
					// Continue walking right after bumping both sides while walking left
					state <= 5'b00001;
					walk_right <= 1'b1;
					walk_left <= 1'b0;
				end
			end
			5'b01000: begin // Falling state
				if (ground) begin
					if (aaah) begin
						// Splattered after falling for too long
						state <= 5'b10000; // Reset state to walk left
						walk_left <= 1'b0;
						walk_right <= 1'b0;
						aaah <= 1'b0;
						digging <= 1'b0;
					end else begin
						// Landed after falling
						state <= 5'b10000; // Reset state to walk left
						walk_left <= 1'b0;
						walk_right <= 1'b1;
						aaah <= 1'b0;
						digging <= 1'b0;
					end
				end else begin
					state <= 5'b01000; // Stay in current state
				end
			end
			5'b00011: begin // Dig state
				if (!ground) begin
					// Falling while digging
					state <= 5'b01000; // Fall state
					aaah <= 1'b1;
				end else if (dig) begin
					state <= 5'b00011; // Stay in current state
				end else begin
					state <= 5'b00001; // Switch to walk state
					digging <= 1'b0;
					walk_left <= 1'b0;
					walk_right <= 1'b1;
				end
			end
		endcase
	end
end

endmodule
