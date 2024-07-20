module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

reg [1:0] state, next_state;

// combinational always block to determine the next state
always @*
begin
	if (state == 2'b00) // if current state is A
		begin
			if (j)
				next_state = 2'b01; // next state is B if j is high
			else
				next_state = 2'b00; // next state is still A if j is low
		end
	else if (state == 2'b01) // if current state is B
		begin
			if (k)
				next_state = 2'b00; // next state is A if k is high
			else
				next_state = 2'b01; // next state is still B if k is low
		end
end

// clocked always block to update the state of the FSM
always @(posedge clk)
begin
	if (areset)
		state <= 2'b00; // reset state to A if areset is high
	else
		state <= next_state; // update state to next_state
	
	// assign out port based on current state
	if (state == 2'b01) // if current state is B
		out = 1'b1; // out port is high
	else
		out = 1'b0; // out port is low
end

endmodule
