module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

// State encoding
parameter A = 1'b0;
parameter B = 1'b1;

// State register
reg state, next_state;

// Combinational logic block for next state determination
always @(*) begin
	case (state)
		A: begin
			if (in)
				next_state = A;
			else
				next_state = B;
		end
		B: begin
			if (in)
				next_state = B;
			else
				next_state = A;
		end
	endcase
end

// Sequential logic block for state register update
always @(posedge clk or posedge reset) begin
	if (reset)
		state <= B; // Initial state
	else
		state <= next_state;
end

// Output logic
always @(state) begin
	if (state == B)
		out = 1'b1;
	else
		out = 1'b0;
end

endmodule
