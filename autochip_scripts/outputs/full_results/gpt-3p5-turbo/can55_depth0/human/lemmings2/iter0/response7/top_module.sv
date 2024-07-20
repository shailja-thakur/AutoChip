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

parameter ST_WALK_LEFT = 2'b00;
parameter ST_WALK_RIGHT = 2'b01;
parameter ST_FALL = 2'b10;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= ST_WALK_LEFT;
	end else begin
		case(state)
			ST_WALK_LEFT: begin
				if (bump_right) begin
					state <= ST_WALK_RIGHT;
				end else if (!ground) begin
					state <= ST_FALL;
				end
			end
			ST_WALK_RIGHT: begin
				if (bump_left) begin
					state <= ST_WALK_LEFT;
				end else if (!ground) begin
					state <= ST_FALL;
				end
			end
			ST_FALL: begin
				if (ground) begin
					if (state == ST_WALK_LEFT) begin
						state <= ST_WALK_LEFT;
					end else if (state == ST_WALK_RIGHT) begin
						state <= ST_WALK_RIGHT;
					end
				end
			end
		endcase
	end
end

assign walk_left = (state == ST_WALK_LEFT);
assign walk_right = (state == ST_WALK_RIGHT);
assign aaah = (state == ST_FALL);

endmodule
