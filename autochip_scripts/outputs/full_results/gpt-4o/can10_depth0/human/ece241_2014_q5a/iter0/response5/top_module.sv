module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // State definitions
    typedef enum logic [1:0] {
        S0, // Initial state, waiting for input
        S1, // Flip bits (1's complement), waiting for first 0
        S2  // Pass bits unchanged (2's complement)
    } state_t;

    state_t state, next_state;

    // State transition
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            S0: begin
                if (~areset) 
                    next_state = (x == 1) ? S1 : S0;
                else
                    next_state = S0;
            end
            S1: begin
                next_state = (x == 0) ? S2 : S1;
            end
            S2: begin
                next_state = S2;
            end
            default: next_state = S0;
        endcase
    end

    // Output logic
    always_comb begin
        case (state)
            S0: z = x;
            S1: z = ~x; // flip bits during 1's complement phase
            S2: z = x;  // pass bits unchanged during 2's complement phase
            default: z = x;
        endcase
    end

endmodule
