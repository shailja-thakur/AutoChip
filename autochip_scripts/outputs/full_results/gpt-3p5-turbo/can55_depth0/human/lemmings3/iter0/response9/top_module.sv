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
parameter [1:0] IDLE = 2'b00;
parameter [1:0] WALK_LEFT = 2'b01;
parameter [1:0] WALK_RIGHT = 2'b10;
parameter [1:0] FALL = 2'b11;

// Define state register and next-state logic
reg [1:0] state, next_state;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= IDLE;
	end else begin
		state <= next_state;
	end
end

// Define outputs
assign walk_left = (state == WALK_LEFT);
assign walk_right = (state == WALK_RIGHT);
assign aaah = (state == FALL);
assign digging = ((state == WALK_LEFT || state == WALK_RIGHT) && dig);

// Define next-state logic and output logic
always @* begin
	next_state = state;

	if (state == IDLE) begin
		if (bump_left && bump_right) begin
			next_state = WALK_RIGHT;
		end else if (bump_left) begin
			next_state = WALK_RIGHT;
		end else if (bump_right) begin
			next_state = WALK_LEFT;
		end else if (!ground) begin
			next_state = FALL;
		end
	end else if (state == WALK_LEFT) begin
		if (bump_right) begin
			next_state = WALK_RIGHT;
		end else if (!ground) begin
			next_state = FALL;
		end else if (dig) begin
			next_state = WALK_LEFT;
		end
	end else if (state == WALK_RIGHT) begin
		if (bump_left) begin
			next_state = WALK_LEFT;
		end else if (!ground) begin
			next_state = FALL;
		end else if (dig) begin
			next_state = WALK_RIGHT;
		end
	end else if (state == FALL) begin
		if (ground) begin
			if (next_state == WALK_LEFT) begin
				next_state = WALK_LEFT;
			end else if (next_state == WALK_RIGHT) begin
				next_state = WALK_RIGHT;
			end else begin
				next_state = IDLE;
			end
		end
	end
end

endmodule
