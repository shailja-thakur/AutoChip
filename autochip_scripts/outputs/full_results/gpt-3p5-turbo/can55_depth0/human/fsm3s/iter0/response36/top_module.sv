module top_module (
	input clk,
	input in,
	input reset,
	output out
);

// declare the states
reg [1:0] state, next_state;

// declare the output
reg out_reg;

always @(posedge clk) begin
	if (reset) begin
		state <= 2'b00; // initialize state to A
		out_reg <= 1'b0; // initialize output to 0
	end else begin
		state <= next_state; // update state
		out_reg <= (state == 2'b01) ? 1'b1 : 1'b0; // set output based on current state
	end
end

always @(state, in) begin
	case (state)
		2'b00: next_state = (in == 1'b0) ? 2'b00 : 2'b01; // if in=0, next state is A, else B
		2'b01: next_state = (in == 1'b0) ? 2'b10 : 2'b01; // if in=0, next state is C, else B
		2'b10: next_state = (in == 1'b0) ? 2'b00 : 2'b11; // if in=0, next state is A, else D
		2'b11: next_state = (in == 1'b0) ? 2'b10 : 2'b01; // if in=0, next state is C, else B
	endcase
end

assign out = out_reg;

endmodule
