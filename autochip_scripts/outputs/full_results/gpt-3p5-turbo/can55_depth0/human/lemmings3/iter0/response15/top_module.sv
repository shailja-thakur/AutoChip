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

	always @(posedge clk or posedge areset)
	begin
		if (areset)
			state <= 2'b10;
		else
		begin
			case (state)
				2'b00: 
				begin
					if (bump_left && !bump_right)
						state <= 2'b01;
					else if (!bump_left && bump_right)
						state <= 2'b00;
					else if (dig && ground && !aaah)
						state <= 2'b10;
					else
						state <= state;
				end
				2'b01: 
				begin
					if (!bump_left && bump_right)
						state <= 2'b00;
					else if (!bump_left && !bump_right)
						state <= 2'b01;
					else if (dig && ground && !aaah)
						state <= 2'b10;
					else
						state <= state;
				end
				2'b10: 
				begin
					if (ground && !aaah)
						state <= 2'b10;
					else if (!ground)
						state <= 2'b00;
					else if (dig && ground && !aaah)
						state <= 2'b10;
					else
						state <= state;
				end
				default: state <= 2'b10;
			endcase
		end
	end

	always @(state)
	begin
		case (state)
			2'b00: 
			begin
				walk_left <= 1;
				walk_right <= 0;
				aaah <= 1;
				digging <= 0;
			end
			2'b01: 
			begin
				walk_left <= 0;
				walk_right <= 1;
				aaah <= 1;
				digging <= 0;
			end
			2'b10: 
			begin
				walk_left <= 1;
				walk_right <= 0;
				aaah <= 0;
				digging <= dig && ground && !aaah;
			end
			default: 
			begin
				walk_left <= 1;
				walk_right <= 0;
				aaah <= 0;
				digging <= 0;
			end
		endcase
	end

endmodule
