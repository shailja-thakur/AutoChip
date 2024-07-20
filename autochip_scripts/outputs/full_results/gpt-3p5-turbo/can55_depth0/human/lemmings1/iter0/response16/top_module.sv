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
			state <= 2'b10;  // initial state: walking left
		end else begin
			case(state)
				2'b00: begin  // walking right state
					if (bump_left) begin
						state <= 2'b01;  // switch to walking left state
					end else if (bump_right) begin
						state <= 2'b10;  // stay in walking right state
					end
				end
				
				2'b01: begin  // walking left state
					if (bump_left) begin
						state <= 2'b01;  // stay in walking left state
					end else if (bump_right) begin
						state <= 2'b10;  // switch to walking right state
					end
				end
			endcase
		end
	end
	
	always @(state) begin
		case(state)
			2'b00: begin  // walking right state
				walk_left = 1'b0;
				walk_right = 1'b1;
			end
			
			2'b01: begin  // walking left state
				walk_left = 1'b1;
				walk_right = 1'b0;
			end
		endcase
	end
endmodule
