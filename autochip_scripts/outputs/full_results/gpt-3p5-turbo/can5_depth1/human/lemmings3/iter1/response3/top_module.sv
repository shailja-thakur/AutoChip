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

	// States
	parameter [1:0] LEFT = 2'b00;
	parameter [1:0] RIGHT = 2'b01;
	parameter [1:0] FALLING = 2'b10;
	parameter [1:0] DIGGING = 2'b11;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= LEFT;
			walk_left <= 1;
			walk_right <= 0;
			aaah <= 0;
			digging <= 0;
		end else begin
			case (state)
				LEFT: begin
					if (bump_right) begin
						state <= RIGHT;
						walk_left <= 0;
						walk_right <= 1;
						aaah <= 0;
						digging <= 0;
					end else if (bump_left) begin
						state <= LEFT;
						walk_left <= 1;
						walk_right <= 0;
						aaah <= 0;
						digging <= 0;
					end else if (ground == 0) begin
						state <= FALLING;
					end else if (dig) begin
						state <= DIGGING;
					end
				end
				
				RIGHT: begin
					if (bump_left) begin
						state <= LEFT;
						walk_left <= 1;
						walk_right <= 0;
						aaah <= 0;
						digging <= 0;
					end else if (bump_right) begin
						state <= RIGHT;
						walk_left <= 0;
						walk_right <= 1;
						aaah <= 0;
						digging <= 0;
					end else if (ground == 0) begin
						state <= FALLING;
					end else if (dig) begin
						state <= DIGGING;
					end
				end
				
				FALLING: begin
					if (ground == 1) begin
						state <= LEFT;
						walk_left <= 1;
						walk_right <= 0;
						aaah <= 0;
						digging <= 0;
					end
				end
				
				DIGGING: begin
					if (ground == 0) begin
						state <= FALLING;
					end else begin
						state <= DIGGING;
					end
				end
			endcase
		end
	end
endmodule
