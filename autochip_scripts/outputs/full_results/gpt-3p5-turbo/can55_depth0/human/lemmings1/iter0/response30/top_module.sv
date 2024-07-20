module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);

	reg [1:0] state;
	parameter WALK_LEFT = 2'b00;
	parameter WALK_RIGHT = 2'b01;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= WALK_LEFT;
		end else begin
			case(state)
				WALK_LEFT: begin
					if (bump_left || (bump_left && bump_right))
						state <= WALK_RIGHT;
				end
				WALK_RIGHT: begin
					if (bump_right || (bump_left && bump_right))
						state <= WALK_LEFT;
				end
			endcase
		end
	end

	assign walk_left = (state == WALK_LEFT) ? 1'b1 : 1'b0;
	assign walk_right = (state == WALK_RIGHT) ? 1'b1 : 1'b0;

endmodule
