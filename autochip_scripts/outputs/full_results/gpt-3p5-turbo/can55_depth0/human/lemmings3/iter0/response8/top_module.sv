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
	// States: 0 - walking left, 1 - walking right, 2 - falling, 3 - digging
	
	reg walk_left;
	reg walk_right;
	reg aaah;
	reg digging;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 0;
			walk_left <= 1;
			walk_right <= 0;
			aaah <= 0;
			digging <= 0;
		end else begin
			case (state)
				0: begin // walking left
					if (bump_left) begin
						state <= 1;
						walk_left <= 0;
						walk_right <= 1;
					end else if (!ground) begin
						state <= 2;
						walk_left <= 0;
						aaah <= 1;
					end else if (dig) begin
						state <= 3;
						walk_left <= 0;
						digging <= 1;
					end
				end
				1: begin // walking right
					if (bump_right) begin
						state <= 0;
						walk_left <= 1;
						walk_right <= 0;
					end else if (!ground) begin
						state <= 2;
						walk_right <= 0;
						aaah <= 1;
					end else if (dig) begin
						state <= 3;
						walk_right <= 0;
						digging <= 1;
					end
				end
				2: begin // falling
					if (ground) begin
						state <= (walk_left) ? 0 : 1;
						aaah <= 0;
					end
				end
				3: begin // digging
					if (!ground) begin
						state <= 2;
						digging <= 0;
						aaah <= 1;
					end
				end
				default: state <= 0;
			endcase
		end
	end

endmodule
