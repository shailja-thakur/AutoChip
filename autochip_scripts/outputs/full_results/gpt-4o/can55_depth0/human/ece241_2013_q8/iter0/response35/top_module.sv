module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // Declare state encoding
    typedef enum logic [1:0] {
        S0, // Initial state
        S1, // State after detecting '1'
        S2  // State after detecting '10'
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Next state logic and output logic
    always_comb begin
        // Default assignments
        next_state = current_state;
        z = 1'b0;

        case (current_state)
            S0: begin
                if (x)
                    next_state = S1;
                else
                    next_state = S0;
            end
            S1: begin
                if (x)
                    next_state = S1;
                else
                    next_state = S2;
            end
            S2: begin
                if (x) begin
                    next_state = S1;
                    z = 1'b1;
                end else
                    next_state = S0;
            end
            default: next_state = S0;
        endcase
    end

endmodule
