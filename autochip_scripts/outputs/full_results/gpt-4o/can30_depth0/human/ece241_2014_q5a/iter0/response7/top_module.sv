module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding
    typedef enum logic [1:0] {
        S0 = 2'b00, // Initial state before getting first bit
        S1 = 2'b01, // State after getting first bit (before flipping)
        S2 = 2'b10  // State after flipping the bits
    } state_t;

    state_t state, next_state;
    logic start_flipping;

    // State transition
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

    // Output logic and next state logic
    always_comb begin
        next_state = state;
        z = 1'b0; // Default output value
        start_flipping = 1'b0;
        
        case (state)
            S0: begin
                if (!areset) begin
                    next_state = S1;
                end
            end
            S1: begin
                // Start flipping the bits after the first 1 is encountered
                if (x) begin
                    start_flipping = 1'b1;
                    z = ~x; // Complement the bit
                    next_state = S2;
                end else begin
                    z = x;
                end
            end
            S2: begin
                // Flip the remaining bits
                z = ~x;
            end
        endcase
    end

endmodule
