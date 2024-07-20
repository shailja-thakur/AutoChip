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
	reg walk_left;
	reg walk_right;
	reg aaah;
	reg digging;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 5'b00000;
			walk_left <= 1;
			walk_right <= 0;
			aaah <= 0;
			digging <= 0;
		end else begin
			case (state)
				5'b00000: begin // Initial state - walking left
					if (bump_right & !bump_left) begin
						state <= 5'b00001; // Switch to walking right
						walk_left <= 0;
						walk_right <= 1;
						aaah <= 0;
						digging <= 0;
					end else if (!bump_right & !bump_left) begin
						state <= 5'b00000; // Continue walking left
						walk_left <= 1;
						walk_right <= 0;
						aaah <= 0;
						digging <= 0;
					end else if (bump_left & !bump_right) begin
						state <= 5'b00010; // Switch to walking left after bump
						walk_left <= 1;
						walk_right <= 0;
						aaah <= 0;
						digging <= 0;
					end else if (bump_left & bump_right) begin
						state <= 5'b00011; // Switch to walking left after bump on both sides
						walk_left <= 1;
						walk_right <= 0;
						aaah <= 0;
						digging <= 0;
					end else if (ground) begin
						state <= 5'b00100; // Falling state
						walk_left <= 1;
						walk_right <= 0;
						aaah <= 1;
						digging <= 0;
					end
				end

				5'b00001: begin // Walking right state
					if (bump_left & !bump_right) begin
						state <= 5'b00010; // Switch to walking left after bump
						walk_left <= 1;
						walk_right <= 0;
						aaah <= 0;
						digging <= 0;
					end else if (!bump_left & !bump_right) begin
						state <= 5'b00001; // Continue walking right
						walk_left <= 0;
						walk_right <= 1;
						aaah <= 0;
						digging <= 0;
					end else if (bump_left & bump_right) begin
						state <= 5'b00011; // Switch to walking left after bump on both sides
						walk_left <= 1;
						walk_right <= 0;
						aaah <= 0;
						digging <= 0;
					end else if (ground) begin
						state <= 5'b00100; // Falling state
						walk_left <= 0;
						walk_right <= 1;
						aaah <= 1;
						digging <= 0;
					end
				end

				5'b00010: begin // Walking left state after bump
					if (bump_left & !bump_right) begin
						state <= 5'b00010; // Continue walking left
						walk_left <= 1;
						walk_right <= 0;
						aaah <= 0;
						digging <= 0;
					end else if (!bump_left & !bump_right) begin
						state <= 5'b00001; // Switch to walking right
						walk_left <= 0;
						walk_right <= 1;
						aaah <= 0;
						digging <= 0;
					end else if (bump_left & bump_right) begin
						state <= 5'b00011; // Switch to walking left after bump on both sides
						walk_left <= 1;
						walk_right <= 0;
						aaah <= 0;
						digging <= 0;
					end else if (ground) begin
						state <= 5'b00100; // Falling state
						walk_left <= 1;
						walk_right <= 0;
						aaah <= 1;
						digging <= 0;
					end
				end

				5'b00011: begin // Walking left state after bump on both sides
					if (bump_left & !bump_right) begin
						state <= 5'b00010; // Switch to walking left after bump
						walk_left <= 1;
						walk_right <= 0;
						aaah <= 0;
						digging <= 0;
					end else if (!bump_left & !bump_right) begin
						state <= 5'b00001; // Switch to walking right
						walk_left <= 0;
						walk_right <= 1;
						aaah <= 0;
						digging <= 0;
					end else if (bump_left & bump_right) begin
						state <= 5'b00011; // Continue walking left
						walk_left <= 1;
						walk_right <= 0;
						aaah <= 0;
						digging <= 0;
					end else if (ground) begin
						state <= 5'b00100; // Falling state
						walk_left <= 1;
						walk_right <= 0;
						aaah <= 1;
						digging <= 0;
					end
				end

				5'b00100: begin // Falling state
					if (!ground) begin
						state <= 5'b00100; // Continue falling
						walk_left <= 1;
						walk_right <= 0;
						aaah <= 1;
						digging <= 0;
					end else begin
						state <= 5'b00101; // Landing state
						walk_left <= 1;
						walk_right <= 0;
						aaah <= 0;
						digging <= 0;
					end
				end

				5'b00101: begin // Landing state
					if (bump_right & !bump_left) begin
						state <= 5'b00001; // Switch to walking right
						walk_left <= 0;
						walk_right <= 1;
						aaah <= 0;
						digging <= 0;
					end else if (!bump_right & !bump_left) begin
						state <= 5'b00000; // Continue walking left
						walk_left <= 1;
						walk_right <= 0;
						aaah <= 0;
						digging <= 0;
					end else if (bump_left & !bump_right) begin
						state <= 5'b00010; // Switch to walking left after bump
						walk_left <= 1;
						walk_right <= 0;
						aaah <= 0;
						digging <= 0;
					end else if (bump_left & bump_right) begin
						state <= 5'b00011; // Switch to walking left after bump on both sides
						walk_left <= 1;
						walk_right <= 0;
						aaah <= 0;
						digging <= 0;
					end else if (ground) begin
						state <= 5'b00000; // Continue walking left
						walk_left <= 1;
						walk_right <= 0;
						aaah <= 0;
						digging <= 0;
					end
				end

				default: begin
					state <= 5'b00000;
					walk_left <= 1;
					walk_right <= 0;
					aaah <= 0;
					digging <= 0;
				end
			endcase
		end
	end
endmodule
