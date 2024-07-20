module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // State definitions
    typedef enum logic [1:0] {
        S0 = 2'b00, // Initial state
        S1 = 2'b01, // Complement the bit
        S2 = 2'b10  // Pass along the rest of the input directly
    } state_t;

    state_t current_state, next_state;
    reg flip;

    // State transition
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= S0;
            flip <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        case (current_state)
            S0: next_state = S1;
            S1: next_state = S2;
            S2: next_state = S2; // Stay in S2 once we've transitioned
        endcase
    end

    // Output logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 1'b0;
        end else begin
            case (current_state)
                S1: begin
                    flip <= 1'b1;
                    z <= ~x;
                end
                S2: begin
                    if (flip) begin
                        flip <= 1'b0;
                        z <= ~x;
                    end else begin
                        z <= x;
                    end
                end
                default: z <= x;
            endcase
        end
    end
endmodule
