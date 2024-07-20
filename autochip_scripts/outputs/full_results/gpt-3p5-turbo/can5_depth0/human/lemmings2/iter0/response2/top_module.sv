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

	// Declare the states
	typedef enum logic [1:0] {
		IDLE,
		WALK_LEFT,
		WALK_RIGHT,
		FALL
	} state_type;
	
	// Declare the current state and next state signals
	logic [1:0] curr_state, next_state;
	
	// Declare signals to keep track of the walking direction and falling status
	logic walk_direction;
	logic falling;
	
	// Declare the output signals
	assign walk_left = (curr_state == WALK_LEFT);
	assign walk_right = (curr_state == WALK_RIGHT);
	assign aaah = (curr_state == FALL);
	
	// Sequential always block for state transition
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			curr_state <= IDLE;
			walk_direction <= 1'b0;
			falling <= 1'b0;
		end else begin
			curr_state <= next_state;
			walk_direction <= (next_state == WALK_LEFT) ? 1'b1 : 1'b0;
			
			if (ground == 1'b1) begin
				falling <= 1'b0;
			end else if (curr_state == FALL) begin
				falling <= 1'b1;
			end
		end
	end
	
	// Combinational always block for state and next state logic
	always_comb begin
		next_state = curr_state;
		
		case(curr_state)
			IDLE: begin
				if (areset) begin
					next_state = WALK_LEFT;
				end else if (bump_left == 1'b1) begin
					next_state = WALK_RIGHT;
				end else if (bump_right == 1'b1) begin
					next_state = WALK_LEFT;
				end
			end
			WALK_LEFT: begin
				if (bump_right == 1'b1) begin
					next_state = WALK_RIGHT;
				end else if (ground == 1'b0) begin
					next_state = FALL;
				end
			end
			WALK_RIGHT: begin
				if (bump_left == 1'b1) begin
					next_state = WALK_LEFT;
				end else if (ground == 1'b0) begin
					next_state = FALL;
				end
			end
			FALL: begin
				if (ground == 1'b1) begin
					next_state = (walk_direction == 1'b1) ? WALK_LEFT : WALK_RIGHT;
				end
			end
		endcase
	end
	
endmodule
