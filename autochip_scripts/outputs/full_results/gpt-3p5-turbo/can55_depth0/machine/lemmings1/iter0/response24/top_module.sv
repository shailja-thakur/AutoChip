module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);

parameter WL = 0;
parameter WR = 1;

reg state;
reg next_state;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= WL;
	end else begin
		state <= next_state;
	end
end

always @(state or bump_left or bump_right) begin
	case (state)
		WL: begin
			if (bump_left) begin
				next_state = WR;
			end else begin
				next_state = WL;
			end
		end
		WR: begin
			if (bump_right) begin
				next_state = WL;
			end else begin
				next_state = WR;
			end
		end
	endcase
end

always @(state) begin
	case (state)
		WL: begin
			walk_left = 1;
			walk_right = 0;
		end
		WR: begin
			walk_left = 0;
			walk_right = 1;
		end
	endcase
end

endmodule
