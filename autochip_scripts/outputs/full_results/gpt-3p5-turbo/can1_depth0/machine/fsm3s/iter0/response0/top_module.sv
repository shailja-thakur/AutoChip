module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

// Define the four states
parameter A = 2'b00;  // binary value for A
parameter B = 2'b01;  // binary value for B
parameter C = 2'b10;  // binary value for C
parameter D = 2'b11;  // binary value for D

// Define the state and next_state variables
reg [1:0] state, next_state;

// Assign the initial state to be A
initial begin
	state = A;
	next_state = A;
end

// Sequential Logic: State transition and output assignment
always @(posedge clk, posedge reset) begin
	if (reset)
		state <= A;
	else
		state <= next_state;
	
	case(state)
		A: begin
			if (in)
				next_state <= B;
			else
				next_state <= A;
		end
		B: begin
			if (in)
				next_state <= B;
			else
				next_state <= C;
		end
		C: begin
			if (in)
				next_state <= D;
			else
				next_state <= A;
		end
		D: begin
			if (in)
                next_state <= B;
			else
				next_state <= C;
		end
	endcase
end

// Output Logic: Assign value to out based on current state
always @(state) begin
	if (state == D)
		out <= 1;
	else
		out <= 0;
end

endmodule
