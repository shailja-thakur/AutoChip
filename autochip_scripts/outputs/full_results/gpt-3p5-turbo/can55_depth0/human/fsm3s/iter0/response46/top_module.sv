module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg [1:0] state, next_state;
reg out;

parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= A;
	end else begin
		state <= next_state;
	end
end

always @(*) begin
	case(state)
		A: if (in) next_state = B; else next_state = A;
		B: if (in) next_state = B; else next_state = C;
		C: if (in) next_state = D; else next_state = A;
		D: if (in) next_state = B; else next_state = C;
	endcase
end

always @(state) begin
	case(state)
		A: out = 1'b0;
		D: out = 1'b1;
		default: out = 1'b0;
	endcase
end

endmodule
