module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output reg walk_left,
	output reg walk_right
);

	reg [1:0] state;
	parameter IDLE = 2'b00;
	parameter WALK_LEFT = 2'b01;
	parameter WALK_RIGHT = 2'b10;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= WALK_LEFT;
			walk_left <= 1;
			walk_right <= 0;
		end else begin
			case (state)
				IDLE: begin
					if (bump_left)
						state <= WALK_RIGHT;
					else if (bump_right)
						state <= WALK_LEFT;
				end

				WALK_LEFT: begin
					if (!bump_left && bump_right)
						state <= WALK_RIGHT;
					else if (bump_left && !bump_right)
						state <= WALK_LEFT;
				end

				WALK_RIGHT: begin
					if (bump_left && !bump_right)
						state <= WALK_LEFT;
					else if (!bump_left && bump_right)
						state <= WALK_RIGHT;
				end
			endcase
		end
	end
endmodule
