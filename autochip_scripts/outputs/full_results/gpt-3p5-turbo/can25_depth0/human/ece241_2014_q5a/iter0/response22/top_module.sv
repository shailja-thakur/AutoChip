module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

reg [2:0] state;
reg [2:0] next_state;

parameter [2:0] S0 = 3'b000;
parameter [2:0] S1 = 3'b001;

always @(posedge clk or negedge areset) begin
	if (areset == 0) begin
		state <= S0;
		z <= 1'b0;
	end else begin
		state <= next_state;
		z <= (state == S1) ? (~x + 1'b1) : z;
	end
end

always @(state) begin
	case (state)
		S0: next_state = S1;
		S1: next_state = S0;
		default: next_state = S0;
	endcase
end

endmodule
