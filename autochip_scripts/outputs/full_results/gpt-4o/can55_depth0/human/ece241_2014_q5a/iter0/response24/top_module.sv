module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // Define state types for Moore state machine
    typedef enum logic [1:0] {
        S0,  // Initial state
        S1   // State after inversion
    } state_t;

    state_t state, next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) 
            state <= S0;  // Reset to initial state
        else 
            state <= next_state;
    end

    always_comb begin
        case (state)
            S0: begin
                // In S0, the output is just the inverted input
                z = ~x;
                next_state = S1;
            end
            S1: begin
                // In S1, continue to output the inverted input for the rest of the bits
                z = ~x;
                next_state = S1;
            end
            default: begin
                z = 1'b0;
                next_state = S0;
            end
        endcase
    end

endmodule
