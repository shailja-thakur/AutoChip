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
	
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= 2'b11;
		else begin
			case (state)
				2'b00: begin // Walking left state
					if (bump_right || (bump_left && bump_right))
						state <= 2'b01; // Switch to walking right
					else if (ground == 0)
						state <= 2'b10; // Fall state
				end
				
				2'b01: begin // Walking right state
					if (bump_left || (bump_left && bump_right))
						state <= 2'b00; // Switch to walking left
					else if (ground == 0)
						state <= 2'b10; // Fall state
				end
				
				2'b10: begin // Falling state
					if (ground == 1)
						state <= (bump_left || (bump_left && bump_right)) ? 2'b00 : 2'b01; // Resume walking in the same direction as before
				end
				
				default: state <= 2'b11;
			endcase
		end
	end
	
	always @(state) begin
		walk_left = (state == 2'b00);
		walk_right = (state == 2'b01);
		aaah = (state == 2'b10) ? 1 : 0;
	end
endmodule
