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
reg walk_left;
reg walk_right;
reg aaah;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= 2'b01; // initial state: walking left
		walk_left <= 1;
		walk_right <= 0;
		aaah <= 0;
	end else begin
		case(state)
			2'b00: begin // walking left
				if (bump_right) begin
					state <= 2'b10; // switch direction to walking right
					walk_left <= 0;
					walk_right <= 1;
					aaah <= 0;
				end else if (!ground) begin
					state <= 2'b11; // falling
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 1;
				end
			end
			2'b01: begin // walking right
				if (bump_left) begin
					state <= 2'b00; // switch direction to walking left
					walk_left <= 1;
					walk_right <= 0;
					aaah <= 0;
				end else if (!ground) begin
					state <= 2'b11; // falling
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 1;
				end
			end
			2'b10: begin // walking right
				if (bump_left) begin
					state <= 2'b00; // switch direction to walking left
					walk_left <= 1;
					walk_right <= 0;
					aaah <= 0;
				end else if (!ground) begin
					state <= 2'b11; // falling
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 1;
				end
			end
			2'b11: begin // falling
				if (ground) begin
					if (walk_left) begin
						state <= 2'b01; // resume walking left
						walk_left <= 1;
						walk_right <= 0;
						aaah <= 0;
					end else if (walk_right) begin
						state <= 2'b10; // resume walking right
						walk_left <= 0;
						walk_right <= 1;
						aaah <= 0;
					end
				end
			end
		endcase
	end
end

endmodule
