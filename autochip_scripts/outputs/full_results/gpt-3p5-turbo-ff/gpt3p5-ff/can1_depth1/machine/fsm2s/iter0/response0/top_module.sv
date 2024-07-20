module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

reg state, next_state;

// State Assignment
parameter A = 0;
parameter B = 1;

// Synchronous reset
always @(posedge clk) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

// Next State Logic
always @(state, j, k) begin
    case(state)
        A: begin
            if (j)
                next_state = B;
            else
                next_state = A;
        end
        B: begin
            if (k)
                next_state = A;
            else
                next_state = B;
        end
    endcase
end

// Output Logic
always @(state) begin
    if (state == B)
        out = 1'b1;
    else
        out = 1'b0;
end

endmodule
