module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);
	reg [1:0] state;
	reg walk_left, walk_right;

	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= 2'b10;
		else begin
			case (state)
				2'b00:
					if (bump_left && bump_right)
						state <= 2'b10;
					else if (bump_left)
						state <= 2'b01;
					else if (bump_right)
						state <= 2'b10;
				2'b01:
					if (bump_left && bump_right)
						state <= 2'b10;
					else if (bump_left)
						state <= 2'b01;
					else if (bump_right)
						state <= 2'b10;
				2'b10:
					if (bump_left && bump_right)
						state <= 2'b10;
					else if (bump_left)
						state <= 2'b01;
					else if (bump_right)
						state <= 2'b10;
			endcase
		end
	end

	always @(state) begin
		case (state)
			2'b00:
				begin
					walk_left = 1'b0;
					walk_right = 1'b1;
				end
			2'b01:
				begin
					walk_left = 1'b1;
					walk_right = 1'b0;
				end
			2'b10:
				begin
					walk_left = 1'b1;
					walk_right = 1'b0;
				end
		endcase
	end

endmodule
