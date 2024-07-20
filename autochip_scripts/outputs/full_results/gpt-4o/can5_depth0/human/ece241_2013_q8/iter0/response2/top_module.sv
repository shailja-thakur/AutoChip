module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // Define state encoding
    typedef enum logic [1:0] {
        S0 = 2'b00, // Initial state
        S1 = 2'b01, // State after receiving '1'
        S2 = 2'b10  // State after receiving '10'
    } state_t;

    state_t current_state, next_state;

    // State transition
    always_ff @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Next state logic
    always_comb begin
        next_state = current_state; // Default to state unchanged
        z = 0; // Default to z = 0

        case (current_state)
            S0: begin
                if (x)
                    next_state = S1;
            end
            S1: begin
                if (!x)
                    next_state = S2;
                else
                    next_state = S1; // Remain in S1 if another '1' is received
            end
            S2: begin
                if (x) begin
                    z = 1; // Output '1' detected for sequence "101"
                    next_state = S1; // Need to check for overlapping
                end else
                    next_state = S0; // Go back to initial state
            end
        endcase
    end

endmodule
