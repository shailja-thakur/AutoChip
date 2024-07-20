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

	// State declaration
	typedef enum reg [2:0] {
		LEFT = 3'b001,
		RIGHT = 3'b010,
		LEFT_FALL = 3'b011,
		RIGHT_FALL = 3'b100
	} state_t;
	
	state_t current_state, next_state;

	// State transition
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= LEFT;
		end 
		else begin
			current_state <= next_state;
		end
	end

	// Next state logic
	always @(*) begin
		case (current_state)
			LEFT: begin
				if (~ground) begin
					next_state = LEFT_FALL;
				end else if (bump_left) begin
					next_state = RIGHT;
				end else if (bump_right) begin
					next_state = LEFT;
				end else begin
					next_state = LEFT;
				end
			end
			RIGHT: begin
				if (~ground) begin
					next_state = RIGHT_FALL;
				end else if (bump_right) begin
					next_state = LEFT;
				end else if (bump_left) begin
					next_state = RIGHT;
				end else begin
					next_state = RIGHT;
				end
			end
			LEFT_FALL: begin
				if (ground) begin
					next_state = LEFT;
				end else begin
					next_state = LEFT_FALL;
				end
			end
			RIGHT_FALL: begin
				if (ground) begin
					next_state = RIGHT;
				end else begin
					next_state = RIGHT_FALL;
				end
			end
			default: next_state = LEFT;
		endcase
	end

	// Output logic
	always @(*) begin
		walk_left = 0;
		walk_right = 0;
		aaah = 0;
		case (current_state)
			LEFT: walk_left = 1;
			RIGHT: walk_right = 1;
			LEFT_FALL: aaah = 1;
			RIGHT_FALL: aaah = 1;
		endcase
	end

endmodule
