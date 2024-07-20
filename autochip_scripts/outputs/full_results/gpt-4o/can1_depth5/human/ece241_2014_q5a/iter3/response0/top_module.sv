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
            carry <= 1; // The carry starts at 1 because we need to add 1 in 2's complement
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        next_state = state; // Default state transition is no change
        case (state)
            WAIT_FIRST_1: begin
                if (x == 1)
                    next_state = FLIP_BITS; // Move to the flipping bits state on seeing first '1'.
            end
            FLIP_BITS: begin
                next_state = PROPAGATE_CARRY; // Always move to propagate carry after flipping bits
            end
            PROPAGATE_CARRY: begin
                next_state = PROPAGATE_CARRY; // Stay in this state
            end
            default: begin
                next_state = WAIT_FIRST_1; // Default to WAIT_FIRST_1
            end
        endcase
    end

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 0;
        end else begin
            case (state)
                WAIT_FIRST_1: begin
                    z <= x;
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
    end
endmodule
