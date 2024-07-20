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

// State machine
always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= 2'b00; // Start in walk_left state
		walk_left <= 1'b1;
		walk_right <= 1'b0;
		aaah <= 1'b0;
	end else begin
		case (state)
			2'b00: begin // walk_left state
				if (bump_left && !bump_right) begin
					state <= 2'b01; // switch to walk_right state
					walk_left <= 1'b0;
					walk_right <= 1'b1;
					aaah <= 1'b0;
				end else if (!bump_left && bump_right) begin
					state <= 2'b00; // stay in walk_left state
					walk_left <= 1'b1;
					walk_right <= 1'b0;
					aaah <= 1'b0;
				end else if (bump_left && bump_right) begin
					state <= 2'b01; // switch to walk_right state
					walk_left <= 1'b0;
					walk_right <= 1'b1;
					aaah <= 1'b0;
				end else if (!ground) begin
					state <= 2'b10; // switch to fall state
					walk_left <= 1'b0;
					walk_right <= 1'b0;
					aaah <= 1'b1;
				end
			end
			2'b01: begin // walk_right state
				if (bump_left && !bump_right) begin
					state <= 2'b00; // switch to walk_left state
					walk_left <= 1'b1;
					walk_right <= 1'b0;
					aaah <= 1'b0;
				end else if (!bump_left && bump_right) begin
					state <= 2'b01; // stay in walk_right state
					walk_left <= 1'b0;
					walk_right <= 1'b1;
					aaah <= 1'b0;
				end else if (bump_left && bump_right) begin
					state <= 2'b00; // switch to walk_left state
					walk_left <= 1'b1;
					walk_right <= 1'b0;
					aaah <= 1'b0;
				end else if (!ground) begin
					state <= 2'b10; // switch to fall state
					walk_left <= 1'b0;
					walk_right <= 1'b0;
					aaah <= 1'b1;
				end
			end
			2'b10: begin // fall state
				if (ground) begin
					if (state == 2'b10) begin
						state <= 2'b00; // return to walk_left state
						walk_left <= 1'b1;
						walk_right <= 1'b0;
						aaah <= 1'b0;
					end
				end
			end
		endcase
	end
end

endmodule
