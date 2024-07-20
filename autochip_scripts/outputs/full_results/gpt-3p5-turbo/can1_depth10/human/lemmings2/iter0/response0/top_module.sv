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
	parameter FALL = 2'b10;

	always @(posedge clk or posedge areset)
	begin
		if (areset)
			state <= WALK_LEFT;
		else
		begin
			case(state)
				WALK_LEFT:
				begin
					if (bump_right && !bump_left)
						state <= WALK_RIGHT;
					else if (bump_left && !bump_right)
						state <= WALK_LEFT;
					else if (!ground)
						state <= FALL;
				end

				WALK_RIGHT:
				begin
					if (bump_left && !bump_right)
						state <= WALK_LEFT;
					else if (bump_right && !bump_left)
						state <= WALK_RIGHT;
					else if (!ground)
						state <= FALL;
				end

				FALL:
				begin
					if (ground)
					begin
						if (state == WALK_LEFT)
							state <= WALK_LEFT;
						else if (state == WALK_RIGHT)
							state <= WALK_RIGHT;
					end
				end
			endcase
		end
	end

	assign walk_left = (state == WALK_LEFT) ? 1 : 0;
	assign walk_right = (state == WALK_RIGHT) ? 1 : 0;
	assign aaah = (state == FALL) ? 1 : 0;

endmodule
