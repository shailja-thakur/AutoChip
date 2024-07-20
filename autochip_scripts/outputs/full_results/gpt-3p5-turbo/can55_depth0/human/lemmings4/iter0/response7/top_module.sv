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
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 0;
		end else begin
			case(state)
				0: begin
					walk_left <= 1;
					aaah <= 0;
					digging <= 0;
					if (bump_right) begin
						state <= 1;
					end else if (ground == 0) begin
						state <= 2;
					end
				end
				1: begin
					walk_right <= 1;
					aaah <= 0;
					digging <= 0;
					if (bump_left) begin
						state <= 0;
					end else if (bump_right) begin
						state <= 1;
					end else if (ground == 0) begin
						state <= 2;
					end
				end
				2: begin
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 1;
					digging <= 0;
					if (ground) begin
						state <= 3;
					end
				end
				3: begin
					walk_left <= 1;
					aaah <= 0;
					digging <= 0;
					if (dig && ground) begin
						state <= 4;
					end else if (bump_right) begin
						state <= 1;
					end else if (ground == 0) begin
						state <= 2;
					end
				end
				4: begin
					digging <= 1;
					walk_right <= 0;
					aaah <= 0;
					if (ground == 0) begin
						state <= 5;
					end
				end
				5: begin
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 1;
					digging <= 0;
					if (ground) begin
						state <= 3;
					end
				end
				default: begin
					state <= 0;
				end
			endcase
		end
	end
endmodule
