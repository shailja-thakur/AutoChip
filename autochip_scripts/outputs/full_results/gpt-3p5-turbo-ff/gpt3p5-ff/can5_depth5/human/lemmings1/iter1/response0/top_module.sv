module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output reg walk_left,
	output reg walk_right
);
	reg [1:0] state;
	
	always @(posedge clk or posedge areset)
	begin
		if (areset)
			state <= 2'b10;
		else
		begin
			case(state)
				2'b00: // walking left state
					begin
						if (bump_left && bump_right)
							state <= 2'b11; // switch directions
						else if (bump_left)
							state <= 2'b01; // walk right
						else
							state <= 2'b00; // continue walking left
					end
					
				2'b01: // walking right state
					begin
						if (bump_left && bump_right)
							state <= 2'b11; // switch directions
						else if (bump_right)
							state <= 2'b00; // walk left
						else
							state <= 2'b01; // continue walking right
					end
					
				2'b10: // reset state
					state <= 2'b00; // walk left
					
				2'b11: // switch directions state
					state <= 2'b10; // walk left
					
				default:
					state <= 2'b00; // default to walking left
			endcase
		end
	end
	
	always @(state)
	begin
		case(state)
			2'b00: // walking left state
				begin
					walk_left <= 1;
					walk_right <= 0;
				end
				
			2'b01: // walking right state
				begin
					walk_left <= 0;
					walk_right <= 1;
				end
				
			default:
				begin
					walk_left <= 1; // default to walking left
					walk_right <= 0;
				end
		endcase
	end
endmodule
