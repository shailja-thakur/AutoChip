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
	// Define the states
	parameter WALK_LEFT = 2'b00;
	parameter WALK_RIGHT = 2'b01;
	parameter FALL = 2'b10;
	parameter DIG = 2'b11;
	
	// Define the signals
	reg [1:0] state;
	reg [1:0] next_state;
	reg walk_left;
	reg walk_right;
	reg aaah;
	reg digging;
	
	// Next state logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= WALK_LEFT;
			walk_left <= 1;
			walk_right <= 0;
		end
		else begin
			state <= next_state;
			walk_left <= 0;
			walk_right <= 0;
		end
	end
	
	// Output logic
	always @(state or bump_left or bump_right or ground or dig) begin
		case (state)
			WALK_LEFT:
				begin
					if (bump_right && !bump_left)
						next_state = WALK_RIGHT;
					else if (!bump_right && bump_left)
						next_state = WALK_LEFT;
					else if (bump_right && bump_left)
						next_state = WALK_RIGHT;
					else if (dig && ground)
						next_state = DIG;
					else if (!ground)
						next_state = FALL;
				end
			WALK_RIGHT:
				begin
                    if (!bump_right && bump_left)
						next_state = WALK_LEFT;
					else if (bump_right && !bump_left)
						next_state = WALK_RIGHT;
					else if (bump_right && bump_left)
						next_state = WALK_LEFT;
					else if (dig && ground)
						next_state = DIG;
					else if (!ground)
						next_state = FALL;
				end
			FALL:
				begin
					if (!ground)
						next_state = FALL;
					else if (dig && ground)
						next_state = DIG;
					else if (!dig)
						next_state = WALK_LEFT;
				end
			DIG:
				begin
					if (!ground)
						next_state = FALL;
					else if (!dig && walk_left)
						next_state = WALK_LEFT;
					else if (!dig && walk_right)
						next_state = WALK_RIGHT;
				end
		endcase
	end
	
	// Output assignments
	assign aaah = (state == FALL);
	assign digging = (state == DIG);
endmodule
