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
	
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= 2'b00;
		else begin
			case (state)
				2'b00: begin
					// walking left
					walk_left <= 1;
					walk_right <= 0;
					aaah <= 0;
					digging <= 0;

					if (bump_right)
						state <= 2'b01;
					else if (!ground)
						state <= 2'b11;
					else if (dig)
						state <= 2'b10;
				end
				
				2'b01: begin
					// walking right
					walk_left <= 0;
					walk_right <= 1;
					aaah <= 0;
					digging <= 0;
					
					if (bump_left)
						state <= 2'b00;
					else if (!ground)
						state <= 2'b11;
					else if (dig)
						state <= 2'b10;
				end
				
				2'b10: begin
					// digging
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 0;
					digging <= 1;
					
					if (!ground)
						state <= 2'b11;
				end
				
				2'b11: begin
					// falling
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 1;
					digging <= 0;
					
					if (ground)
						state <= bump_right ? 2'b01 : 2'b00;
				end
			endcase
		end
	end
	
endmodule
