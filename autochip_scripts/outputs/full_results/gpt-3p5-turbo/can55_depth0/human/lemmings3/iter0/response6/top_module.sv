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
	// Define states for the state machine
	typedef enum logic [1:0] {
		WALK_LEFT,
		WALK_RIGHT,
		FALL,
		DIG
	} state_type;

	// Declare state and next_state variables
	logic [1:0] state, next_state;

	// Define state register and next_state register
	reg [1:0] state_reg, next_state_reg;

	// Define combinational outputs
	reg walk_left_reg, walk_right_reg, aaah_reg, digging_reg;

	always @ (posedge clk or posedge areset) begin
		if (areset) begin
			state <= WALK_LEFT;
			next_state <= WALK_LEFT;
			walk_left_reg <= 1;
			walk_right_reg <= 0;
			aaah_reg <= 0;
			digging_reg <= 0;
		end else begin
			state <= next_state;
			walk_left_reg <= walk_left_reg;
			walk_right_reg <= walk_right_reg;
			aaah_reg <= aaah_reg;
			digging_reg <= digging_reg;
		end
	end

	always @* begin
		case (state)
			WALK_LEFT:
				if (bump_left || (bump_left && bump_right)) begin
					next_state = WALK_RIGHT;
					walk_left_reg = 0;
					walk_right_reg = 1;
					aaah_reg = 0;
					digging_reg = 0;
				end else if (~ground) begin
					next_state = FALL;
					walk_left_reg = walk_left_reg;
					walk_right_reg = walk_right_reg;
					aaah_reg = 1;
					digging_reg = 0;
				end else if (dig && ground) begin
					next_state = DIG;
					walk_left_reg = walk_left_reg;
					walk_right_reg = walk_right_reg;
					aaah_reg = 0;
					digging_reg = 1;
				end else begin
					next_state = WALK_LEFT;
					walk_left_reg = 1;
					walk_right_reg = 0;
					aaah_reg = 0;
					digging_reg = 0;
				end
			WALK_RIGHT:
				if (bump_right || (bump_left && bump_right)) begin
					next_state = WALK_LEFT;
					walk_left_reg = 1;
					walk_right_reg = 0;
					aaah_reg = 0;
					digging_reg = 0;
				end else if (~ground) begin
					next_state = FALL;
					walk_left_reg = walk_left_reg;
					walk_right_reg = walk_right_reg;
					aaah_reg = 1;
					digging_reg = 0;
				end else if (dig && ground) begin
					next_state = DIG;
					walk_left_reg = walk_left_reg;
					walk_right_reg = walk_right_reg;
					aaah_reg = 0;
					digging_reg = 1;
				end else begin
					next_state = WALK_RIGHT;
					walk_left_reg = 0;
					walk_right_reg = 1;
					aaah_reg = 0;
					digging_reg = 0;
				end
			FALL:
				if (ground) begin
					next_state = state_reg;
					walk_left_reg = walk_left_reg;
					walk_right_reg = walk_right_reg;
					aaah_reg = 0;
					digging_reg = 0;
				end else begin
					next_state = FALL;
					walk_left_reg = walk_left_reg;
					walk_right_reg = walk_right_reg;
					aaah_reg = 1;
					digging_reg = 0;
				end
			DIG:
				if (~ground && ~(bump_left && bump_right)) begin
					next_state = FALL;
					walk_left_reg = walk_left_reg;
					walk_right_reg = walk_right_reg;
					aaah_reg = 1;
					digging_reg = 0;
				end else if (ground) begin
					next_state = state_reg;
					walk_left_reg = walk_left_reg;
					walk_right_reg = walk_right_reg;
					aaah_reg = 0;
					digging_reg = 0;
				end else begin
					next_state = DIG;
					walk_left_reg = walk_left_reg;
					walk_right_reg = walk_right_reg;
					aaah_reg = 0;
					digging_reg = 1;
				end
		endcase
	end

	assign walk_left = walk_left_reg;
	assign walk_right = walk_right_reg;
	assign aaah = aaah_reg;
	assign digging = digging_reg;
endmodule
