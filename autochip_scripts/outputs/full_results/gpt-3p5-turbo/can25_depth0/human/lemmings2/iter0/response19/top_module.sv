module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	output walk_left,
	output walk_right,
	output aaah
);

	reg [1:0] state;
	parameter [1:0] WALK_LEFT = 2'b00;
	parameter [1:0] WALK_RIGHT = 2'b01;
	
	// State register
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= WALK_LEFT;
		end else begin
			case(state)
				WALK_LEFT: begin
					if (bump_right) begin
						state <= WALK_RIGHT;
					end
				end
				WALK_RIGHT: begin
					if (bump_left) begin
						state <= WALK_LEFT;
					end
				end
			endcase
		end
	end
	
	// Output logic
	always @(state, ground) begin
		case(state)
			WALK_LEFT: begin
				walk_left = 1;
				walk_right = 0;
			end
			WALK_RIGHT: begin
				walk_right = 1;
				walk_left = 0;
			end
		endcase
		
		if (ground) begin
			aaah = 0;
		end else begin
			aaah = 1;
		end
	end
endmodule
