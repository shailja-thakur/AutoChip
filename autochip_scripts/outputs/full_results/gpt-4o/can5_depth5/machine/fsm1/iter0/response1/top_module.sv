module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // Define states
    typedef enum reg {A, B} state_t;
    state_t current_state, next_state;
    
    // State transition on clock edge or async reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= B;    // Reset to state B
        else
            current_state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            A: next_state = (in) ? A : B;
            B: next_state = (in) ? B : A;
            default: next_state = B;  // Default to state B (just in case)
        endcase
    end

    // Output logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            out <= 1'b1;    // Output is high when reset (state B)
        else
            out <= (current_state == B);
    end

endmodule
