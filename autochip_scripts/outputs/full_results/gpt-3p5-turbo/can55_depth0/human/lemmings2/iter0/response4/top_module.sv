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

	// State encoding:
	// 00 - walking left
	// 01 - walking right
	// 10 - falling

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b00; // Initial state is walking left
		end else begin
			case (state)
				2'b00: begin // Walking left
					if (bump_right && !bump_left) begin
						state <= 2'b01; // Walk right if bumped on the right
					end else if (bump_left && !bump_right) begin
						state <= 2'b00; // Continue walking left if bumped on the left
					end else if (bump_left && bump_right) begin
						state <= 2'b01; // Switch directions if bumped on both sides
					end else if (!ground) begin
						state <= 2'b10; // Fall if ground disappears
					end
				end
				2'b01: begin // Walking right
					if (!bump_right && bump_left) begin
						state <= 2'b00; // Walk left if bumped on the left
					end else if (bump_left && !bump_right) begin
						state <= 2'b01; // Continue walking right if bumped on the right
					end else if (bump_left && bump_right) begin
						state <= 2'b00; // Switch directions if bumped on both sides
					end else if (!ground) begin
						state <= 2'b10; // Fall if ground disappears
					end
				end
				2'b10: begin // Falling
					if (ground) begin
						state <= (state == 2'b00) ? 2'b00 : 2'b01; // Resume walking in same direction as before fall
					end
				end
			endcase
		end
	end

	// Output assignments
	assign walk_left = (state == 2'b00);
	assign walk_right = (state == 2'b01);
	assign aaah = (state == 2'b10);

endmodule
