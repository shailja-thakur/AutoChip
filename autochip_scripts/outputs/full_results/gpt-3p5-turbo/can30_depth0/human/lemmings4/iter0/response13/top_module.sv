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
		FALLING_LEFT,
		FALLING_RIGHT,
		DIGGING_LEFT,
		DIGGING_RIGHT,
		SPLATTERED
	} state_type;

	// Define the state register
	reg state_type current_state;
	reg state_type next_state;

	// Define the outputs
	reg [3:0] aaah_delay;
	reg [4:0] fall_count;
	reg [3:0] dig_delay;
	reg [1:0] walk_direction;

	// Define the parameters
	parameter MAX_FALL_COUNT = 20;
	parameter DELAY_AAHH = 3;

	// Synchronous reset
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= WALK_LEFT;
			aaah_delay <= 0;
			fall_count <= 0;
			dig_delay <= 0;
			walk_direction <= 1;
		end else begin
			current_state <= next_state;
			aaah_delay <= aaah_delay + 1;
			fall_count <= (current_state == FALLING_LEFT || current_state == FALLING_RIGHT) ? fall_count + 1 : 0;
			dig_delay <= (dig_delay > 0 && (ground == 1 && current_state == current_state & WALK_LEFT)) ? dig_delay - 1 :
				     (dig_delay > 0 && (ground == 1 && current_state == current_state & WALK_RIGHT)) ? dig_delay - 1 :
				     (ground == 1) ? 0 : dig_delay;
		end
	end

	// Next state logic
	always_comb begin
		case (current_state)
			WALK_LEFT: begin
				if (bump_right && !bump_left) begin
					next_state = WALK_RIGHT;
					walk_direction = 0;
				end else if (ground == 0) begin
					next_state = FALLING_LEFT;
				end else if (dig && ground == 1 && dig_delay == 0) begin
					next_state = DIGGING_LEFT;
					dig_delay = 5;
				end else begin
					next_state = WALK_LEFT;
				end
			end
			WALK_RIGHT: begin
				if (bump_left && !bump_right) begin
					next_state = WALK_LEFT;
					walk_direction = 1;
				end else if (ground == 0) begin
					next_state = FALLING_RIGHT;
				end else if (dig && ground == 1 && dig_delay == 0) begin
					next_state = DIGGING_RIGHT;
					dig_delay = 5;
				end else begin
					next_state = WALK_RIGHT;
				end
			end
			FALLING_LEFT: begin
				if (ground == 1) begin
					if (fall_count >= MAX_FALL_COUNT) begin
						next_state = SPLATTERED;
					end else if (walk_direction == 0) begin
						next_state = WALK_RIGHT;
					end else if (dig && ground == 1 && dig_delay == 0) begin
						next_state = DIGGING_LEFT;
						dig_delay = 5;
					end else begin
						next_state = WALK_LEFT;
					end
				end else begin
					next_state = FALLING_LEFT;
				end
			end
			FALLING_RIGHT: begin
				if (ground == 1) begin
					if (fall_count >= MAX_FALL_COUNT) begin
						next_state = SPLATTERED;
					end else if (walk_direction == 1) begin
						next_state = WALK_LEFT;
					end else if (dig && ground == 1 && dig_delay == 0) begin
						next_state = DIGGING_RIGHT;
						dig_delay = 5;
					end else begin
						next_state = WALK_RIGHT;
					end
				end else begin
					next_state = FALLING_RIGHT;
				end
			end
			DIGGING_LEFT: begin
				if (ground == 0) begin
					next_state = FALLING_LEFT;
				end else if (dig_delay == 0) begin
					if (walk_direction == 0) begin
						next_state = WALK_RIGHT;
					end else if (bump_left) begin
						next_state = WALK_LEFT;
						walk_direction = 1;
					end else begin
						next_state = DIGGING_LEFT;
					end
				end else begin
					next_state = DIGGING_LEFT;
				end
			end
			DIGGING_RIGHT: begin
				if (ground == 0) begin
					next_state = FALLING_RIGHT;
				end else if (dig_delay == 0) begin
					if (walk_direction == 1) begin
						next_state = WALK_LEFT;
					end else if (bump_left) begin
						next_state = WALK_LEFT;
						walk_direction = 0;
					end else begin
						next_state = DIGGING_RIGHT;
					end
				end else begin
					next_state = DIGGING_RIGHT;
				end
			end
			SPLATTERED: begin
				next_state = SPLATTERED;
			end
		endcase
	end

	// Output logic
	assign walk_left = (current_state == WALK_LEFT) ? 1 : 0;
	assign walk_right = (current_state == WALK_RIGHT) ? 1 : 0;
	assign aaah = (aaah_delay < DELAY_AAHH && (current_state == FALLING_LEFT || current_state == FALLING_RIGHT)) ? 1 : 0;
	assign digging = (current_state == DIGGING_LEFT || current_state == DIGGING_RIGHT) ? 1 : 0;

endmodule
