module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	output walk_left,
	output walk_right,
	output aaah
);

reg [1:0] state;
reg walk_left;
reg walk_right;
reg aaah;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= 2'b10; // Initialize state to walk left
		walk_left <= 1;
		walk_right <= 0;
		aaah <= 0;
	end else begin
		case (state)
			2'b00: begin // Falling state
				if (ground) begin
					// If ground reappears, resume walking in the same direction
					if (walk_left)
						state <= 2'b10;
					else
						state <= 2'b01;
				end
				// Being bumped while falling does not affect the walking direction
			end
			2'b01: begin // Walking left state
				if (bump_right) begin
					state <= 2'b10; // Switch direction if bumped on the right
					walk_left <= 0;
					walk_right <= 1;
				end
				// Being bumped on the left or both sides does not affect the walking direction
			end
			2'b10: begin // Walking right state
				if (bump_left) begin
					state <= 2'b01; // Switch direction if bumped on the left
					walk_left <= 1;
					walk_right <= 0;
				end
				// Being bumped on the right or both sides does not affect the walking direction
			end
		endcase

		if (!ground)
			aaah <= 1; // Lemming says "aaah!" if falling
		else
			aaah <= 0;
	end
end

endmodule
