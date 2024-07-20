module top_module (
	input clk,
	input in,
	input areset,
	output out
);

// Define states
parameter B = 0;
parameter A = 1;

// Define outputs
// Since the output is synchronous with the clock, we will define a flip-flop to store the output value
reg out_ff;

// Define current state
reg [1:0] current_state;

// Define next state
reg [1:0] next_state;

// Define the output value based on the current state
always @(posedge clk or posedge areset)
begin
	if (areset)
		out_ff <= 0;
	else
		out_ff <= current_state;
end

// Define the next state and output based on the current state and input
always @(posedge clk or posedge areset)
begin
	if (areset)
		current_state <= B;
	else
		case (current_state)
			B: begin
				if (in)
					next_state <= B;
				else
					next_state <= A;
			end
			A: begin
				if (in)
					next_state <= A;
				else
					next_state <= B;
			end
		endcase
	end
end

// Assign the output
assign out = out_ff;

endmodule
