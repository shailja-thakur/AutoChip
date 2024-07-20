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
		state <= 0;
		walk_left <= 1;
		walk_right <= 0;
		aaah <= 0;
		digging <= 0;
	end else begin
		case (state)
			0: begin // Walking left
				if (bump_right) begin
					state <= 1; // Switch to walking right
					walk_left <= 0;
					walk_right <= 1;
				end else if (!ground) begin
					state <= 2; // Fall
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 1;
				end else if (dig && ground) begin
					state <= 3; // Start digging
					walk_left <= 0;
					walk_right <= 0;
					digging <= 1;
				end
			end
			1: begin // Walking right
				if (bump_left) begin
					state <= 0; // Switch to walking left
					walk_left <= 1;
					walk_right <= 0;
				end else if (!ground) begin
					state <= 2; // Fall
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 1;
				end else if (dig && ground) begin
					state <= 3; // Start digging
					walk_left <= 0;
					walk_right <= 0;
					digging <= 1;
				end
			end
			2: begin // Falling
				if (ground) begin
					state <= (walk_left) ? 0 : 1; // Continue walking in the original direction
					walk_left <= (walk_left) ? 1 : 0;
					walk_right <= (walk_right) ? 1 : 0;
					aaah <= 0;
				end
			end
			3: begin // Digging
				if (!ground) begin
					state <= 2; // Fall
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 1;
					digging <= 0;
				end
			end
		endcase
	end
end

endmodule
