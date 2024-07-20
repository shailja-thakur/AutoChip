module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    // Define the states
    typedef enum logic [1:0] {
        STATE_A,
        STATE_B,
        STATE_C,
        STATE_D
    } state_t;

    // Define the signals
    state_t state, next_state;

    // Define the state register
    always_ff @(posedge clk or posedge reset)
    begin
        if (reset)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // Define the next state logic
    always_comb
    begin
        case (state)
            STATE_A:
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            STATE_B:
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_C;
            STATE_C:
                if (in)
                    next_state = STATE_D;
                else
                    next_state = STATE_A;
            STATE_D:
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_C;
            default:
                next_state = STATE_A;
        endcase
    end

    // Define the output logic
    assign out = (state == STATE_D) ? 1'b1 : 1'b0;

endmodule
