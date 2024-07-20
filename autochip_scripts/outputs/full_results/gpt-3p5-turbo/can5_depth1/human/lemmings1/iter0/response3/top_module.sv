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
			state <= 2'b10; // Initializing the state to walk left
		else begin
			case (state)
				2'b10: begin
					if (bump_left && !bump_right)
						state <= 2'b01; // Switching to walk right state
					else if (bump_right && !bump_left)
						state <= 2'b00; // Staying in the walk left state
					else if (bump_left && bump_right)
						state <= 2'b01; // Switching to walk right state
				end
				2'b01: begin
					if (bump_left && !bump_right)
						state <= 2'b01; // Staying in the walk right state
					else if (bump_right && !bump_left)
						state <= 2'b10; // Switching to walk left state
					else if (bump_left && bump_right)
						state <= 2'b10; // Switching to walk left state
				end
			endcase
		end
	end
	
	assign walk_left = (state == 2'b10);
	assign walk_right = (state == 2'b01);
endmodule
