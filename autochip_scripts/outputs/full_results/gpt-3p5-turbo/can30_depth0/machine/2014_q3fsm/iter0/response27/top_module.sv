module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

// State definitions
parameter A = 1;
parameter B = 2;
parameter C = 3;
parameter S10 = 4;
parameter S11 = 5;
parameter S20 = 6;
parameter S21 = 7;
parameter S22 = 8;

// State variable
reg [3:0] state;

// Next state logic
always @ (posedge clk or posedge reset) begin
	if (reset) begin
		state <= A;
	end else begin
		case(state)
			A: if (s) state <= B;
			   else state <= A;
			B: if (w) state <= S11;
			   else state <= S10;
			C: if (w) state <= S11;
			   else state <= S10;
			S10: if (w) state <= S21;
			     else state <= S20;
			S11: if (w) state <= S22;
			     else state <= S21;
			S20: state <= B;
			S21: if (w) state <= C;
			     else state <= B;
			S22: if (w) state <= B;
			     else state <= C;
		endcase
	end
end

// Output logic
always @ (state) begin
	z = (state == B) || (state == C);
end

endmodule
