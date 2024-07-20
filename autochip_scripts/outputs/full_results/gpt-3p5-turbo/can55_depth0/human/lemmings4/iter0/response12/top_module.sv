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

	reg [4:0] state;

	parameter[4:0] WALK_LEFT = 5'd0;
	parameter[4:0] WALK_RIGHT = 5'd1;
	parameter[4:0] FALL = 5'd2;
	parameter[4:0] DIGGING = 5'd3;
	parameter[4:0] SPLATTER = 5'd4;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= WALK_LEFT;
			walk_left <= 1;
			walk_right <= 0;
			aaah <= 0;
			digging <= 0;
		end else begin
			case (state)
				WALK_LEFT: begin
					if (bump_right) begin
						state <= WALK_RIGHT;
						walk_left <= 0;
						walk_right <= 1;
						aaah <= 0;
						digging <= 0;
					end else if (!ground) begin
						state <= FALL;
						walk_left <= 0;
						walk_right <= 0;
						aaah <= 1;
						digging <= 0;
					end else if (dig) begin
						state <= DIGGING;
						walk_left <= 0;
						walk_right <= 0;
						aaah <= 0;
						digging <= 1;
					end
				end
				WALK_RIGHT: begin
					if (bump_left) begin
						state <= WALK_LEFT;
						walk_left <= 1;
						walk_right <= 0;
						aaah <= 0;
						digging <= 0;
					end else if (!ground) begin
						state <= FALL;
						walk_left <= 0;
						walk_right <= 0;
						aaah <= 1;
						digging <= 0;
					end else if (dig) begin
						state <= DIGGING;
						walk_left <= 0;
						walk_right <= 0;
						aaah <= 0;
						digging <= 1;
					end
				end
				FALL: begin
					if (ground) begin
						state <= WALK_LEFT;
						walk_left <= 1;
						walk_right <= 0;
						aaah <= 0;
						digging <= 0;
					end else if (state == FALL && aaah == 20) begin
						state <= SPLATTER;
						walk_left <= 0;
						walk_right <= 0;
						aaah <= 0;
						digging <= 0;
					end
				end
				DIGGING: begin
					if (ground) begin
						state <= WALK_LEFT;
						walk_left <= 1;
						walk_right <= 0;
						aaah <= 0;
						digging <= 0;
					end else if (!ground) begin
						state <= FALL;
						walk_left <= 0;
						walk_right <= 0;
						aaah <= 1;
						digging <= 0;
					end else if (dig) begin
						state <= DIGGING;
						walk_left <= 0;
						walk_right <= 0;
						aaah <= 0;
						digging <= 1;
					end
				end
				SPLATTER: begin
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 0;
					digging <= 0;
				end
			endcase
		end
	end

endmodule
