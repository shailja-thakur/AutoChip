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
    reg has_flipped_bits;

    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= S0;
        else
            state <= next_state;
    end

    always_comb begin
        next_state = state;
        case (state)
            S0: begin
                if (x == 1) // Detect first 1 to start complementing after reset
                    next_state = S1;
                else
                    next_state = S0;
            end
            S1: begin
                if (x == 0) // After first flip to 0, move to carry propagation
                    next_state = S2;
                else
                    next_state = S1;
            end
            S2: begin
                next_state = S2; // Stay in propagate carry state
            end
            default: begin
                next_state = S0; // Default state
            end
        endcase
    end

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 0;
            has_flipped_bits <= 0;
        end else begin
            case (state)
                S0: begin
                    // Output the same bit before any flip
                    z <= x;
                    if (x == 1)
                        has_flipped_bits <= 1;
                end
                S1: begin
                    if (x == 0)
                        has_flipped_bits <= 1;
                    // Flip the bits after encountering the first 1
                    z <= ~x;
                end
                S2: begin
                    if (has_flipped_bits)
                        z <= 0; // Propagate the carry
                    else
                        z <= x; // If no bits have been flipped, output original
                end
            endcase
        end
    end
endmodule
