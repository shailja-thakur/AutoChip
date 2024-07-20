module top_module (
    input clk,
    input reset,
    input x,
    output reg z
); 

    // State encoding
    typedef enum logic [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100
    } state_t;

    state_t state, next_state;

    // State transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        next_state = state; // Default state transition
        case (state)
            STATE_A: if (x) next_state = STATE_B;
            STATE_B: if (x) next_state = STATE_E;
            STATE_C: if (x) next_state = STATE_B;
            STATE_D: if (x) next_state = STATE_C; else next_state = STATE_B;
            STATE_E: if (!x) next_state = STATE_D;
            default: next_state = STATE_A;
        endcase
    end

    // Output logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            z <= 1'b0;
        else
            z <= (state == STATE_D) || (state == STATE_E);
    end

endmodule
