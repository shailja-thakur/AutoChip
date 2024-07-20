module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	output walk_left,
	output walk_right,
	output aaah
);
	reg [1:0] state;

	always @(posedge clk or posedge areset)
	begin
		if (areset)
			state <= 2'b01;
		else
		begin
			case (state)
				2'b00: // walking left
				begin
					if (bump_left)
						state <= 2'b10;
					else if (bump_right)
						state <= 2'b01;
				end
				
				2'b01: // walking right
				begin
					if (bump_left)
						state <= 2'b01;
					else if (bump_right)
						state <= 2'b10;
				end
				
				2'b10: // falling and saying "aaah!"
				begin
					if (ground)
						state <= 2'b00;
				end
			endcase
		end
	end

	assign walk_left = (state == 2'b00);
	assign walk_right = (state == 2'b01);
	assign aaah = (state == 2'b10);
endmodule
