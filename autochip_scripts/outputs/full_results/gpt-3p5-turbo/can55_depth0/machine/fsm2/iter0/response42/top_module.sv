module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

reg [1:0] state, next_state;

always @(*) begin
	// Determine next state based on current state and inputs j and k
	if (state == 2'b00) begin // current state is A
		if (j) begin // j port is high
			next_state = 2'b01; // next state is B
		end else begin
			next_state = 2'b00; // next state is A
		end
	end else begin // current state is B
		if (k) begin // k port is high
			next_state = 2'b00; // next state is A
		end else begin
			next_state = 2'b01; // next state is B
		end
	end
end

always @(posedge clk or posedge areset) begin
	// Update state based on areset and next_state
	if (areset) begin // areset is high
		state <= 2'b00; // reset state to A
	else
		state <= next_state; // update state to next_state
	end
end

assign out = (state == 2'b01) ? 1'b1 : 1'b0; // set out port to high if state is B, low otherwise

endmodule
