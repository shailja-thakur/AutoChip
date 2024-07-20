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

reg [2:0] state;

parameter WALK_LEFT = 3'b000;
parameter WALK_RIGHT = 3'b001;
parameter FALL = 3'b010;
parameter DIG = 3'b011;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= WALK_LEFT;
		walk_left <= 1;
		walk_right <= 0;
		aaah <= 0;
		digging <= 0;
	end 
	else begin
		case (state)
			WALK_LEFT: begin
				if (bump_right) begin
					walk_left <= 0;
					walk_right <= 1;
					aaah <= 0;
					digging <= 0;
					state <= WALK_RIGHT;
				end else if (!ground) begin
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 1;
					digging <= 0;
					state <= FALL;
				end else if (dig && ground) begin
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 0;
					digging <= 1;
					state <= DIG;
				end
			end

			WALK_RIGHT: begin
				if (bump_left) begin
					walk_left <= 1;
					walk_right <= 0;
					aaah <= 0;
					digging <= 0;
					state <= WALK_LEFT;
				end else if (!ground) begin
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 1;
					digging <= 0;
					state <= FALL;
				end else if (dig && ground) begin
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 0;
					digging <= 1;
					state <= DIG;
				end
			end

			FALL: begin
				if (ground) begin
					if (state == WALK_LEFT) begin
						walk_left <= 1;
						walk_right <= 0;
						aaah <= 0;
						digging <= 0;
					end else if (state == WALK_RIGHT) begin
						walk_left <= 0;
						walk_right <= 1;
						aaah <= 0;
						digging <= 0;
					end
					state <= state == WALK_LEFT ? WALK_LEFT : WALK_RIGHT;
				end
			end

			DIG: begin
				if (!ground) begin
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 1;
					digging <= 0;
					state <= FALL;
				end
			end
		endcase
	end
end

endmodule
