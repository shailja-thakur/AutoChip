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

// State assignment
parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;
parameter FALL = 2'b10;
parameter DIG = 2'b11;

reg [1:0] state, next_state;

// Outputs
assign walk_left = (state == WALK_LEFT) ? 1'b1 : 1'b0;
assign walk_right = (state == WALK_RIGHT) ? 1'b1 : 1'b0;
assign aaah = (state == FALL) ? 1'b1 : 1'b0;
assign digging = (state == DIG) ? 1'b1 : 1'b0;

// Logic for state transitions
always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= WALK_LEFT;
	end else begin
		state <= next_state;
	end
end

// Logic for next state calculation
always @(*) begin
	case (state)
		WALK_LEFT: begin
			if (bump_right & ~bump_left) begin
				next_state = FALL;
			end else if (bump_left) begin
				next_state = WALK_RIGHT;
			end else if (dig & ground) begin
				next_state = DIG;
			end else begin
				next_state = WALK_LEFT;
			end
		end
		WALK_RIGHT: begin
			if (bump_left & ~bump_right) begin
				next_state = FALL;
			end else if (bump_right) begin
				next_state = WALK_LEFT;
			end else if (dig & ground) begin
				next_state = DIG;
			end else begin
				next_state = WALK_RIGHT;
			end
		end
		FALL: begin
			if (ground) begin
				next_state = state;
			end else begin
				next_state = FALL;
			end
		end
		DIG: begin
			if (ground) begin
				next_state = WALK_LEFT;
			end else begin
				next_state = DIG;
			end
		end
	endcase
end

endmodule
