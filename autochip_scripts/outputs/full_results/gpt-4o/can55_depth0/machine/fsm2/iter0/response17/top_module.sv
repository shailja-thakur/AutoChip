module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // State definitions
    typedef enum reg {A, B} state_t;
    state_t current_state, next_state;

    // Combinational block to determine the next state
    always @(*) begin
        case(current_state)
            A: if (j) next_state = B;
               else next_state = A;
            B: if (k) next_state = A;
               else next_state = B;
            default: next_state = A; // Default state if undefined
        endcase
    end

    // Clocked block to update the current state and handle reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= A; // Reset to state A
        else
            current_state <= next_state; // Transition to next state
    end

    // Output logic based on current state
    always @(*) begin
        if (current_state == B)
            out = 1;
        else
            out = 0;
    end
endmodule
