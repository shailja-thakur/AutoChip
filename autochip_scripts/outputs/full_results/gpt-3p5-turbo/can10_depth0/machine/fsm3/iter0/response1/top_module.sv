module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;
wire next_state;

// Combinational logic block for determining the next state
always @(*)
begin
	if (state == 2'b00) // State A
	begin
		if (in)
			next_state = 2'b01; // State B
		else
			next_state = 2'b00; // State A
	end
	else if (state == 2'b01) // State B
	begin
		if (in)
			next_state = 2'b01; // State B
		else
			next_state = 2'b10; // State C
	end
	else if (state == 2'b10) // State C
	begin
		if (in)
			next_state = 2'b11; // State D
		else
			next_state = 2'b00; // State A
	end
	else if (state == 2'b11) // State D
	begin
		if (in)
			next_state = 2'b01; // State B
		else
			next_state = 2'b10; // State C
	end
end

// Sequential logic block for updating the state register
always @(posedge clk or posedge areset)
begin
	if (areset)
		state <= 2'b00; // Reset state to A
	else
		state <= next_state; // Update state to next_state
end

// Output logic block for setting the output signal
assign out = (state == 2'b11) ? 1'b1 : 1'b0;

endmodule
