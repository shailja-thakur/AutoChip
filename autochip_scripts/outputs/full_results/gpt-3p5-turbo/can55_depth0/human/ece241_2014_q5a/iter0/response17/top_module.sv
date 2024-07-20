module top_module (
	input clk,
	input areset,
	input x,
	output z
);

// Register to store the current state
reg [1:0] state;
// Register to store the previous value of input 'x'
reg prev_x;
// Register to store the output 'z'
reg z_reg;

// Constants for state values
parameter S_IDLE = 0;
parameter S_CONVERTING = 1;

// Positive edge triggered flip-flop for the asynchronous reset signal
always @(posedge clk or posedge areset)
begin
	if (areset)
		state <= S_IDLE;
	else
		state <= next_state;
end

// Next state logic
always @(*)
begin
	case (state)
		S_IDLE: if (!areset && !x) next_state = S_IDLE;
						else next_state = S_CONVERTING;
		S_CONVERTING: if (!areset && prev_x == 1'b0 && x == 1'b1) next_state = S_IDLE;
							else next_state = S_CONVERTING;
		default: next_state = S_IDLE;
	endcase
end

// Output logic
always @(*)
begin
	case (state)
		S_IDLE: z_reg = 1'b0;
		S_CONVERTING: z_reg = ~x + 1'b1;
		default: z_reg = 1'b0;
	endcase
end

// Assign output
assign z = z_reg;

endmodule
