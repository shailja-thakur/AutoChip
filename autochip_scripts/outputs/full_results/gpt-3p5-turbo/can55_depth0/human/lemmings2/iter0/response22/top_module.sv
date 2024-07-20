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

reg [7:0] state;

// State definitions
parameter WALK_LEFT = 0;
parameter WALK_RIGHT = 1;
parameter FALL = 2;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= WALK_LEFT;
	end else begin
		case (state)
			WALK_LEFT: begin
				if (bump_right) begin
					state <= WALK_RIGHT;
				end else if (bump_left) begin
					state <= WALK_LEFT;
				end else if (ground == 0) begin
					state <= FALL;
				end else begin
					state <= WALK_LEFT;
				end
			end
			
			WALK_RIGHT: begin
				if (bump_left) begin
					state <= WALK_LEFT;
				end else if (bump_right) begin
					state <= WALK_RIGHT;
				end else if (ground == 0) begin
					state <= FALL;
				end else begin
					state <= WALK_RIGHT;
				end
			end
			
			FALL: begin
				if (ground) begin
					if (state == WALK_LEFT) begin
						state <= WALK_RIGHT;
					end else if (state == WALK_RIGHT) begin
						state <= WALK_LEFT;
					end else begin
						state <= WALK_LEFT;
					end
				end else begin
					state <= FALL;
				end
			end
		endcase
	end
end

// Output assignments
assign walk_left = (state == WALK_LEFT) ? 1 : 0;
assign walk_right = (state == WALK_RIGHT) ? 1 : 0;
assign aaah = (state == FALL && ground == 0) ? 1 : 0;

endmodule
