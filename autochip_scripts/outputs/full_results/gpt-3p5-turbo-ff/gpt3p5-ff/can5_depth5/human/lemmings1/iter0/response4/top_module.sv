module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

	reg [1:0] state;
	
	// Define states
	parameter IDLE = 2'b00;
	parameter WALK_LEFT = 2'b01;
	parameter WALK_RIGHT = 2'b10;
	
	// State register
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= IDLE;
		end
		else begin
			case(state)
				IDLE: begin
					if (bump_left || bump_right) begin
						state <= WALK_LEFT;
					end
				end
				
				WALK_LEFT: begin
					if (bump_right) begin
						state <= WALK_LEFT;
					end
					else begin
						state <= WALK_RIGHT;
					end
				end
				
				WALK_RIGHT: begin
					if (bump_left) begin
						state <= WALK_RIGHT;
					end
					else begin
						state <= WALK_LEFT;
					end
				end
			endcase
		end
	end
	
	// Output logic
	always @(state) begin
		case(state)
			IDLE: begin
				walk_left <= 1;
				walk_right <= 0;
			end
			
			WALK_LEFT: begin
				walk_left <= 1;
				walk_right <= 0;
			end
			
			WALK_RIGHT: begin
				walk_left <= 0;
				walk_right <= 1;
			end
		endcase
	end

endmodule
