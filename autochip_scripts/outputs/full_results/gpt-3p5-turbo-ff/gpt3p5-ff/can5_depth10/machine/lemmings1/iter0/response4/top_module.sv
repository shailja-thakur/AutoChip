module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output reg walk_left,
	output reg walk_right
);

parameter WL = 1;
parameter WR = 2;

reg state;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= WL;
	end else begin
		if (state == WL) begin
			if (bump_left) begin
				state <= WR;
			end else begin
				state <= WL;
			end
		end else begin
			if (bump_right) begin
				state <= WL;
			end else begin
				state <= WR;
			end
		end
	end
end

always @(state) begin
	if (state == WL) begin
		walk_left <= 1;
		walk_right <= 0;
	end else begin
		walk_left <= 0;
		walk_right <= 1;
	end
end

endmodule
