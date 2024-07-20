module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	output reg walk_left,
	output reg walk_right,
	output reg aaah
);

	reg [1:0] state;
	reg prev_ground;

	always @(posedge clk or posedge areset)
	begin
		if (areset)
		begin
			state <= 2'b01;
			prev_ground <= 1'b1;
		end
		else
		begin
			case(state)
				2'b00: 
					begin
						if (bump_left)
							state <= 2'b10;
						else if (bump_right)
							state <= 2'b11;
						else if (!ground && prev_ground)
							state <= 2'b01;
					end
				2'b01:
					begin
						if (bump_left)
							state <= 2'b10;
						else if (bump_right)
							state <= 2'b11;
						else if (ground && !prev_ground)
							state <= 2'b00;
					end
				2'b10:
					begin
						if (ground)
							state <= 2'b01;
					end
				2'b11:
					begin
						if (ground)
							state <= 2'b00;
					end
			endcase
		end
	end

	always @(state)
	begin
		case(state)
			2'b00:
				begin
					walk_left <= 1;
					walk_right <= 0;
					aaah <= 0;
				end
			2'b01:
				begin
					walk_left <= 0;
					walk_right <= 1;
					aaah <= 0;
				end
			2'b10:
				begin
					walk_left <= 1;
					walk_right <= 0;
					aaah <= 0;
				end
			2'b11:
				begin
					walk_left <= 0;
					walk_right <= 1;
					aaah <= 0;
				end
		endcase
	end

	always @(posedge clk)
	begin
		prev_ground <= ground;
	end

	always @(posedge clk)
	begin
		if (!ground && prev_ground)
		begin
			aaah <= 1;
		end
		else
		begin
			aaah <= 0;
		end
	end

endmodule
