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
reg previous_direction;
parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;
parameter FALL = 2'b10;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= WALK_LEFT;
		previous_direction <= WALK_LEFT;
	end
	else begin
		case (state)
			WALK_LEFT:
				if (bump_right) begin
					previous_direction <= WALK_RIGHT;
					state <= WALK_RIGHT;
				end
				else if (bump_left) begin
					previous_direction <= WALK_LEFT;
					state <= WALK_LEFT;
				end
				else if (!ground) begin
					state <= FALL;
				end
				
			WALK_RIGHT:
				if (bump_left) begin
					previous_direction <= WALK_LEFT;
					state <= WALK_LEFT;
				end
				else if (bump_right) begin
					previous_direction <= WALK_RIGHT;
					state <= WALK_RIGHT;
				end
				else if (!ground) begin
					state <= FALL;
				end
				
			FALL:
				if (ground) begin
					state <= previous_direction;
				end
		endcase
	end
end

assign walk_left = (state == WALK_LEFT);
assign walk_right = (state == WALK_RIGHT);
assign aaah = (state == FALL);

endmodule
