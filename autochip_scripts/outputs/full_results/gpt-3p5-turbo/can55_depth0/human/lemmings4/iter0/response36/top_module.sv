module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	input dig,
	output reg walk_left,
	output reg walk_right,
	output reg aaah,
	output reg digging
);

	// State declaration
	typedef enum logic [2:0] {
		WALK_LEFT,
		WALK_RIGHT,
		FALL,
		DIG,
		SPLATTER
	} state_t;
	
	reg [2:0] curr_state;
	reg [2:0] next_state;
	
	// Define the output behavior for each state
	always_comb begin
		case(curr_state)
			WALK_LEFT: begin
				walk_left = 1;
				walk_right = 0;
				aaah = 0;
				digging = 0;
			end
			
			WALK_RIGHT: begin
				walk_left = 0;
				walk_right = 1;
				aaah = 0;
				digging = 0;
			end
			
			FALL: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 1;
				digging = 0;
			end
			
			DIG: begin
				walk_left = 1;
				walk_right = 0;
				aaah = 0;
				digging = 1;
			end
			
			SPLATTER: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
				digging = 0;
			end
		endcase
	end

	// Define the next state logic
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			curr_state <= WALK_LEFT;
		end else begin
			curr_state <= next_state;
		end
	end
	
	// Define the next state logic
	always_comb begin
		next_state = curr_state;
		
		case(curr_state)
			WALK_LEFT: begin
				if (bump_right) begin
					next_state = WALK_RIGHT;
				end else if (!ground) begin
					next_state = FALL;
				end else if (dig) begin
					next_state = DIG;
				end
			end
			
			WALK_RIGHT: begin
				if (bump_left) begin
					next_state = WALK_LEFT;
				end else if (!ground) begin
					next_state = FALL;
				end else if (dig) begin
					next_state = DIG;
				end
			end
			
			FALL: begin
				if (ground) begin
					next_state = curr_state;
				end else if (dig) begin
					next_state = DIG;
				end else if (curr_state == FALL && !ground)
					next_state = SPLATTER;
				end
			end
			
			DIG: begin
				if (!ground) begin
					next_state = FALL;
				end
			end
			
			SPLATTER: begin
				next_state = SPLATTER;
			end
		endcase
	end

endmodule
