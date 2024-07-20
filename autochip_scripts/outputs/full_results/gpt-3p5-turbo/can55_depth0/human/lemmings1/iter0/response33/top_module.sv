module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);

reg [1:0] state;
reg walk_left;
reg walk_right;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= 2'b10; // reset state to walk left
		walk_left <= 1'b1;
		walk_right <= 1'b0;
	end else begin
		case (state)
			2'b00: begin // walking left state
				if (bump_right) begin
					state <= 2'b01; // switch to walking right state
					walk_left <= 1'b0;
					walk_right <= 1'b1;
				end
			end
			2'b01: begin // walking right state
				if (bump_left) begin
					state <= 2'b00; // switch to walking left state
					walk_left <= 1'b1;
					walk_right <= 1'b0;
				end
			end
		endcase
	end
end

endmodule
