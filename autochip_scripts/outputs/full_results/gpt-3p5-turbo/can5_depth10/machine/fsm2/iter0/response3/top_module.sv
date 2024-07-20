module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

// define states
parameter A = 1'b0;
parameter B = 1'b1;

// current_state and next_state variables
reg current_state;
reg next_state;

// combinational always block for determining next_state
always @* begin
	if (current_state == A) begin
		if (j == 1'b1)
			next_state = B;
		else
			next_state = A;
	end
	else begin
		if (k == 1'b1)
			next_state = A;
		else
			next_state = B;
	end
end

// clocked always block for updating current_state based on next_state and areset
always @(posedge clk) begin
	if (areset == 1'b1)
		current_state = A;
	else
		current_state = next_state;
end

// assign out based on current_state
assign out = (current_state == B) ? 1'b1 : 1'b0;

endmodule
