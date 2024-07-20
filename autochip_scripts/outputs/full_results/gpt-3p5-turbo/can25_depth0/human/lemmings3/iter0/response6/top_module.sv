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

	parameter IDLE = 0;
	parameter WALK_LEFT = 1;
	parameter WALK_RIGHT = 2;
	parameter FALL = 3;
	parameter DIG = 4;

	reg [2:0] state;
	reg walk_left;
	reg walk_right;
	reg aaah;
	reg digging;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= IDLE;
			walk_left <= 1;
			walk_right <= 0;
			aaah <= 0;
			digging <= 0;
		end else begin
			case (state)
				IDLE: begin
					if (bump_left & !bump_right) begin
						state <= WALK_RIGHT;
						walk_left <= 0;
						walk_right <= 1;
						aaah <= 0;
						digging <= 0;
					end
					else if (!bump_left & bump_right) begin
						state <= WALK_LEFT;
						walk_left <= 1;
						walk_right <= 0;
						aaah <= 0;
						digging <= 0;
					end
					else if (bump_left & bump_right) begin
						state <= WALK_RIGHT;
						walk_left <= 0;
						walk_right <= 1;
						aaah <= 0;
						digging <= 0;
					end
					else if (dig) begin
						if (ground) begin
							state <= DIG;
							walk_left <= 0;
							walk_right <= 0;
							aaah <= 0;
							digging <= 1;
						end
					end
					else if (!ground) begin
						state <= FALL;
						walk_left <= 0;
						walk_right <= 0;
						aaah <= 1;
						digging <= 0;
					end
				end
				
				WALK_LEFT: begin
					if (bump_left & !bump_right) begin
						state <= WALK_RIGHT;
						walk_left <= 0;
						walk_right <= 1;
						aaah <= 0;
						digging <= 0;
					end
					else if (bump_left & bump_right) begin
						state <= WALK_RIGHT;
						walk_left <= 0;
						walk_right <= 1;
						aaah <= 0;
						digging <= 0;
					end
					else if (!ground) begin
						state <= FALL;
						walk_left <= 0;
						walk_right <= 0;
						aaah <= 1;
						digging <= 0;
					end
				end

				WALK_RIGHT: begin
					if (!bump_left & bump_right) begin
						state <= WALK_LEFT;
						walk_left <= 1;
						walk_right <= 0;
						aaah <= 0;
						digging <= 0;
					end
					else if (bump_left & bump_right) begin
						state <= WALK_LEFT;
						walk_left <= 1;
						walk_right <= 0;
						aaah <= 0;
						digging <= 0;
					end
					else if (!ground) begin
						state <= FALL;
						walk_left <= 0;
						walk_right <= 0;
						aaah <= 1;
						digging <= 0;
					end
				end

				FALL: begin
					if (ground) begin
						state <= IDLE;
						walk_left <= 1;
						walk_right <= 0;
						aaah <= 0;
						digging <= 0;
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
				
			endcase
		end
	end

endmodule
