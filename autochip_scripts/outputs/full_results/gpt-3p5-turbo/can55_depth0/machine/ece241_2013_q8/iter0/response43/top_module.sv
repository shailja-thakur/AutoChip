module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

// Define the states
parameter S = 2'b00;
parameter S1 = 2'b01;
parameter S10 = 2'b10;

// Define the state and next_state variables
reg [1:0] state, next_state;

// Initialize the state with S
initial begin
	state = S;
end

// Assign the next_state based on the current state and input x
always @(state, x) begin
	case(state)
		S: begin
			if (x == 1'b0)
				next_state = S;
			else
				next_state = S1;
		end
		S1: begin
			if (x == 1'b0)
				next_state = S10;
			else
				next_state = S1;
		end
		S10: begin
			if (x == 1'b0)
				next_state = S;
			else
				next_state = S1;
		end
	endcase
end

// Assign the output z based on the current state
always @(state) begin
	case(state)
		S, S1: z = 1'b0;
		S10: z = x;
	endcase
end

// Assign the next state to the current state at the positive edge of clk
always @(posedge clk or negedge aresetn) begin
	if (~aresetn)
		state <= S;
	else
		state <= next_state;
end

endmodule
