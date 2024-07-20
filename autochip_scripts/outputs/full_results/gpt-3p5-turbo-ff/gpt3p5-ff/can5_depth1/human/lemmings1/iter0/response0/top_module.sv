module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);

reg [1:0] next_state, current_state;
reg walking_left, walking_right;

parameter STATE_WALK_LEFT = 2'b00;
parameter STATE_WALK_RIGHT = 2'b01;

// Define the Moore output
assign walk_left = (current_state == STATE_WALK_LEFT) ? 1'b1 : 1'b0;
assign walk_right = (current_state == STATE_WALK_RIGHT) ? 1'b1 : 1'b0;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		current_state <= STATE_WALK_LEFT;
		walking_left <= 1'b1;
		walking_right <= 1'b0;
	end else begin
		current_state <= next_state;
		walking_left <= walking_left;
		walking_right <= walking_right;
	end
end

always @(current_state, bump_left, bump_right) begin
	case(current_state)
		STATE_WALK_LEFT: begin
			if (bump_right || (bump_left && bump_right)) begin
				next_state <= STATE_WALK_RIGHT;
			end else begin
				next_state <= STATE_WALK_LEFT;
			end
		end
		STATE_WALK_RIGHT: begin
			if (bump_left || (bump_left && bump_right)) begin
				next_state <= STATE_WALK_LEFT;
			end else begin
				next_state <= STATE_WALK_RIGHT;
			end
		end
	endcase
end

endmodule
