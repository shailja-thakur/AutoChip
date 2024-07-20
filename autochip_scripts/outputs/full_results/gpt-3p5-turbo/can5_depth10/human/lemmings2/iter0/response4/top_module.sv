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

// State encoding
parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;
parameter FALLING = 2'b10;

reg [1:0] state, next_state;

// Output assignments
assign walk_left = (state == WALK_LEFT);
assign walk_right = (state == WALK_RIGHT);
assign aaah = (state == FALLING);

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= WALK_LEFT;
	end else begin
		state <= next_state;
	end
end

always @* begin
	next_state = state;
	
	case (state)
		WALK_LEFT: begin
			if (bump_right) begin
				next_state = WALK_RIGHT;
			end else if (!ground) begin
				next_state = FALLING;
			end
		end
		WALK_RIGHT: begin
			if (bump_left) begin
				next_state = WALK_LEFT;
			end else if (!ground) begin
				next_state = FALLING;
			end
		end
		FALLING: begin
			if (ground) begin
				if (state == WALK_LEFT) begin
					next_state = WALK_LEFT;
				end else begin
					next_state = WALK_RIGHT;
				end
			end
		end
	endcase
end

endmodule
