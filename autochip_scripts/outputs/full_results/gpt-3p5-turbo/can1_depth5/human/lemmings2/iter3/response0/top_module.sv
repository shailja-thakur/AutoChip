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
	typedef enum logic [1:0] {WALK_LEFT, WALK_RIGHT, FALL} State;
	reg [1:0] current_state, next_state;
	
	// Define the outputs
	assign walk_left = (current_state == WALK_LEFT);
	assign walk_right = (current_state == WALK_RIGHT);
	assign aaah = (current_state == FALL);
	
	always_ff @(posedge clk, posedge areset) begin
		if (areset) begin
			current_state <= WALK_LEFT;
		end else begin
			current_state <= next_state;
		end
	end
	
	always_comb begin
		case (current_state)
			WALK_LEFT: begin
				if (bump_right) begin
					next_state = WALK_RIGHT;
				end else if (bump_left) begin
					next_state = WALK_LEFT;
				end else begin
                                        // We need to add a condition to check if 'ground' is zero
                                        if (ground == 0)
					   next_state = FALL;
                                        else
                                           next_state = WALK_LEFT;
				end
			end
			WALK_RIGHT: begin
				if (bump_left) begin
					next_state = WALK_LEFT;
				end else if (bump_right) begin
					next_state = WALK_RIGHT;
				end else begin
                                        // We need to add a condition to check if 'ground' is zero
                                        if (ground == 0)
					   next_state = FALL;
                                        else
					   next_state = WALK_RIGHT;
				end
			end
			FALL: begin
				if (ground == 1) begin
					if (current_state == WALK_LEFT) begin
						next_state = WALK_LEFT;
					end else if (current_state == WALK_RIGHT) begin
						next_state = WALK_RIGHT;
					end else begin
						next_state = WALK_LEFT;
					end
				end else begin
					next_state = FALL;
				end
			end
			default: begin
				next_state = current_state;
			end
		endcase
	end
endmodule
