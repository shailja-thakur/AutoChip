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

reg [1:0] state;
reg walk_left;
reg walk_right;
reg aaah;
reg digging;

parameter LEFT = 2'b00;
parameter RIGHT = 2'b01;
parameter FALL = 2'b10;
parameter DIG = 2'b11;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= LEFT;
		walk_left <= 1'b1;
		walk_right <= 1'b0;
		aaah <= 1'b0;
		digging <= 1'b0;
	end
	else begin
		case (state)
			LEFT: begin
				if (bump_right) begin
					state <= RIGHT;
					walk_left <= 1'b0;
					walk_right <= 1'b1;
					aaah <= 1'b0;
					digging <= 1'b0;
				end
				else if (ground == 0) begin
					state <= FALL;
					walk_left <= 1'b0;
					walk_right <= 1'b0;
					aaah <= 1'b1;
					digging <= 1'b0;
				end
				else if (dig) begin
					state <= DIG;
					walk_left <= 1'b0;
					walk_right <= 1'b0;
					aaah <= 1'b0;
					digging <= 1'b1;
				end
			end

			RIGHT: begin
				if (bump_left) begin
					state <= LEFT;
					walk_left <= 1'b1;
					walk_right <= 1'b0;
					aaah <= 1'b0;
					digging <= 1'b0;
				end
				else if (ground == 0) begin
					state <= FALL;
					walk_left <= 1'b0;
					walk_right <= 1'b0;
					aaah <= 1'b1;
					digging <= 1'b0;
				end
				else if (dig) begin
					state <= DIG;
					walk_left <= 1'b0;
					walk_right <= 1'b0;
					aaah <= 1'b0;
					digging <= 1'b1;
				end
			end

			FALL: begin
				if (ground) begin
					state <= case(walk_left)
						0: LEFT;
						1: RIGHT;
					endcase
					walk_left <= walk_left;
					walk_right <= walk_right;
					aaah <= 1'b0;
					digging <= 1'b0;
				end
			end

			DIG: begin
				if (~ground || (ground && walking)) begin
					state <= FALL;
					walk_left <= 1'b0;
					walk_right <= 1'b0;
					aaah <= 1'b1;
					digging <= 1'b0;
				end
			end
		endcase
	end
end

endmodule
