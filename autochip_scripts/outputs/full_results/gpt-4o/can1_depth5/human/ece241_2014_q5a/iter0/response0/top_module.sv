module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum logic [1:0] {
        S0 = 2'b00, // Initial state
        S1 = 2'b01, // Flip bits
        S2 = 2'b10  // Propagate carry after flip
    } state_t;

    state_t state, next_state;
    reg complement_enable;

    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= S0;
        else
            state <= next_state;
    end

    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            complement_enable <= 0;
        else if (state == S0 && x == 1)
            complement_enable <= 1; // Enable flipping if the first '1' is encountered
        else if (state == S2 && x == 0)
            complement_enable <= 0; // Disable after carry
    end

    always_comb begin
        next_state = state;
        case (state)
            S0: begin
                if (x == 1) // Detect first 1 to start complementing after reset
                    next_state = S1;
            end
            S1: begin
                if (x == 1) // After first 1 keep complementing
                    next_state = S1;
                else // detect first 0 after complementing to propagate carry
                    next_state = S2;
            end
            S2: begin
                if (x == 1) // Continue to propagate carry
                    next_state = S2;
                else if (x == 0) // After carry propagation, back to S0 state for next input
                    next_state = S0;
            end
            default: begin
                next_state = S0; // Default state
            end
        endcase
    end

    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            z <= 0;
        else if (complement_enable)
            z <= ~x;
        else
            z <= x;
    end
endmodule
