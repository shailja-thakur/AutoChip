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

parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;
parameter FALL = 2'b10;
parameter DIG = 2'b11;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= WALK_LEFT;
	end else begin
		case (state)
			WALK_LEFT:
				if (bump_right) begin
					state <= WALK_RIGHT;
				end else if (bump_left) begin
					state <= WALK_LEFT;
				end else if (!ground) begin
					state <= FALL;
				end else if (dig) begin
					state <= DIG;
				end else begin
					state <= WALK_LEFT;
				end
			WALK_RIGHT:
				if (bump_left) begin
					state <= WALK_LEFT;
				end else if (bump_right) begin
					state <= WALK_RIGHT;
				end else if (!ground) begin
					state <= FALL;
				end else if (dig) begin
					state <= DIG;
				end else begin
					state <= WALK_RIGHT;
				end
			FALL:
				if (ground) begin
					if (state == WALK_LEFT) begin
						state <= WALK_LEFT;
					end else begin
						state <= WALK_RIGHT;
					end
				end else begin
					state <= FALL;
				end
			DIG:
				if (!ground) begin
					state <= FALL;
				end else if (dig) begin
					state <= DIG;
				end else begin
					state <= WALK_LEFT;
				end
		endcase
	end
end

assign walk_left = (state == WALK_LEFT) ? 1'b1 : 1'b0;
assign walk_right = (state == WALK_RIGHT) ? 1'b1 : 1'b0;
assign aaah = (state == FALL) ? 1'b1 : 1'b0;
assign digging = (state == DIG) ? 1'b1 : 1'b0;

endmodule
