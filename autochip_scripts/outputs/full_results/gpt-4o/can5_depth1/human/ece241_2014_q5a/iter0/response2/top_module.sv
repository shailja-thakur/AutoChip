module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum logic [1:0] {
        S0 = 2'b00, // Initial state, no flip required.
        S1 = 2'b01  // Flip state, flip the incoming bits.
    } state_t;

    state_t state, next_state;

    // State transition logic (Moore FSM)
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= S0;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (state)
            S0: next_state = x ? S1 : S0;
            S1: next_state = S1;
            default: next_state = S0;
        endcase
    end

    // Output logic (Moore)
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            z <= 1'b0;
        else begin
            case (state)
                S0: z <= x;
                S1: z <= ~x;
                default: z <= 1'b0;
            endcase
        end
    end

endmodule
