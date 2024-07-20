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
			state <= 2'b00;
		else begin
			case(state)
				2'b00: begin
					if (bump_right)
						state <= 2'b01;
					else if (bump_left)
						state <= 2'b10;
				end
				
				2'b01: begin
					if (bump_left)
						state <= 2'b10;
				end
				
				2'b10: begin
					if (bump_right)
						state <= 2'b01;
				end
			endcase
		end
	end
	
	assign walk_left = (state == 2'b10);
	assign walk_right = (state == 2'b01);

endmodule
