module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

reg [1:0] state, next_state;

// Combinational always block for determining the next state
always @(*)
begin
	if (state == 2'b00) // State A
	begin
		if (j)
			next_state = 2'b01; // Next state B
		else
			next_state = 2'b00; // Next state A
	end
	else if (state == 2'b01) // State B
	begin
		if (k)
			next_state = 2'b00; // Next state A
		else
			next_state = 2'b01; // Next state B
	end
end

// Clocked always block for updating the state
always @(posedge clk)
begin
	if (areset)
		state <= 2'b00; // Reset to state A
	else
		state <= next_state; // Update to next state
end

// Output assignment for indicating current state
assign out = (state == 2'b01) ? 1'b1 : 1'b0; // Output high if state is B, else low

endmodule
