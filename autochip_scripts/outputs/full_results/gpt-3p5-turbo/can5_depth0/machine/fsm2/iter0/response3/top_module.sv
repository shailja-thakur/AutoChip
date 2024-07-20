module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

reg [1:0] state, next_state;

// Combinational always block to determine next state
always @*
begin
	if (state == 2'b00) // state A
		begin
			if (j)
				next_state = 2'b01; // state B
			else
				next_state = 2'b00; // state A
		end
		
	if (state == 2'b01) // state B
		begin
			if (k)
				next_state = 2'b00; // state A
			else
				next_state = 2'b01; // state B
		end
end

// Clocked always block to update state based on areset and next_state
always @(posedge clk or posedge areset)
begin
	if (areset)
		state <= 2'b00; // state A
	else
		state <= next_state;
end

// Assign out port based on current state
assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
