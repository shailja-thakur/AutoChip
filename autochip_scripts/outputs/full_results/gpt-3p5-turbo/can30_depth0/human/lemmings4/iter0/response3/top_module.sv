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
	
	reg [1:0] state;
	reg walk_left, walk_right, aaah, digging;
	reg [4:0] fall_counter;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b01; // walking left
			fall_counter <= 0;
		end else begin
			case (state)
				2'b00: begin // falling
					if (ground) begin
						state <= 2'b01; // walking left or right
						fall_counter <= 0;
					end else if (fall_counter >= 5'd20) begin
						state <= 2'b11; // splatter
						fall_counter <= 0;
					end else begin
						fall_counter <= fall_counter + 1;
					end
				end
				2'b01: begin // walking left
					if (bump_right) begin
						state <= 2'b10; // walking right
					end else if (ground == 0) begin
						state <= 2'b00; // falling
						fall_counter <= 0;
					end else if (dig) begin
						state <= 2'b00; // falling
						fall_counter <= 0;
						digging <= 1;
					end
				end
				2'b10: begin // walking right
					if (bump_left) begin
						state <= 2'b01; // walking left
					end else if (ground == 0) begin
						state <= 2'b00; // falling
						fall_counter <= 0;
					end else if (dig) begin
						state <= 2'b00; // falling
						fall_counter <= 0;
						digging <= 1;
					end
				end
				2'b11: begin // splatter
					// do nothing, Lemming is splattered
				end
			endcase
		end
	end
	
	always @(state) begin
		case (state)
			2'b00: begin // falling
				aaah <= 1;
				walk_left <= 0;
				walk_right <= 0;
				digging <= 0;
			end
			2'b01: begin // walking left
				aaah <= 0;
				walk_left <= 1;
				walk_right <= 0;
				digging <= 0;
			end
			2'b10: begin // walking right
				aaah <= 0;
				walk_left <= 0;
				walk_right <= 1;
				digging <= 0;
			end
			2'b11: begin // splatter
				aaah <= 0;
				walk_left <= 0;
				walk_right <= 0;
				digging <= 0;
			end
		endcase
	end
	
endmodule
