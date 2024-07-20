module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);
	reg [1:0] state;
	reg walk_left, walk_right;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b10;
		end else begin
			case (state)
				2'b10: begin
					if (bump_left && bump_right) begin
						state <= 2'b01;
					end else if (bump_left) begin
						state <= 2'b01;
					end else if (bump_right) begin
						state <= 2'b11;
					end else begin
						state <= 2'b10;
					end
				end
				
				2'b01: begin
					if (bump_left && bump_right) begin
						state <= 2'b10;
					end else if (bump_left) begin
						state <= 2'b01;
					end else if (bump_right) begin
						state <= 2'b01;
					end else begin
						state <= 2'b10;
					end
				end
				
				2'b11: begin
					if (bump_left && bump_right) begin
						state <= 2'b01;
					end else if (bump_left) begin
						state <= 2'b11;
					end else if (bump_right) begin
						state <= 2'b11;
					end else begin
						state <= 2'b10;
					end
				end
			endcase
		end
	end
	
	always @(state) begin
		case (state)
			2'b10: begin
				walk_left = 1'b1;
				walk_right = 1'b0;
			end
			
			2'b01: begin
				walk_left = 1'b0;
				walk_right = 1'b1;
			end
			
			2'b11: begin
				walk_left = 1'b1;
				walk_right = 1'b0;
			end
		endcase
	end
endmodule
