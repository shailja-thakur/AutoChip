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
	// Define states
	typedef enum logic [1:0] {
		WALK_LEFT,
		WALK_RIGHT,
		FALLING
	} state_t;
	
	// Define state signals
	state_t current_state;
	state_t next_state;
	
	// Combinational logic for output signals
	assign walk_left = (current_state == WALK_LEFT) ? 1'b1 : 1'b0;
	assign walk_right = (current_state == WALK_RIGHT) ? 1'b1 : 1'b0;
	assign aaah = (current_state == FALLING) ? 1'b1 : 1'b0;
	
	// Sequential logic for state transitions
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= WALK_LEFT;
		end else begin
			current_state <= next_state;
		end
	end
	
	// Combinational logic for next state calculation
	always_comb begin
		case (current_state)
			WALK_LEFT:
				if (bump_right) begin
					next_state = WALK_RIGHT;
				end else if (~ground) begin
					next_state = FALLING;
				end else begin
					next_state = WALK_LEFT;
				end
			
			WALK_RIGHT:
				if (bump_left) begin
					next_state = WALK_LEFT;
				end else if (~ground) begin
					next_state = FALLING;
				end else begin
					next_state = WALK_RIGHT;
				end
			
			FALLING:
				if (ground) begin
					if (current_state == WALK_LEFT) begin
						next_state = WALK_LEFT;
					end else begin
						next_state = WALK_RIGHT;
					end
				end else begin
					next_state = FALLING;
				end
		endcase
	end
endmodule
