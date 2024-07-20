module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    typedef enum logic [1:0] {
        STATE_B = 2'b00,
        STATE_A = 2'b01
    } state_t;

    state_t state, next_state;

    // State Transition
    always @(*) begin
        case (state)
            STATE_B: if (in) next_state = STATE_B;
                     else   next_state = STATE_A;
            STATE_A: if (in) next_state = STATE_A;
                     else   next_state = STATE_B;
        endcase
    end

    // State Update
    always @(posedge clk) begin
        if (reset) 
            state <= STATE_B; // Reset state is B
        else 
            state <= next_state;
    end

    // Output Logic
    always @(*) begin
        case (state)
            STATE_B: out = 1'b1;
            STATE_A: out = 1'b0;
        endcase
    end

endmodule
