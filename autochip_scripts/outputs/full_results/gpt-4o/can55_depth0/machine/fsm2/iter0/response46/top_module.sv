module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // Define the states as parameters for readability
    parameter A = 0, B = 1;
    reg state, next_state;

    // Combinational always block for next state logic
    always @(*) begin
        case (state)
            A: next_state = j ? B : A;
            B: next_state = k ? A : B;
            default: next_state = A; // default case to avoid inferencing latches
        endcase
    end

    // Sequential always block for state transitions
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            out <= 0;
        else
            out <= (state == B);
    end

endmodule
