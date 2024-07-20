module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [3:0] state, next_state;

// state assignments
parameter A = 4'b0000;
parameter B = 4'b0001;
parameter C = 4'b0010;
parameter S10 = 4'b0011;
parameter S11 = 4'b0100;
parameter S20 = 4'b0101;
parameter S21 = 4'b0110;
parameter S22 = 4'b0111;

// initial state
initial begin
	state <= A;
	next_state <= A;
end

// state transition logic
always @(posedge clk) begin
	if (reset) begin
		state <= A;
		next_state <= A;
	end else begin
		state <= next_state;
		case(state)
			A: if (s) next_state <= B;
			B: if (w) next_state <= S11; else next_state <= S10;
			C: if (w) next_state <= S11; else next_state <= S10;
			S10: if (w) next_state <= S21; else next_state <= S20;
			S11: if (w) next_state <= S22; else next_state <= S21;
			S20: next_state <= B;
			S21: if (w) next_state <= C; else next_state <= B;
			S22: if (w) next_state <= B; else next_state <= C;
			default: next_state <= A;
		endcase
	end
end

// output logic
always @(posedge clk) begin
	if (reset) begin
		z <= 0;
	end else begin
		case(state)
			S10, S11, S20, S21, S22: z <= 1;
			default: z <= 0;
		endcase
	end
end

endmodule
