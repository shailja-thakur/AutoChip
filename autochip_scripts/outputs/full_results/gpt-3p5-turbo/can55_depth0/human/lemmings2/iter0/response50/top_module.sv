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

// Define the states
parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;
parameter FALL = 2'b10;

reg [1:0] state, next_state;

// Define the outputs
assign walk_left = (state == WALK_LEFT);
assign walk_right = (state == WALK_RIGHT);
assign aaah = (state == FALL);

// Define the next state logic
always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= WALK_LEFT;
	end else begin
		state <= next_state;
	end
end

// Define the state transition logic
always @(state, bump_left, bump_right, ground) begin
	case (state)
		WALK_LEFT:
			if (bump_right) begin
				next_state = WALK_RIGHT;
			end else if (bump_left) begin
				next_state = WALK_LEFT;
			end else begin
				if (ground) begin
					next_state = WALK_LEFT;
				end else begin
					next_state = FALL;
				end
			end
		WALK_RIGHT:
			if (bump_left) begin
				next_state = WALK_LEFT;
			end else if (bump_right) begin
				next_state = WALK_RIGHT;
			end else begin
				if (ground) begin
					next_state = WALK_RIGHT;
				end else begin
					next_state = FALL;
				end
			end
		FALL:
			if (ground) begin
				if (state == WALK_LEFT) begin
					next_state = WALK_LEFT;
				end else if (state == WALK_RIGHT) begin
					next_state = WALK_RIGHT;
				end
			end else begin
				next_state = FALL;
			end
	endcase
end

endmodule
