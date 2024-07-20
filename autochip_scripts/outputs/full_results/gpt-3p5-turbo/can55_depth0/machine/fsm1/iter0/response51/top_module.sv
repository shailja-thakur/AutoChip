module top_module (
	input clk,
	input in,
	input areset,
	output out
);

// Define state enum
typedef enum logic [1:0] {A, B} state_e;

// Define state and next_state signals
reg state_e state, next_state;

// Assign next_state based on current state and input
always_comb begin
    case (state)
        A: next_state = (in) ? A : B;
        B: next_state = (in) ? B : A;
    endcase
end

// Assign state based on next_state on rising edge of clk
always_ff @(posedge clk or posedge areset) begin
    if (areset)
        state <= B;
    else
        state <= next_state;
end

// Assign output based on current state
assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
