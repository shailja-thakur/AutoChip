module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // State encoding
    typedef enum logic [1:0] {
        S0 = 2'b00, // Initial/Reset state
        S1 = 2'b01, // State after receiving '1'
        S2 = 2'b10  // State after receiving '10'
    } state_t;

    state_t state, next_state;

    // Sequential block to update state
    always_ff @(negedge clk or negedge aresetn) begin
        if (!aresetn)
            state <= S0;
        else
            state <= next_state;
    end

    // Combinational block to determine next state and output
    always_comb begin
        z = 1'b0;
        case (state)
            S0: begin
                if (x) next_state = S1;
                else next_state = S0;
            end
            S1: begin
                if (x) next_state = S1;
                else next_state = S2;
            end
            S2: begin
                if (x) begin
                    next_state = S1;
                    z = 1'b1; // Sequence "101" detected
                end
                else next_state = S0;
            end
            default: next_state = S0;
        endcase
    end

endmodule
