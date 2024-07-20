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

	// Declare state register
	reg [1:0] state;

	// Declare output registers
	reg walk_left_reg;
	reg walk_right_reg;
	reg aaah_reg;
	reg digging_reg;

	// Set initial state and outputs
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 0;
			walk_left_reg <= 0;
			walk_right_reg <= 0;
			aaah_reg <= 0;
			digging_reg <= 0;
		end else begin
			case (state)
				0: begin
					walk_left_reg <= 1;
					walk_right_reg <= 0;
					aaah_reg <= 0;
					digging_reg <= 0;
					if (bump_left) state <= 1;
					if (bump_right) state <= 2;
					if (ground == 0) state <= 3;
					if (dig) state <= 4;
				end
				1: begin
					walk_left_reg <= 0;
					walk_right_reg <= 1;
					aaah_reg <= 0;
					digging_reg <= 0;
					if (bump_left) state <= 1;
					if (bump_right) state <= 2;
					if (ground == 0) state <= 3;
					if (dig) state <= 4;
				end
				2: begin
					walk_left_reg <= 1;
					walk_right_reg <= 0;
					aaah_reg <= 0;
					digging_reg <= 0;
					if (bump_left) state <= 1;
					if (bump_right) state <= 2;
					if (ground == 0) state <= 3;
					if (dig) state <= 4;
				end
				3: begin
					walk_left_reg <= 0;
					walk_right_reg <= 0;
					aaah_reg <= 1;
					digging_reg <= 0;
					if (ground == 1) state <= 0;
					if (dig) state <= 4;
				end
				4: begin
					walk_left_reg <= 0;
					walk_right_reg <= 0;
					aaah_reg <= 0;
					digging_reg <= 1;
					if (ground == 0) state <= 3;
				end
			endcase
		end
	end

	// Assign output signals to output registers
	assign walk_left = walk_left_reg;
	assign walk_right = walk_right_reg;
	assign aaah = aaah_reg;
	assign digging = digging_reg;

endmodule
