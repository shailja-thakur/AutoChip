module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State Definitions
    typedef enum logic [1:0] {
        WAIT_FIRST_1 = 2'b00, // Wait for the first '1'.
        FLIP_BITS = 2'b01,    // Flip the bits.
        PROPAGATE_CARRY = 2'b10 // Propagate the carry.
    } state_t;

    state_t state, next_state;
    reg carry;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WAIT_FIRST_1;
            carry <= 1; // The carry starts at 1 because we need to add 1 in 2's complement.
            z <= 0; // Reset output
        end else begin
            state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        case (state)
            WAIT_FIRST_1: begin
                z <= x; // Pass the input directly to the output
                if (x == 1) begin
                    carry <= 1; // Start flipping bits
                end
            end
            FLIP_BITS: begin
                z <= ~x ^ carry; // Flip the bit and add the carry
                carry <= ~x & carry; // Update carry for next addition
            end
            PROPAGATE_CARRY: begin
                z <= x ^ carry; // Just propagate the carry
                carry <= x & carry; // Update carry for next addition
            end
        endcase
    end

    always_comb begin
        next_state = state; // Default state transition is no change
        case (state)
            WAIT_FIRST_1: begin
                if (x == 1) begin
                    next_state = FLIP_BITS; // Move to the flipping bits state on seeing first '1'.
                end
            end
            FLIP_BITS: begin
                if (carry == 0) begin
                    next_state = WAIT_FIRST_1; // If no carry, reset to initial state
                end else begin
                    next_state = PROPAGATE_CARRY; // Else move to propagate carry state
                end
            end
            PROPAGATE_CARRY: begin
                if (carry == 0) begin
                    next_state = WAIT_FIRST_1; // If no carry, reset to initial state
                end
            end
            default: begin
                next_state = WAIT_FIRST_1; // Default to WAIT_FIRST_1
            end
        endcase
    end

endmodule
