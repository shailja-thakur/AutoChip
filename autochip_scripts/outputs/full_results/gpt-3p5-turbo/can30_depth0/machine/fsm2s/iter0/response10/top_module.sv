module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

reg states, next_states;

// State assignments
parameter A = 0;
parameter B = 1;

// State flip flops
always @(posedge clk or posedge reset) begin
    if (reset)
        states <= A;
    else
        states <= next_states;
end

// Next states logic
always @(states, j, k) begin
    case (states)
        A: begin
            if (j)
                next_states = B;
            else
                next_states = A;
        end
        B: begin
            if (k)
                next_states = A;
            else
                next_states = B;
        end
    endcase
end

// Output assignment
always @(states) begin
    if (states == B)
        out = 1;
    else
        out = 0;
end

endmodule
