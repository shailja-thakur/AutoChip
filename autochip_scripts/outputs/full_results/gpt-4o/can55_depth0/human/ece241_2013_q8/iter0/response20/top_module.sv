module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // State definitions
    typedef enum reg [1:0] {
        S0,  // Initial state
        S1,  // State after seeing '1'
        S2   // State after seeing '10'
    } state_t;

    state_t current_state, next_state;

    // State register logic with asynchronous reset
    always_ff @(negedge aresetn or posedge clk) begin
        if (!aresetn) 
            current_state <= S0;  // Reset to initial state
        else 
            current_state <= next_state;  // Transition to next state
    end

    // Next state and output logic
    always_comb begin
        // Default assignments
        next_state = current_state;
        z = 0;

        case (current_state)
            S0: begin
                if (x == 1)
                    next_state = S1;  // '1' detected
            end
            S1: begin
                if (x == 0)
                    next_state = S2;  // '10' detected so far
                else
                    next_state = S1;  // Still in state S1 if another '1' is detected
            end
            S2: begin
                if (x == 1) begin
                    next_state = S1;  // Sequence '101' detected, move back to S1 for overlapping sequence
                    z = 1;  // Output '1' for detecting "101"
                end
                else
                    next_state = S0;  // Reset if no '1' detected
            end
            default: next_state = S0;  // Default case
        endcase
    end

endmodule
