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

	// Define states
	typedef enum logic [1:0] {
		WALK_LEFT,
		WALK_RIGHT,
		FALL
	} state_t;

	// Define output variables
	logic [1:0] current_state;
	logic walk_left_output;
	logic walk_right_output;
	logic aaah_output;

	// Define internal variables
	logic [1:0] next_state;

	// Assign initial values
	assign current_state = WALK_LEFT;
	assign walk_left_output = 1;
	assign walk_right_output = 0;
	assign aaah_output = 0;

	// Define state transitions and output assignments
	always_ff @(posedge clk, posedge areset) begin
		if (areset) begin
			current_state <= WALK_LEFT;
			next_state <= WALK_LEFT;
		end
		else begin
			current_state <= next_state;
			case (current_state)
				WALK_LEFT:
					if (bump_right) begin
						next_state <= WALK_RIGHT;
						walk_left_output <= 0;
						walk_right_output <= 1;
					end
					else if (ground == 0) begin
						next_state <= FALL;
						walk_left_output <= 0;
						walk_right_output <= 0;
						aaah_output <= 1;
					end
					else begin
						next_state <= WALK_LEFT;
						walk_left_output <= 1;
						walk_right_output <= 0;
					end
				WALK_RIGHT:
					if (bump_left) begin
						next_state <= WALK_LEFT;
						walk_left_output <= 1;
						walk_right_output <= 0;
					end
					else if (ground == 0) begin
						next_state <= FALL;
						walk_left_output <= 0;
						walk_right_output <= 0;
						aaah_output <= 1;
					end
					else begin
						next_state <= WALK_RIGHT;
						walk_left_output <= 0;
						walk_right_output <= 1;
					end
				FALL:
					if (ground == 1) begin
						if (current_state == WALK_LEFT) begin
							next_state <= WALK_LEFT;
							walk_left_output <= 1;
							walk_right_output <= 0;
						end
						else begin
							next_state <= WALK_RIGHT;
							walk_left_output <= 0;
							walk_right_output <= 1;
						end
						aaah_output <= 0;
					end
					else begin
						next_state <= FALL;
						walk_left_output <= 0;
						walk_right_output <= 0;
						aaah_output <= 1;
					end
			endcase
		end
	end

	// Assign output values
	assign walk_left = walk_left_output;
	assign walk_right = walk_right_output;
	assign aaah = aaah_output;

endmodule
