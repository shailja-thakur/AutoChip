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
parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;
parameter FALLING = 2'b10;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= WALK_LEFT;
	end else begin
		case (state)
			WALK_LEFT: begin
				if (bump_right && !bump_left) begin
					state <= WALK_RIGHT;
				end else if (ground == 0) begin
					state <= FALLING;
				end
			end
			WALK_RIGHT: begin
				if (bump_left && !bump_right) begin
					state <= WALK_LEFT;
				end else if (ground == 0) begin
					state <= FALLING;
				end
			end
			FALLING: begin
				if (ground == 1) begin
					if (state == WALK_RIGHT) begin
						state <= WALK_RIGHT;
					end else if (state == WALK_LEFT) begin
						state <= WALK_LEFT;
					end
				end
			end
		endcase
	end
end

assign walk_left = (state == WALK_LEFT) ? 1 : 0;
assign walk_right = (state == WALK_RIGHT) ? 1 : 0;
assign aaah = (state == FALLING && ground == 0) ? 1 : 0;

endmodule
