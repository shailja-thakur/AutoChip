module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // State definitions
    typedef enum logic {A, B} state_t;
    state_t current_state, next_state;

    // Next state logic (combinational)
    always_comb begin
        case(current_state)
            A: if (j) next_state = B;
               else next_state = A;
            B: if (k) next_state = A;
               else next_state = B;
            default: next_state = A; // Should not happen
        endcase
    end

    // State transition logic (sequential)
    always_ff @(posedge clk or posedge areset) begin
        if (areset) 
            current_state <= A;
        else 
            current_state <= next_state;
    end

    // Output logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) 
            out <= 0;    // A state output thus low
        else 
            out <= (current_state == B);
    end

endmodule
