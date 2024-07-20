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
typedef enum logic [2:0] {
	ST_WALK_LEFT,
	ST_WALK_RIGHT,
	ST_FALL,
	ST_DIG
} State;

// Define signals
reg [2:0] state;
reg walk_left, walk_right, aaah, digging;

// Define initial state
initial state = ST_WALK_LEFT;

// Define state transitions and outputs
always @(posedge clk or posedge areset)
	if (areset) begin
		state <= ST_WALK_LEFT;
		walk_left <= 1;
		walk_right <= 0;
		aaah <= 0;
		digging <= 0;
	end else begin
		case (state)
			ST_WALK_LEFT: begin
				if (ground == 0) begin
					state <= ST_FALL;
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 1;
					digging <= 0;
				end else if (bump_right == 1) begin
					state <= ST_WALK_RIGHT;
					walk_left <= 0;
					walk_right <= 1;
					aaah <= 0;
					digging <= 0;
				end else if (dig == 1 && ground == 1) begin
					state <= ST_DIG;
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 0;
					digging <= 1;
				end
			end
			ST_WALK_RIGHT: begin
				if (ground == 0) begin
					state <= ST_FALL;
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 1;
					digging <= 0;
				end else if (bump_left == 1) begin
					state <= ST_WALK_LEFT;
					walk_left <= 1;
					walk_right <= 0;
					aaah <= 0;
					digging <= 0;
				end else if (dig == 1 && ground == 1) begin
					state <= ST_DIG;
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 0;
					digging <= 1;
				end
			end
			ST_FALL: begin
				if (ground == 1) begin
					if (state == ST_WALK_LEFT) begin
						state <= ST_WALK_LEFT;
						walk_left <= 1;
						walk_right <= 0;
						aaah <= 0;
						digging <= 0;
					end else if (state == ST_WALK_RIGHT) begin
						state <= ST_WALK_RIGHT;
						walk_left <= 0;
						walk_right <= 1;
						aaah <= 0;
						digging <= 0;
					end
				end
			end
			ST_DIG: begin
				if (ground == 0) begin
					state <= ST_FALL;
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 1;
					digging <= 0;
				end else if (bump_left == 1 && ground == 1) begin
					state <= ST_DIG;
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 0;
					digging <= 1;
				end else if (bump_right == 1 && ground == 1) begin
					state <= ST_DIG;
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 0;
					digging <= 1;
				end
			end
		endcase
	end

endmodule
