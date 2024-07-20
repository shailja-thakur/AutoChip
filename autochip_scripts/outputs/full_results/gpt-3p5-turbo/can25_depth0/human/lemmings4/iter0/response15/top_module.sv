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

	// Define states
	typedef enum logic [2:0] {
		WALK_LEFT_STATE,
		WALK_RIGHT_STATE,
		FALL_STATE,
		DIG_STATE,
		SPLATTER_STATE
	} state_type;
	
	// Define signals
	state_type current_state, next_state;
	logic [4:0] fall_counter;
	
	// Define constants
	parameter MAX_FALL_TIME = 20;
	
	// Define state register and next state logic
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= WALK_LEFT_STATE;
		end else begin
			current_state <= next_state;
		end
	end
	
	// Define next state logic
	always_comb begin
		next_state = current_state;
		case (current_state)
			WALK_LEFT_STATE: begin
				if (bump_right) begin
					next_state = WALK_RIGHT_STATE;
				end else if (!ground) begin
					next_state = FALL_STATE;
				end else if (dig) begin
					next_state = DIG_STATE;
				end
			end
			WALK_RIGHT_STATE: begin
				if (bump_left) begin
					next_state = WALK_LEFT_STATE;
				end else if (!ground) begin
					next_state = FALL_STATE;
				end else if (dig) begin
					next_state = DIG_STATE;
				end
			end
			FALL_STATE: begin
				if (ground) begin
					if (fall_counter >= MAX_FALL_TIME) begin
						next_state = SPLATTER_STATE;
					end else begin
						if (current_state == WALK_LEFT_STATE) begin
							next_state = WALK_LEFT_STATE;
						end else if (current_state == WALK_RIGHT_STATE) begin
							next_state = WALK_RIGHT_STATE;
						end
					end
					fall_counter = 0;
				end else begin
					fall_counter = fall_counter + 1;
				end
			end
			DIG_STATE: begin
				if (!ground) begin
					next_state = FALL_STATE;
				end else if (!dig) begin
					if (current_state == WALK_LEFT_STATE) begin
						next_state = WALK_LEFT_STATE;
					end else if (current_state == WALK_RIGHT_STATE) begin
						next_state = WALK_RIGHT_STATE;
					end
				end
			end
			SPLATTER_STATE: begin
				next_state = SPLATTER_STATE;
			end
		endcase
	end
	
	// Define outputs based on current state
	assign aaah = (current_state == FALL_STATE && ground);
	assign digging = (current_state == DIG_STATE && ground);
	assign walk_left = (current_state == WALK_LEFT_STATE || current_state == DIG_STATE);
	assign walk_right = (current_state == WALK_RIGHT_STATE || current_state == DIG_STATE);
endmodule
