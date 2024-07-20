module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);
	reg state, next_state;

	// State declaration
	localparam WALK_LEFT = 1'b0, WALK_RIGHT = 1'b1;

	assign walk_left = (state == WALK_LEFT);
	assign walk_right = (state == WALK_RIGHT);

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= WALK_LEFT;
		end else begin
			state <= next_state;
		end
	end

	always @(*) begin
		case (state)
			WALK_LEFT: begin
				if (bump_left) begin
					next_state = WALK_RIGHT;
				end else begin
					next_state = WALK_LEFT;
				end
			end
			WALK_RIGHT: begin
				if (bump_right) begin
					next_state = WALK_LEFT;
				end else begin
					next_state = WALK_RIGHT;
				end
			end
			default: begin
				next_state = WALK_LEFT; // Default state is walk left
			end
		endcase
	end
endmodule
