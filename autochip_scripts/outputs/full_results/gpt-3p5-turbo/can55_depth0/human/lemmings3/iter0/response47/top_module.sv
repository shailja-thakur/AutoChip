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
	
	// State enumeration
	typedef enum logic [3:0] {
		WALK_LEFT,
		WALK_RIGHT,
		FALL,
		DIG
	} state_t;
	
	reg [3:0] state;
	reg [3:0] next_state;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= WALK_LEFT;
		end else begin
			state <= next_state;
		end
	end
	
	always @* begin
		next_state = state;
		walk_left = 0;
		walk_right = 0;
		aaah = 0;
		digging = 0;
		
		case(state)

			WALK_LEFT:
				if (bump_right) begin
					next_state = WALK_RIGHT;
					walk_right = 1;
				end else if (~ground) begin
					next_state = FALL;
					aaah = 1;
				end else if (dig) begin
					next_state = DIG;
					digging = 1;
				end
				
			WALK_RIGHT:
				if (bump_left) begin
					next_state = WALK_LEFT;
					walk_left = 1;
				end else if (~ground) begin
					next_state = FALL;
					aaah = 1;
				end else if (dig) begin
					next_state = DIG;
					digging = 1;
				end
				
			FALL:
				if (ground) begin
					next_state = state;
				end
				
			DIG:
				if (~ground) begin
					next_state = FALL;
					aaah = 1;
					walk_left = 1;
				end
						
		endcase
	end
	
endmodule
