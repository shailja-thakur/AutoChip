module top_module (
	input clk,
	input areset,
	input x,
	output z
);

// Define the two states
parameter A = 0;
parameter B = 1;

// Declare the state register
reg [1:0] state;

// Synchronize the state machine with the clock
always @(posedge clk) begin
	if (areset) begin
		// Async reset, set the state to A
		state <= A;
	else begin
		// Determine the next state based on the current state
		case (state)
			A: state <= (x == 1) ? B : A;
			B: state <= B;
		endcase
	end
end

// Configure the output z based on the current state and x input
assign z = (state == A && x == 1) || (state == B && x == 0);

endmodule
