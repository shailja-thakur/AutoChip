module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output wire walk_left,
	output wire walk_right
);
	reg [1:0] state;
	wire [1:0] next_state;
	
	always @(posedge clk or posedge areset)
	begin
		if (areset)
			state <= 2'b10;
		else
			state <= next_state;
	end
	
	always @*
	begin
		case(state)
			2'b00: // walking left state
			begin
				if (bump_left && bump_right)
					next_state = 2'b11; // switch directions
				else if (bump_left)
					next_state = 2'b01; // walk right
				else
					next_state = 2'b00; // continue walking left
			end
			
			2'b01: // walking right state
			begin
				if (bump_left && bump_right)
					next_state = 2'b11; // switch directions
				else if (bump_right)
					next_state = 2'b00; // walk left
				else
					next_state = 2'b01; // continue walking right
			end
			
			2'b10: // reset state
				next_state = 2'b00; // walk left
			
			2'b11: // switch directions state
				next_state = 2'b10; // walk left
				
			default:
				next_state = 2'b00; // default to walking left
		endcase
	end
	
	assign walk_left = (state == 2'b00);
	assign walk_right = (state == 2'b01);
endmodule
