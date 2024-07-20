module top_module (
	input clk,
	input areset,
	input x,
	output z
);

// Define the states of the state machine
parameter A = 0;
parameter B = 1;

// Define the state register
reg [1:0] state;

// Define the next state variable
reg [1:0] next_state;

// Define the output variable
wire z;

always @(posedge clk or negedge areset) begin
	if (~areset) begin
		// Asynchronous reset
		state <= A;
	end else begin
		// Synchronous state transition
		state <= next_state;
	end
end

always @(*) begin
	case (state)
		A: begin
			if (x) begin
				next_state = B;
			end else begin
				next_state = A;
			end
		end
		B: begin
			next_state = B;
		end
	endcase
end

assign z = (state == A && x) || (state == B && !x);

endmodule
