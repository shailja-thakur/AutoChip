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
	reg [4:0] next_state;

	parameter FALL_LIMIT = 20;

	always @(posedge clk or posedge areset) begin
		if (areset) 

		case (state)
			0: begin
				walk_left <= 1;
				walk_right <= 0;
				next_state <= 1;
			end
			1: begin
				if (bump_left == 1)
					next_state <= 2;
				else if (bump_right == 1)
					next_state <= 3;
				else if (ground == 0)
					next_state <= 4;
				else
					next_state <= 1;
					
				walk_left <= 1;
				walk_right <= 0;
				aaah <= 0;
				digging <= 0;
			end
			2: begin
				if (bump_left == 0)
					next_state <= 1;
				else if (bump_right == 1)
					next_state <= 3;
				else if (ground == 0)
					next_state <= 4;
				else
					next_state <= 2;

				walk_left <= 1;
				walk_right <= 0;
				aaah <= 0;
				digging <= 0;
			end
			3: begin
				if (bump_right == 0)
					next_state <= 1;
				else if (bump_left == 1)
					next_state <= 2;
				else if (ground == 0)
					next_state <= 4;
				else
					next_state <= 3;

				walk_left <= 0;
				walk_right <= 1;
				aaah <= 0;
				digging <= 0;
			end
			4: begin
				if (ground == 1)
					next_state <= 1;
				else if (dig == 1)
					next_state <= 5;
				else
					next_state <= 4;

				walk_left <= walk_left;
				walk_right <= walk_right;
				aaah <= 1;
				digging <= 0;
			end
			5: begin
				if (ground == 1)
					next_state <= 1;
				else if (bump_left == 1)
					next_state <= 2;
				else if (bump_right == 1)
					next_state <= 3;
				else if (ground == 0)
					next_state <= 4;
				else if (dig == 1)
					next_state <= 5;
				else
					next_state <= 5;

				walk_left <= 0;
				walk_right <= 0;
				aaah <= 0;
				digging <= 1;
			end
		endcase

	end

	always @(posedge clk) begin
		state <= next_state;
	end

endmodule
