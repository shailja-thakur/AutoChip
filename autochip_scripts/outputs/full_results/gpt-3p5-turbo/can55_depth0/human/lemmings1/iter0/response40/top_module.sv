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
		if (areset) begin
			state <= 2'b10; // Initial state: walking left
		end else begin
			// State transitions
			case (state)
				2'b10: begin // Walking left
					if (bump_right) begin
						state <= 2'b01; // Switch to walking right
					end else if (bump_left) begin
						state <= 2'b10; // Continue walking left
					end
				end
				2'b01: begin // Walking right
					if (bump_left) begin
						state <= 2'b10; // Switch to walking left
					end else if (bump_right) begin
						state <= 2'b01; // Continue walking right
					end
				end
			endcase
		end
	end
	
	always @* begin
		case (state)
			2'b10: begin // Walking left
				walk_left = 1;
				walk_right = 0;
			end
			2'b01: begin // Walking right
				walk_left = 0;
				walk_right = 1;
			end
		endcase
	end
	
endmodule
