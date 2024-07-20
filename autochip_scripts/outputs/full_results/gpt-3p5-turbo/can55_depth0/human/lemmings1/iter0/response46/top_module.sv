module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output reg walk_left,
	output reg walk_right
);

	reg [1:0] state;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 0;
		end else begin
			case (state)
				0: begin
					if (bump_left && !bump_right) begin
						state <= 1;
					end else if (bump_right && !bump_left) begin
						state <= 2;
					end else if (bump_left && bump_right) begin
						state <= 2;
					end
				end
				
				1: begin
					if (!bump_left && !bump_right) begin
						state <= 0;
					end else if (!bump_left && bump_right) begin
						state <= 2;
					end else if (bump_left && bump_right) begin
						state <= 2;
					end
				end
				
				2: begin
					if (!bump_left && !bump_right) begin
						state <= 0;
					end else if (bump_left && !bump_right) begin
						state <= 1;
					end else if (bump_left && bump_right) begin
						state <= 1;
					end
				end
			endcase
		end
	end
	
	always @(state) begin
		case (state)
			0: begin
				walk_left <= 1;
				walk_right <= 0;
			end
			
			1: begin
				walk_left <= 0;
				walk_right <= 1;
			end
			
			2: begin
				walk_left <= 0;
				walk_right <= 0;
			end
		endcase
	end

endmodule
