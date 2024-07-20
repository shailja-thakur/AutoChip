module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output reg walk_left,
	output reg walk_right
);
	// State declaration
	enum logic [1:0] state;
	parameter LEFT = 2'b00;
	parameter RIGHT = 2'b01;
	
	// Next state logic
	always @(posedge clk, negedge areset) begin
		if (areset) begin
			state <= LEFT;
		end else begin
			if (state == LEFT && bump_right) begin
				state <= RIGHT;
			end else if (state == RIGHT && bump_left) begin
				state <= LEFT;
			end else begin
				state <= state;
			end
		end
	end
	
	// Output logic
	always @(state) begin
		walk_left = (state == LEFT);
		walk_right = (state == RIGHT);
	end
	
endmodule
