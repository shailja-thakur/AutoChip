module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

// Declare states as enum
typedef enum logic [3:0] {
	A,
	B,
	C,
	S10,
	S11,
	S20,
	S21,
	S22
} state;

// Declare current_state and next_state signals
reg [3:0] current_state;
reg [3:0] next_state;

// Assign current_state initial value
initial begin
	current_state = A;
end

// Assign next_state based on current_state and input signals
always @(current_state, s, w) begin
	case (current_state)
		A: next_state = (s) ? B : A;
		B: next_state = (w) ? S11 : S10;
		C: next_state = (w) ? S11 : S10;
		S10: next_state = (w) ? S21 : S20;
		S11: next_state = (w) ? S22 : S21;
		S20: next_state = B;
		S21: next_state = (w) ? C : B;
		S22: next_state = (w) ? B : C;
	endcase
end

// Assign next_state to current_state on positive edge of clk
always @(posedge clk) begin
	if (reset) begin
		current_state <= A;
	end else begin
		current_state <= next_state;
	end
end

// Assign output z based on current_state
always @(current_state) begin
	case (current_state)
		A: z = 0;
		B: z = 0;
		C: z = 0;
		S10: z = 0;
		S11: z = 0;
		S20: z = 0;
		S21: z = 0;
		S22: z = 1;
	endcase
end

endmodule
