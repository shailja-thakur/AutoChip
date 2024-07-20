module top_module (
	input clk,
	input areset,
	input x,
	output z
);
// Define the states A and B
parameter A = 0;
parameter B = 1;

// Define the register to store the state
reg [1:0] state;

// Assign the initial state based on the areset input
always @(posedge clk or negedge areset) begin
	if (!areset)
		state <= A;
	else
		state <= state;
end

// Transition the state based on the case statement
always @(posedge clk) begin
	case (state)
		A: begin
			if (x)
				state <= B;
			else
				state <= A;
		end
		B: state <= B;
	endcase
end

// Assign the output z based on the state and x input
assign z = (state == A && x) || (state == B && !x);

endmodule
