module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	input dig,
	output reg walk_left,
	output reg walk_right,
	output reg aaah,
	output reg digging
);
	reg [1:0] state; // state register
	parameter WALK_LEFT = 2'b00;   // walking left state
	parameter WALK_RIGHT = 2'b01;  // walking right state
	parameter DIG = 2'b10;         // digging state
	parameter FALL = 2'b11;        // falling state

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= WALK_LEFT;   // initialize state to walking left
			walk_left <= 1;
			walk_right <= 0;
			aaah <= 0;
			digging <= 0;
		end else begin
			case (state)
				WALK_LEFT: begin
					if (bump_left) begin
						state <= WALK_RIGHT;
						walk_left <= 0;
						walk_right <= 1;
					end else if (bump_right) begin
						state <= FALL;
						walk_left <= 0;
						walk_right <= 0;
						aaah <= 1;
					end else if (dig && ground) begin
						state <= DIG;
						walk_left <= 0;
						walk_right <= 0;
						digging <= 1;
					end
				end
				WALK_RIGHT: begin
					if (bump_right) begin
						state <= WALK_LEFT;
						walk_left <= 1;
						walk_right <= 0;
					end else if (bump_left) begin
						state <= FALL;
						walk_left <= 0;
						walk_right <= 0;
						aaah <= 1;
					end else if (dig && ground) begin
						state <= DIG;
						walk_left <= 0;
						walk_right <= 0;
						digging <= 1;
					end
				end
				DIG: begin
					if (!ground) begin
						state <= FALL;
						walk_left <= 0;
						walk_right <= 0;
						aaah <= 1;
						digging <= 0;
					end
				end
				FALL: begin
					if (ground) begin
						if (state == WALK_LEFT) begin
							state <= WALK_LEFT;
							walk_left <= 1;
							walk_right <= 0;
							aaah <= 0;
						end else if (state == WALK_RIGHT) begin
							state <= WALK_RIGHT;
							walk_left <= 0;
							walk_right <= 1;
							aaah <= 0;
						end
						digging <= 0;
					end
				end
			endcase
		end
	end
endmodule
