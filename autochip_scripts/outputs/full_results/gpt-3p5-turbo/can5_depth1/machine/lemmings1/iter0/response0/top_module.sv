module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output wire walk_left,
	output wire walk_right
);

parameter WL = 1'b0; // State WL
parameter WR = 1'b1; // State WR

reg state; // State register

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= WL; // Reset state to WL
	end else begin
		case(state)
			WL: begin
				if (bump_left) begin
					state <= WR; // Transition to state WR if bump_left is high
				end else begin
					state <= WL; // Stay in state WL if bump_left is low
				end
			end
			WR: begin
				if (bump_right) begin
					state <= WL; // Transition to state WL if bump_right is high
				end else begin
					state <= WR; // Stay in state WR if bump_right is low
				end
			end
		endcase
	end
end

assign walk_left = (state == WL) ? 1'b1 : 1'b0; // walk_left is high if state is WL, else low
assign walk_right = (state == WR) ? 1'b1 : 1'b0; // walk_right is high if state is WR, else low

endmodule
