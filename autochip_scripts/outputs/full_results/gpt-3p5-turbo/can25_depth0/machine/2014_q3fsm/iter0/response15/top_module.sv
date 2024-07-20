module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

// state declaration
reg [3:0] state, next_state;

// state parameters
parameter A = 0;
parameter B = 1;
parameter C = 2;
parameter S10 = 3;
parameter S11 = 4;
parameter S20 = 5;
parameter S21 = 6;
parameter S22 = 7;

// state assignments
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= A;
	end else begin
		state <= next_state;
	end
end

// next state logic
always @(state, s, w) begin
	case (state)
		A: if (s) begin next_state = B; end else begin next_state = A; end
		B: if (w) begin next_state = S11; end else begin next_state = S10; end
		C: if (w) begin next_state = S11; end else begin next_state = S10; end
		S10: if (w) begin next_state = S21; end else begin next_state = S20; end
		S11: if (w) begin next_state = S22; end else begin next_state = S21; end
		S20: next_state = B;
		S21: if (w) begin next_state = C; end else begin next_state = B; end
		S22: if (w) begin next_state = B; end else begin next_state = C; end
		default: next_state = A; // can add error handling here if needed
	endcase
end

// output assignment
always @(state) begin
	case (state)
		B, C, S10, S11: z = 1;
		default: z = 0;
	endcase
end

endmodule
