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
				2'b00: begin // walk_left state
					if (bump_right)
						state <= 2'b01; // Change state to walk_right
				end
				2'b01: begin // walk_right state
					if (bump_left)
						state <= 2'b00; // Change state to walk_left
				end
				default: state <= 2'b00; // Default state is walk_left
			endcase
		end
	end
	
	assign walk_left = (state == 2'b00) ? 1'b1 : 1'b0;
	assign walk_right = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
