module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
    // State definitions
    parameter A = 0, B = 1;

    // State register
    reg state;
    reg next_state;

    // Combinational logic for next state generation
    always @(*) begin
        case (state)
            A: if (in)
                   next_state = A;
               else
                   next_state = B;
            B: if (in)
                   next_state = B;
               else
                   next_state = A;
            default: next_state = B; // Default case for safety
        endcase
    end

    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B; // Reset to state B
        else
            state <= next_state;
    end

    // Output logic
    always @(state) begin
        if (state == B)
            out = 1;
        else
            out = 0;
    end

endmodule
