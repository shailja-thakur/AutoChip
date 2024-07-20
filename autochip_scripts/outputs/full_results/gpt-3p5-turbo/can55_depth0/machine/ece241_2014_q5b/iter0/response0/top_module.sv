module top_module (
	input clk,
	input areset,
	input x,
	output z
);
// Define the two states A and B
parameter A = 1'b0;
parameter B = 1'b1;

// Declare a register to store the state of the state machine
reg state;

// Assign initial state to register
always @(posedge clk or posedge areset)
begin
	if (areset)
		state <= A;
	else
		state <= state;
end

// Set the next state based on the current state and input x
always @(posedge clk)
begin
	case (state)
		A: if (x) state <= B; else state <= A;
		B: state <= B;
	endcase
end

// Set the output z based on the current state and input x
assign z = (state == A && x) || (state == B && !x);

endmodule
