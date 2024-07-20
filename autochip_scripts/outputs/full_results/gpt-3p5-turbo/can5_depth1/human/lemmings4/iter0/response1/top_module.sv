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
	
	reg [4:0] state;
	reg splatter;
	reg [4:0] counter;
	
	// State 0: Walking Left
	parameter WALK_LEFT = 0;
	// State 1: Walking Right
	parameter WALK_RIGHT = 1;
	// State 2: Falling
	parameter FALLING = 2;
	// State 3: Digging
	parameter DIGGING = 3;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= WALK_LEFT;
			counter <= 0;
			splatter <= 0;
			walk_left <= 1;
			walk_right <= 0;
			aaah <= 0;
			digging <= 0;
		end else begin
			case (state)
				WALK_LEFT:
					// Check for bumps
					if (bump_right) begin
						state <= WALK_RIGHT;
					end
					// Check for fall
					else if (!ground) begin
						state <= FALLING;
						aaah <= 1;
					end
					// Check for dig
					else if (dig) begin
						state <= DIGGING;
						digging <= 1;
					end
					// Increment counter when walking left
					else if (counter == 20) begin
						splatter <= 1;
						walk_left <= 0;
						walk_right <= 0;
						aaah <= 0;
						digging <= 0;
					end else begin
						counter <= counter + 1;
					end
				WALK_RIGHT:
					// Check for bumps
					if (bump_left) begin
						state <= WALK_LEFT;
					end
					// Check for fall
					else if (!ground) begin
						state <= FALLING;
						aaah <= 1;
					end
					// Check for dig
					else if (dig) begin
						state <= DIGGING;
						digging <= 1;
					end
					// Increment counter when walking right
					else if (counter == 20) begin
						splatter <= 1;
						walk_left <= 0;
						walk_right <= 0;
						aaah <= 0;
						digging <= 0;
					end else begin
						counter <= counter + 1;
					end
				FALLING:
					// Check for ground
					if (ground) begin
						state <= WALK_LEFT;
						aaah <= 0;
						digging <= 0;
					end
					// Reset splatter and counter
					else if (counter == 20) begin
						splatter <= 1;
						walk_left <= 0;
						walk_right <= 0;
						aaah <= 0;
						digging <= 0;
					end else begin
						counter <= counter + 1;
					end
				DIGGING:
					// Check for ground while digging
					if (!ground) begin
						state <= FALLING;
					end else if (counter == 20) begin
						splatter <= 1;
						walk_left <= 0;
						walk_right <= 0;
						aaah <= 0;
						digging <= 0;
					end else begin
						counter <= counter + 1;
					end
			endcase
		end
	end
	
endmodule
