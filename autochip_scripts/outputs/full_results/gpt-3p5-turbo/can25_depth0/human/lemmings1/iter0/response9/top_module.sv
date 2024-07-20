module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);

reg [1:0] next_state;
reg [1:0] current_state;
reg walk_left;
reg walk_right;

parameter WALK_LEFT = 2'b01;
parameter WALK_RIGHT = 2'b10;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		current_state <= WALK_LEFT;
		walk_left <= 1;
		walk_right <= 0;
	end else begin
		current_state <= next_state;
		case (current_state)
			WALK_LEFT: begin
				if (bump_right) begin
					next_state <= WALK_RIGHT;
					walk_left <= 0;
					walk_right <= 1;
				end else if (bump_left) begin
					next_state <= WALK_LEFT;
					walk_left <= 1;
					walk_right <= 0;
				end else begin
					next_state <= WALK_LEFT;
					walk_left <= 1;
					walk_right <= 0;
				end
			end
			WALK_RIGHT: begin
				if (bump_left) begin
					next_state <= WALK_LEFT;
					walk_left <= 1;
					walk_right <= 0;
				end else if (bump_right) begin
					next_state <= WALK_RIGHT;
					walk_left <= 0;
					walk_right <= 1;
				end else begin
					next_state <= WALK_RIGHT;
					walk_left <= 0;
					walk_right <= 1;
				end
			end
		endcase
	end
end

endmodule
