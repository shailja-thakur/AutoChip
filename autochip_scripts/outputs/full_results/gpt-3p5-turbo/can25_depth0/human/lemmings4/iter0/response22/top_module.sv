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
	typedef enum logic [3:0] {
		WALK_LEFT,
		WALK_RIGHT,
		FALL,
		DIG,
		SPLATTER
	} state_t;
	
	state_t current_state, next_state;
	
	// Define the outputs
	logic walk_left_out;
	logic walk_right_out;
	logic aaah_out;
	logic dig_out;
	
	// Define the counters
	logic [4:0] fall_counter;
	logic [4:0] dig_counter;
	
	// State register
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= WALK_LEFT;
		end
		else begin
			current_state <= next_state;
		end
	end
	
	// Next state logic
	always_comb begin
		case (current_state)
			WALK_LEFT:
				if (bump_right && ground && !fall_counter) begin
					next_state = WALK_RIGHT;
				end
				else if (bump_right && !fall_counter) begin
					next_state = WALK_LEFT;
				end
				else if (!ground) begin
					next_state = FALL;
				end
				else if (dig && !fall_counter) begin
					next_state = DIG;
				end
				else begin
					next_state = WALK_LEFT;
				end
				
			WALK_RIGHT:
				if (bump_left && ground && !fall_counter) begin
					next_state = WALK_LEFT;
				end
				else if (bump_left && !fall_counter) begin
					next_state = WALK_RIGHT;
				end
				else if (!ground) begin
					next_state = FALL;
				end
				else if (dig && !fall_counter) begin
					next_state = DIG;
				end
				else begin
					next_state = WALK_RIGHT;
				end
				
			FALL:
				if (fall_counter == 5'b10011 && ground) begin
					next_state = SPLATTER;
				end
				else if (ground && !bump_left && !bump_right) begin
					next_state = current_state;
				end
				else if (ground && (bump_left || bump_right)) begin
					next_state = FALL;
				end
				else begin
					next_state = FALL;
				end
				
			DIG:
				if (!ground) begin
					next_state = FALL;
				end
				else if (dig_counter == 5'b10100) begin
					next_state = FALL;
				end
				else begin
					next_state = DIG;
				end
				
			SPLATTER:
				next_state = SPLATTER;
		endcase
	end
	
	// Output logic
	always_comb begin
		case (current_state)
			WALK_LEFT:
				walk_left_out = 1;
				walk_right_out = 0;
				aaah_out = 0;
				dig_out = 0;
				
			WALK_RIGHT:
				walk_left_out = 0;
				walk_right_out = 1;
				aaah_out = 0;
				dig_out = 0;
				
			FALL:
				walk_left_out = 0;
				walk_right_out = 0;
				aaah_out = 1;
				dig_out = 0;
				
			DIG:
				walk_left_out = 0;
				walk_right_out = 0;
				aaah_out = 0;
				dig_out = 1;
				
			SPLATTER:
				walk_left_out = 0;
				walk_right_out = 0;
				aaah_out = 0;
				dig_out = 0;
		endcase
	end
	
	// Counter logic
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			fall_counter <= 'b0;
			dig_counter <= 'b0;
		end
		else begin
			case (current_state)
				FALL:
					fall_counter <= fall_counter + 1;
					
				DIG:
					dig_counter <= dig_counter + 1;
						
				default:
					fall_counter <= 'b0;
					dig_counter <= 'b0;
			endcase
		end
	end
	
	assign walk_left = walk_left_out;
	assign walk_right = walk_right_out;
	assign aaah = aaah_out;
	assign digging = dig_out;

endmodule
