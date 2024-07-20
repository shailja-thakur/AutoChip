module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    state_t state, next_state;

    // State transition and output logic
    always_comb begin
        // Default values
        next_state = state;
        out = 1'b0;

        case (state)
            STATE_A: begin
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
                out = 1'b0;
            end
            STATE_B: begin
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_C;
                out = 1'b0;
            end
            STATE_C: begin
                if (in)
                    next_state = STATE_D;
                else
                    next_state = STATE_A;
                out = 1'b0;
            end
            STATE_D: begin
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_C;
                out = 1'b1;
            end
            default: next_state = STATE_A; // default to a known state
        endcase
    end

    // State register with synchronous reset
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= STATE_A;
        else
            state <= next_state;
    end
endmodule
