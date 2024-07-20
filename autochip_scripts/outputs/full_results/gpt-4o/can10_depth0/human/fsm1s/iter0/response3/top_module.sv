module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
    // Define state encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;
    
    state_t state, next_state;

    // State transition logic (next state logic)
    always_comb begin
        case (state)
            STATE_B: if (in) next_state = STATE_B; else next_state = STATE_A;
            STATE_A: if (in) next_state = STATE_A; else next_state = STATE_B;
        endcase
    end

    // State flip-flops (sequential logic)
    always_ff @(posedge clk) begin
        if (reset)
            state <= STATE_B;
        else
            state <= next_state;
    end

    // Output logic based on current state
    always_comb begin
        case (state)
            STATE_B: out = 1;
            STATE_A: out = 0;
        endcase
    end
endmodule
