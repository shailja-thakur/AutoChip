module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

// State encoding
parameter A = 1'b0, B = 1'b1;
reg state, next_state;

// Combinational logic to determine next state
always @(*) begin
    case (state)
        A: if (in) next_state = A; else next_state = B;
        B: if (in) next_state = B; else next_state = A;
        default: next_state = A; // Default case to prevent latches
    endcase
end

// State transition on clock edge
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= B; // Reset to the initial state B
    else
        state <= next_state; // Update state with next state
end

// Output logic
always @(*) begin
    if (state == B)
        out = 1'b1; // Output high if state is B
    else
        out = 1'b0; // Output low otherwise
end

endmodule
