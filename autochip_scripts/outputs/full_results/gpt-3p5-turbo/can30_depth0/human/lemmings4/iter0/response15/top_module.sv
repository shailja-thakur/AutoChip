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
	
	reg [4:0] state;
	always @(posedge clk or posedge areset)
	begin
		if (areset)
			state <= 5'b00000;
		else
		begin
			case (state)
				5'b00000: // Walking left
					begin
						if (bump_left && !bump_right)
							state <= 5'b00001;
						else if (!bump_left && bump_right)
							state <= 5'b00010;
						else if (bump_left && bump_right)
							state <= 5'b00010;
						else if (!ground)
							state <= 5'b00100;
						else if (dig)
							state <= 5'b00110;
					end
				5'b00001: // Walking right after bumped on left
					begin
						state <= 5'b00000;
					end
				5'b00010: // Walking left after bumped on right
					begin
						state <= 5'b00000;
					end
				5'b00100: // Falling
					begin
						if (ground)
							state <= 5'b00000;
					end
				5'b00110: // Digging
					begin
						if (!ground)
							state <= 5'b00100;
					end
			endcase
		end
	end
	
	always @(state)
	begin
		case (state)
			5'b00000: // Walking left
				begin
					walk_left = 1;
					walk_right = 0;
					aaah = 0;
					digging = 0;
				end
			5'b00001: // Walking right after bumped on left
				begin
					walk_left = 0;
					walk_right = 1;
					aaah = 0;
					digging = 0;
				end
			5'b00010: // Walking left after bumped on right
				begin
					walk_left = 1;
					walk_right = 0;
					aaah = 0;
					digging = 0;
				end
			5'b00100: // Falling
				begin
					walk_left = 0;
					walk_right = 0;
					aaah = 1;
					digging = 0;
				end
			5'b00110: // Digging
				begin
					walk_left = 0;
					walk_right = 0;
					aaah = 0;
					digging = 1;
				end
			default:
				begin
					walk_left = 0;
					walk_right = 0;
					aaah = 0;
					digging = 0;
				end
		endcase
	end
endmodule
