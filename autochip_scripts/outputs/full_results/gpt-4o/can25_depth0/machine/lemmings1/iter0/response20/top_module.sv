module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output reg walk_left,
	output reg walk_right
);
	parameter WL = 1'b0, WR = 1'b1;
	reg state, next_state;
	
	// State transition logic
	always @* begin
		case (state)
			WL: next_state = bump_left ? WR : WL;
			WR: next_state = bump_right ? WL : WR;
			default: next_state = WL;
		endcase
	end
	
	// State register
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= WL;
		else
			state <= next_state;
	end
	
	// Output logic
	always @* begin
		case (state)
			WL: begin
				walk_left = 1;
				walk_right = 0;
			end
			WR: begin
				walk_left = 0;
				walk_right = 1;
			end
		endcase
	end
endmodule
