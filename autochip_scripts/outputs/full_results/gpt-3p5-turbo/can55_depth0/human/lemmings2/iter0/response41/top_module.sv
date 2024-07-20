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
	
	// Define the states
	typedef enum logic [1:0] {
		LEFT,
		RIGHT,
		FALLING
	} state_type;
	
	// Define the signals
	reg state_type current_state, next_state;
	reg walk_left, walk_right, aaah;
	
	// Register the signals
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= LEFT;
		end else begin
			current_state <= next_state;
		end
	end
	
	// Define the next state logic
	always @(*) begin
		case (current_state)
			LEFT: begin
				if (bump_right && !bump_left && ground) begin
					next_state = RIGHT;
				end else if (!bump_right && !bump_left && ground) begin
					next_state = LEFT;
				end else if (!bump_right && bump_left) begin
					next_state = LEFT;
				end else if (bump_right && !bump_left) begin
					next_state = RIGHT;
				end else if (bump_right && bump_left) begin
					next_state = RIGHT;
				end else if (!ground) begin
					next_state = FALLING;
				end
			end
			RIGHT: begin
				if (!bump_right && bump_left && ground) begin
					next_state = LEFT;
				end else if (!bump_right && !bump_left && ground) begin
					next_state = RIGHT;
				end else if (bump_right && bump_left) begin
					next_state = LEFT;
				end else if (!bump_right && bump_left) begin
					next_state = LEFT;
				end else if (!ground) begin
					next_state = FALLING;
				end
			end
			FALLING: begin
				if (ground) begin
					next_state = current_state;
				end
			end
		endcase
	end
	
	// Define the Moore output logic
	always @(current_state) begin
		case (current_state)
			LEFT: begin
				walk_left = 1;
				walk_right = 0;
				aaah = 0;
			end
			RIGHT: begin
				walk_left = 0;
				walk_right = 1;
				aaah = 0;
			end
			FALLING: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 1;
			end
		endcase
	end
    
endmodule
