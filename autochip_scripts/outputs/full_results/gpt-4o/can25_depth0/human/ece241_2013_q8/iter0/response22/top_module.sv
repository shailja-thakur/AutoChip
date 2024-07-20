module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // State encoding
    typedef enum logic [1:0] {
        S0 = 2'b00,  // Initial state
        S1 = 2'b01,  // First '1' detected
        S2 = 2'b10   // '10' detected
    } state_t;

    // Current and next state variables
    state_t current_state, next_state;

    // Sequential logic for state transitions
    always_ff @(negedge aresetn or posedge clk) begin
        if (!aresetn)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Combinational logic for next state and output
    always_comb begin
        // Default values
        next_state = current_state;
        z = 1'b0;

        case (current_state)
            S0: begin
                if (x)
                    next_state = S1;
            end
            S1: begin
                if (!x)
                    next_state = S2;
            end
            S2: begin
                if (x) begin
                    next_state = S1;
                    z = 1'b1; // Sequence "101" detected
                end else
                    next_state = S0;
            end
            default: next_state = S0;
        endcase
    end

endmodule
