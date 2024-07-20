module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    // Define state representation
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: if (j) next_state = B;
               else next_state = A;
            B: if (k) next_state = A;
               else next_state = B;
            default: next_state = A; // Default to state A for safekeeping
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset) state <= A;
        else state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            A: out = 1'b0;
            B: out = 1'b1;
            default: out = 1'b0; // Default to '0' for safekeeping
        endcase
    end

endmodule
