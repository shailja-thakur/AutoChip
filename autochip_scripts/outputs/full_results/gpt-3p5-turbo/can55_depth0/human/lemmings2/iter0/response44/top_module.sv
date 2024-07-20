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
	
	parameter LEFT = 2'b00;
	parameter RIGHT = 2'b01;
	parameter FALL = 2'b10;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= LEFT;
		end else begin
			case(state)
				LEFT: begin
					if (ground == 1'b0) begin
						state <= FALL;
					end else if (bump_left == 1'b1) begin
						state <= RIGHT;
					end else begin
						state <= LEFT;
					end
				end
				RIGHT: begin
					if (ground == 1'b0) begin
						state <= FALL;
					end else if (bump_right == 1'b1) begin
						state <= LEFT;
					end else begin
						state <= RIGHT;
					end
				end
				FALL: begin
					if (ground == 1'b1) begin
						if (state == LEFT) begin
							state <= LEFT;
						end else begin
							state <= RIGHT;
						end
					end else begin
						state <= FALL;
					end
				end
			endcase
		end
	end
	
	always @(*) begin
		case(state)
			LEFT: begin
				walk_left = 1'b1;
				walk_right = 1'b0;
				aaah = 1'b0;
			end
			RIGHT: begin
				walk_left = 1'b0;
				walk_right = 1'b1;
				aaah = 1'b0;
			end
			FALL: begin
				walk_left = 1'b0;
				walk_right = 1'b0;
				aaah = 1'b1;
			end
		endcase
	end
endmodule
