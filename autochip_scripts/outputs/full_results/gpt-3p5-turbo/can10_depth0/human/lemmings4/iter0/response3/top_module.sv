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
	
	reg [4:0] state;

	// Define the states
	parameter INIT = 0;
	parameter WALK_LEFT = 1;
	parameter WALK_RIGHT = 2;
	parameter FALL = 3;
	parameter DIGGING = 4;
	parameter SPLATTER = 5;

	// Define the state outputs
	assign walk_left = (state == WALK_LEFT) ? 1 : 0;
	assign walk_right = (state == WALK_RIGHT) ? 1 : 0;
	assign aaah = (state == FALL || state == SPLATTER) ? 1 : 0;
	assign digging = (state == DIGGING) ? 1 : 0;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= INIT;
		end else begin
			case (state)
				INIT:
					if (areset) begin
						state <= INIT;
					end else if (bump_left) begin
						state <= WALK_RIGHT;
					end else if (bump_right) begin
						state <= WALK_LEFT;
					end else begin
						state <= INIT;
					end
				WALK_LEFT:
					if (areset) begin
						state <= INIT;
					end else if (bump_left) begin
						state <= WALK_RIGHT;
					end else if (bump_right) begin
						state <= WALK_LEFT;
					end else if (ground == 0) begin
						state <= FALL;
					end else if (dig) begin
						state <= DIGGING;
					end else begin
						state <= WALK_LEFT;
					end
				WALK_RIGHT:
					if (areset) begin
						state <= INIT;
					end else if (bump_left) begin
						state <= WALK_RIGHT;
					end else if (bump_right) begin
						state <= WALK_LEFT;
					end else if (ground == 0) begin
						state <= FALL;
					end else if (dig) begin
						state <= DIGGING;
					end else begin
						state <= WALK_RIGHT;
					end
				FALL:
					if (areset) begin
						state <= INIT;
					end else if (ground == 1) begin
						state <= (state == WALK_LEFT) ? WALK_LEFT : WALK_RIGHT;
					end else if (dig) begin
						state <= DIGGING;
					end else if (state_elapsed > 20) begin
						state <= SPLATTER;
					end else begin
						state <= FALL;
					end
				DIGGING:
					if (areset) begin
						state <= INIT;
					end else if ((state == WALK_LEFT || state == WALK_RIGHT) && ground == 0) begin
						state <= FALL;
					end else if (state_elapsed > 20) begin
						state <= SPLATTER;
					end else begin
						state <= DIGGING;
					end
				SPLATTER:
					state <= SPLATTER;
			endcase
		end
	end
endmodule
