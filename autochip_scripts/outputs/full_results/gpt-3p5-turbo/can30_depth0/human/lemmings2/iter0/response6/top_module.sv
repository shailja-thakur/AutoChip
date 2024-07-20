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
// states:
// 0: walking left
// 1: walking right
// 2: falling

// Moore outputs
assign walk_left = (state == 0);
assign walk_right = (state == 1);
assign aaah = (state == 2);

// Synchronous reset
always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= 0;
	end else begin
		case(state)
			0: begin // walking left
				if (bump_left && !bump_right) begin
					state <= 1; // switch to walking right
				end else if (bump_right && !bump_left) begin
					state <= 0; // continue walking left
				end else if (!ground) begin
					state <= 2; // begin falling
				end
			end
			1: begin // walking right
				if (!bump_left && bump_right) begin
					state <= 0; // switch to walking left
				end else if (bump_left && !bump_right) begin
					state <= 1; // continue walking right
				end else if (!ground) begin
					state <= 2; // begin falling
				end
			end
			2: begin // falling
				if (ground) begin
					if (state == 0) begin
						state <= 0; // continue walking left
					end else begin
						state <= 1; // continue walking right
					end
				end
			end
		endcase
	end
end

endmodule
