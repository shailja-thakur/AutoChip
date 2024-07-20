module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	input dig,
	output walk_left,
	output walk_right,
	output aaah,
	output digging
);
	reg [4:0] state;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 1;
		end else begin
			case (state)
				1: begin
					if (bump_left && !bump_right) begin
						state <= 2;
					end else if (!bump_left && bump_right) begin
						state <= 3;
					end else if (bump_left && bump_right) begin
						state <= 4;
					end else begin
						if (ground) begin
							state <= 1;
						end else begin
							state <= 5;
						end
					end
				end
				2: begin
					if (ground) begin
						state <= 1;
					end else begin
						state <= 5;
					end
				end
				3: begin
					if (ground) begin
						state <= 1;
					end else begin
						state <= 5;
					end
				end
				4: begin
					if (ground) begin
						state <= 1;
					end else begin
						state <= 5;
					end
				end
				5: begin
					if (ground) begin
						state <= 1;
					end else begin
						state <= 5;
					end
				end
				default: state <= 1;
			endcase
		end
	end
	
	always @(state) begin
		case (state)
			1: begin
				walk_left = 1;
				walk_right = 0;
				aaah = 0;
				digging = 0;
			end
			2: begin
				walk_left = 0;
				walk_right = 1;
				aaah = 0;
				digging = 0;
			end
			3: begin
				walk_left = 1;
				walk_right = 0;
				aaah = 0;
				digging = 0;
			end
			4: begin
				walk_left = 0;
				walk_right = 1;
				aaah = 0;
				digging = 0;
			end
			5: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 1;
				digging = 0;
			end
			default: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
				digging = 0;
			end
		endcase
	end
endmodule
