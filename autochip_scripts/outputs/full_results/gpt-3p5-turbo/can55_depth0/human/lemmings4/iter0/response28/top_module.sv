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
reg walk_left, walk_right, aaah, digging;


always @(posedge clk or posedge areset) begin
	if (areset)
		state <= 0;
	else begin
		case (state)
			0: begin
				walk_left <= 1;
				walk_right <= 0;
				aaah <= 0;
				digging <= 0;
				
				if (bump_left && !bump_right && ground) // Lemming bumped on the left
					state <= 1;
				else if (bump_right && !bump_left && ground) // Lemming bumped on the right
					state <= 2;
				else if (bump_left && bump_right && ground) // Lemming bumped on both sides
					state <= 3;
				else if (!ground) // Ground disappears (falling)
					state <= 4;
			end
			1: begin
				walk_left <= 0;
				walk_right <= 1;
				aaah <= 0;
				digging <= 0;
				
				if (bump_right && ground) // Lemming bumped on the right
					state <= 2;
				else if (bump_left && bump_right && ground) // Lemming bumped on both sides
					state <= 3;

				// Additional conditions for state transitions
				else if (!ground) // Ground disappears (falling)
					state <= 4;
				else if (dig && ground) // Lemming starts digging
					state <= 5;
			end
			2: begin
				walk_left <= 1;
				walk_right <= 0;
				aaah <= 0;
				digging <= 0;
				
				if (bump_left && ground) // Lemming bumped on the left
					state <= 1;
				else if (bump_left && bump_right && ground) // Lemming bumped on both sides
					state <= 3;

				// Additional conditions for state transitions
				else if (!ground) // Ground disappears (falling)
					state <= 4;
				else if (dig && ground) // Lemming starts digging
					state <= 5;
			end
			3: begin
				walk_left <= 1;
				walk_right <= 0;
				aaah <= 0;
				digging <= 0;
				
				if (bump_left && !bump_right && ground) // Lemming bumped on the left
					state <= 1;
				else if (bump_right && !bump_left && ground) // Lemming bumped on the right
					state <= 2;

				// Additional conditions for state transitions
				else if (!ground) // Ground disappears (falling)
					state <= 4;
				else if (dig && ground) // Lemming starts digging
					state <= 5;
			end
			4: begin
				walk_left <= 0;
				walk_right <= 0;
				aaah <= 1;
				digging <= 0;
				
				if (!ground) // Continue falling
					state <= 4;
				else
					state <= 0;
			end
			5: begin
				walk_left <= 0;
				walk_right <= 0;
				aaah <= 0;
				digging <= 1;
				
				if (!ground) // Ground disappears (falling)
					state <= 4;
				else if (!dig && ground) // Stop digging
					state <= 0;
			end
		endcase
	end
end


endmodule
