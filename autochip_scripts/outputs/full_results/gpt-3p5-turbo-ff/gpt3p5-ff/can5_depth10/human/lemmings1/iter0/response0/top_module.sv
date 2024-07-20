module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);
	reg [1:0] current_state;
	
	always @(posedge clk or posedge areset)
		if (areset)
			current_state <= 2'b11;
		else
			case (current_state)
				2'b00: if (bump_left) current_state <= 2'b01; else if (bump_right) current_state <= 2'b10;
				2'b01: if (bump_right) current_state <= 2'b10; else current_state <= 2'b00;
				2'b10: if (bump_left) current_state <= 2'b01; else current_state <= 2'b00;
				2'b11: current_state <= 2'b00;
			endcase
	
	assign walk_left = (current_state == 2'b01);
	assign walk_right = (current_state == 2'b10);

endmodule
