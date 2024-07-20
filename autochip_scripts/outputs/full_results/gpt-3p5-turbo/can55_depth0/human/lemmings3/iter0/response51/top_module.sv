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
			WALK_LEFT: begin
				if (bump_right && bump_left) begin
					state <= WALK_RIGHT;
				end else if (bump_right) begin
					state <= WALK_LEFT;
				end else if (bump_left) begin
					state <= WALK_RIGHT;
				end else if (!ground) begin
					state <= FALL;
				end else if (dig) begin
					state <= DIG;
				end else begin
					state <= WALK_LEFT;
				end
			end
			WALK_RIGHT: begin
				if (bump_right && bump_left) begin
					state <= WALK_LEFT;
				end else if (bump_right) begin
					state <= WALK_LEFT;
				end else if (bump_left) begin
					state <= WALK_RIGHT;
				end else if (!ground) begin
					state <= FALL;
				end else if (dig) begin
					state <= DIG;
				end else begin
					state <= WALK_RIGHT;
				end
			end
			FALL: begin
				if (ground) begin
					state <= WALK_RIGHT;
				end else begin
					state <= FALL;
				end
			end
			DIG: begin
				if (!ground) begin
					state <= FALL;
				end else begin
					state <= DIG;
				end
			end
		endcase
	end
end

assign walk_left = (state == WALK_LEFT) ? 1 : 0;
assign walk_right = (state == WALK_RIGHT) ? 1 : 0;
assign aaah = (state == FALL) ? 1 : 0;
assign digging = (state == DIG) ? 1 : 0;

endmodule
