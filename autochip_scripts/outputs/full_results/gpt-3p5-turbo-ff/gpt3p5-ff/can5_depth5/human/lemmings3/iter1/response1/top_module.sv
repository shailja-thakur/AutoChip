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

	reg [1:0] state;

	parameter WALK_LEFT = 2'b00;
	parameter WALK_RIGHT = 2'b01;
	parameter FALL = 2'b10;
	parameter DIG = 2'b11;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= WALK_LEFT;
			walk_left <= 1'b1;
			walk_right <= 1'b0;
			aaah <= 1'b0;
			digging <= 1'b0;
		end else begin
			case(state)
				WALK_LEFT: begin
					if (!ground) begin
						state <= FALL;
						walk_left <= 1'b0;
						walk_right <= 1'b0;
						aaah <= 1'b1;
						digging <= 1'b0;
					end else if (bump_right) begin
						state <= WALK_RIGHT;
						walk_left <= 1'b0;
						walk_right <= 1'b1;
						aaah <= 1'b0;
						digging <= 1'b0;
					end else if (dig) begin
						state <= DIG;
						walk_left <= 1'b0;
						walk_right <= 1'b0;
						aaah <= 1'b0;
						digging <= 1'b1;
					end
				end
				WALK_RIGHT: begin
					if (!ground) begin
						state <= FALL;
						walk_left <= 1'b0;
						walk_right <= 1'b0;
						aaah <= 1'b1;
						digging <= 1'b0;
					end else if (bump_left) begin
						state <= WALK_LEFT;
						walk_left <= 1'b1;
						walk_right <= 1'b0;
						aaah <= 1'b0;
						digging <= 1'b0;
					end else if (dig) begin
						state <= DIG;
						walk_left <= 1'b0;
						walk_right <= 1'b0;
						aaah <= 1'b0;
						digging <= 1'b1;
					end
				end
				FALL: begin
					if (ground) begin
						state <= state;
						walk_left <= (state == WALK_LEFT) ? 1'b1 : 1'b0;
						walk_right <= (state == WALK_RIGHT) ? 1'b1 : 1'b0;
						aaah <= 1'b0;
						digging <= 1'b0;
					end
				end
				DIG: begin
					if (!ground) begin
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
