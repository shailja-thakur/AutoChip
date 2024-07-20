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
			state <= 2'b01; // Reset to walk left
		else begin
			case (state)
				2'b01: begin // Walking left state
					if (bump_right)
						state <= 2'b10; // Switch to walk right
				end
				
				2'b10: begin // Walking right state
					if (bump_left)
						state <= 2'b01; // Switch to walk left
				end
			endcase
		end
	end
	
	// Output logic
	assign walk_left = (state == 2'b01);
	assign walk_right = (state == 2'b10);
	
endmodule
