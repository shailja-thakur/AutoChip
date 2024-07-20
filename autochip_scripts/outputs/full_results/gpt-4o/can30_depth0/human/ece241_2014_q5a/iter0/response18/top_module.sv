module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding
    typedef enum logic [1:0] {
        S0 = 2'b00, // State before encountering the first 1 or with carry being zero
        S1 = 2'b01  // State when carry is one
    } state_t;

    state_t current_state, next_state;
    
    // Output logic: Moore machine's outputs depend only on the current state
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            z <= 0;
        else begin
            case (current_state)
                S0: z <= ~x; // When carry is not present, output complements directly.
                S1: z <= x;  // When carry is present, output equals the input bit.
                default: z <= 0;
            endcase
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            S0: if (x == 1) next_state = S1; else next_state = S0;
            S1: next_state = S1;
            default: next_state = S0;
        endcase
    end

endmodule
