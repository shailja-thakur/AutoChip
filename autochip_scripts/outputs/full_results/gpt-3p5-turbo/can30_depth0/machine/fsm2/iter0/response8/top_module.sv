module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

// Define the states
parameter A = 1'b0;
parameter B = 1'b1;

reg curr_state, next_state;

always @(*) begin
    // Determine next state based on current state and input values
    case (curr_state)
        A: next_state = (j) ? B : A;
        B: next_state = (k) ? A : B;
    endcase
end

always @(posedge clk) begin
    // Update state based on areset and next state
    if (areset)
        curr_state <= A;
    else
        curr_state <= next_state;
end

assign out = (curr_state == B) ? 1'b1 : 1'b0;

endmodule
