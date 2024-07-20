module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [1:0] state;
reg [1:0] next_state;
reg z;

always @(posedge clk or negedge areset) begin
	if (~areset) begin
		state <= 2'b00;
		z <= 0;
	end else begin
		state <= next_state;
		z <= (state == 2'b10) ? ~x + 1 : z;
	end
end

always @(state, x) begin
	case (state)
		2'b00: next_state = (x == 1'b1) ? 2'b10 : 2'b00;
		2'b10: next_state = 2'b11;
		2'b11: next_state = (x == 1'b0) ? 2'b00 : 2'b11;
		default: next_state = 2'b00;
	endcase
end

endmodule
