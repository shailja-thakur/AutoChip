module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg state, next_state;

always @(posedge clk, posedge areset) begin
	if (areset) begin
		state <= 1'b0;
	else begin
		state <= next_state;
	end
end

always @(state, in) begin
	case (state)
		0: begin
			if (in) begin
				next_state <= 1'b0;
			end else begin
				next_state <= 1'b1;
			end
		end
		1: begin
			if (in) begin
				next_state <= 1'b1;
			end else begin
				next_state <= 1'b0;
			end
		end
	endcase
end

assign out = (state == 1'b1) ? 1'b1 : 1'b0;

endmodule
