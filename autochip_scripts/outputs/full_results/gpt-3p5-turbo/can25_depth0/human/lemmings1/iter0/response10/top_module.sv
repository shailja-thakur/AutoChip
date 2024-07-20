module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);
	reg [1:0] state;
	
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= 2'b10; // Reset state to walk_left
		else begin
			case (state)
				2'b10: begin // Walking left
					if (bump_left && !bump_right)
						state <= 2'b01; // Switch to walking right
					else if (bump_left && bump_right)
						state <= 2'b01; // Switch to walking right
					else
						state <= 2'b10; // Continue walking left
				end
				
				2'b01: begin // Walking right
					if (!bump_left && bump_right)
						state <= 2'b10; // Switch to walking left
					else if (bump_left && bump_right)
						state <= 2'b10; // Switch to walking left
					else
						state <= 2'b01; // Continue walking right
				end
			endcase
		end
	end
	
	assign walk_left = (state == 2'b10);
	assign walk_right = (state == 2'b01);
endmodule
