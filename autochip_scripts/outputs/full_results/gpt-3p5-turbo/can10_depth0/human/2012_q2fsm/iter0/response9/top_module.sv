module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

// State codes
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;
parameter E = 1'b1;
parameter F = 1'b0;

reg [1:0] state, next_state;

always @(posedge clk) begin
	if (reset)
		state <= A;
	else
		state <= next_state;
end

always @(state or w) begin
	case (state)
		A: if (w) next_state = B; else next_state = A;
		B: if (w) next_state = C; else next_state = D;
		C: if (w) next_state = E; else next_state = D;
		D: if (w) next_state = F; else next_state = A;
		E: if (w) next_state = E; else next_state = D;
		F: if (w) next_state = C; else next_state = D;
	endcase
end

// Output assignment
always @(state) begin
	case (state)
		A, B, C, D: z = 0;
		E, F: z = 1;
	endcase
end

endmodule
