module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output reg walk_left,
    output reg walk_right,
    output reg aaah
);

	// Define the states
	typedef enum logic [1:0] {LEFT, RIGHT, FALL} state_t;
	reg state_t current_state, next_state;

	// Define the outputs
	assign walk_left = (current_state == LEFT);
	assign walk_right = (current_state == RIGHT);
	assign aaah = (current_state == FALL);

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= LEFT;
		end else begin
			current_state <= next_state;
		end
	end

	always @* begin
		next_state = current_state;
		case (current_state)
			LEFT:
				if (bump_right) begin
					next_state = RIGHT;
				end else if (ground == 0) begin
					next_state = FALL;
				end
			RIGHT:
				if (bump_left) begin
					next_state = LEFT;
				end else if (ground == 0) begin
					next_state = FALL;
				end
			FALL:
				if (ground == 1) begin
					if (current_state == LEFT) begin
						next_state = LEFT;
					end else if (current_state == RIGHT) begin
						next_state = RIGHT;
					end
				end
		endcase
	end

endmodule
