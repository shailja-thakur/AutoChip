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
	typedef enum logic [1:0] {
		WALK_LEFT,
		WALK_RIGHT,
		FALL,
		DIG
	} state_t;
	
	// Define signals
	logic [1:0] state;
	logic [1:0] next_state;
	logic [1:0] prev_state;
	logic walk_left_int;
	logic walk_right_int;
	logic aaah_int;
	logic digging_int;
	
	// Define state transitions
	always_ff @(posedge clk or posedge areset)
	begin
		if (areset)
		begin
			state <= WALK_LEFT;
		end
		else
		begin
			state <= next_state;
		end
	end
	
	// Define state outputs
	always_comb
	begin
		case (state)
			WALK_LEFT:
			begin
				walk_left_int = 1;
				walk_right_int = 0;
				aaah_int = 0;
				digging_int = (ground && !dig) ? 1'b1 : 1'b0;
				
				if (bump_right)
				begin
					next_state = WALK_RIGHT;
				end
				else if (ground && !bump_left && dig)
				begin
					next_state = DIG;
				end
				else if (!ground)
				begin
					next_state = FALL;
				end
				else
				begin
					next_state = state;
				end
			end
			
			WALK_RIGHT:
			begin
				walk_left_int = 0;
				walk_right_int = 1;
				aaah_int = 0;
				digging_int = (ground && !dig) ? 1'b1 : 1'b0;
				
				if (bump_left)
				begin
					next_state = WALK_LEFT;
				end
				else if (ground && !bump_right && dig)
				begin
					next_state = DIG;
				end
				else if (!ground)
				begin
					next_state = FALL;
				end
				else
				begin
					next_state = state;
				end
			end
			
			FALL:
			begin
				walk_left_int = 0;
				walk_right_int = 0;
				aaah_int = 1;
				digging_int = (ground && !dig) ? 1'b1 : 1'b0;
				
				if (ground)
				begin
					next_state = prev_state;
				end
				else
				begin
					next_state = FALL;
				end
			end
			
			DIG:
			begin
				walk_left_int = 0;
				walk_right_int = 0;
				aaah_int = 0;
				digging_int = (ground && !dig) ? 1'b1 : 1'b0;
				
				if (!ground)
				begin
					next_state = FALL;
				end
				else
				begin
					next_state = prev_state;
				end
			end
		endcase
	end
	
	// Assign outputs
	assign walk_left = walk_left_int;
	assign walk_right = walk_right_int;
	assign aaah = aaah_int;
	assign digging = digging_int;

endmodule
