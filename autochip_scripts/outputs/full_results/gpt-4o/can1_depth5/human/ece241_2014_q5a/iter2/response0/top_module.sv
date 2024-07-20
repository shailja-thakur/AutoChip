module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum logic [1:0] {
        S0 = 2'b00, // Wait for first 1
        S1 = 2'b01, // Flip bits (complement and add 1 while propagating carry)
        S2 = 2'b10  // Propagate carry, remaining bits after first 1 detected
    } state_t;

    state_t state, next_state;
    reg carry;

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
                if (x == 1)
                    next_state = S1; // Move to flipping bits state on first 1
                else
                    next_state = S0; // Remain in the same state
            end
            S1: begin
                if (x == 0 && carry)
                    next_state = S2; // Move to carry propagation state
                else
                    next_state = S1; // Remain in flipping bits state
            end
            S2: begin
                next_state = S2; // Propagate carry
            end
            default: begin
                next_state = S0; // Default state
            end
        endcase
    end

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 0;
            carry <= 1; // initially carry for two's complement addition
        end else begin
            case (state)
                S0: begin
                    z <= x;
                end
                S1: begin
                    z <= ~x ^ carry;
                    carry <= (~x & carry) | (~x & ~carry);
                end
                S2: begin
                    z <= x ^ carry;
                end
            endcase
        end
    end
endmodule
