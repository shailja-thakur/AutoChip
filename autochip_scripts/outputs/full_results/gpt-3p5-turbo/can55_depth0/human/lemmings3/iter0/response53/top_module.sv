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
		state <= 2'b01; // walking left
		walk_left <= 1;
		walk_right <= 0;
		aaah <= 0;
		digging <= 0;
	end else begin
		case (state)
			2'b00: begin // falling
				if (ground) begin
					state <= (bump_left || bump_right) ? 2'b01 : 2'b10; // switch direction or continue walking
				end else if (dig) begin
					state <= 2'b11; // digging
				end
				walk_left <= 0;
				walk_right <= 0;
				aaah <= 1;
				digging <= 0;
			end
			2'b01: begin // walking left
				if (!ground) begin
					state <= 2'b00; // falling
				end else if (bump_left && !bump_right) begin
					state <= 2'b10; // walk right
				end else if (bump_left && bump_right) begin
					state <= 2'b10; // switch direction
				end else if (dig) begin
					state <= 2'b11; // digging
				end
				walk_left <= 1;
				walk_right <= 0;
				aaah <= 0;
				digging <= 0;
			end
			2'b10: begin // walking right
				if (!ground) begin
					state <= 2'b00; // falling
				end else if (!bump_left && bump_right) begin
					state <= 2'b01; // walk left
				end else if (bump_left && bump_right) begin
					state <= 2'b01; // switch direction
				end else if (dig) begin
					state <= 2'b11; // digging
				end
				walk_left <= 0;
				walk_right <= 1;
				aaah <= 0;
				digging <= 0;
			end
			2'b11: begin // digging
				if (!ground) begin
					state <= 2'b00; // falling
				end else if (bump_left && !bump_right) begin
					state <= 2'b10; // walk right
				end else if (!bump_left && bump_right) begin
					state <= 2'b01; // walk left
				end else if (!bump_left && !bump_right && !dig) begin
					state <= 2'b10; // continue walking
				end
				walk_left <= 0;
				walk_right <= 0;
				aaah <= 0;
				digging <= 1;
			end
		endcase
	end
end

endmodule
