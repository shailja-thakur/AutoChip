module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;
reg out;
wire next_state_a, next_state_b;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= 2'b1;
		out <= 0;
	end else begin
		state <= (in && state[0]) ? 2'b1 : 2'b0;
		out <= state[0];
	end
end

assign next_state_a = (in && state[0]);
assign next_state_b = !(in && state[0]);

always @(state) begin
	case (state)
		2'b00: state <= next_state_a ? 2'b01 : 2'b00;
		2'b01: state <= next_state_b ? 2'b00 : 2'b01;
		default: state <= 2'b00;
	endcase
end

endmodule
