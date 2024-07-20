module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_A = 1'b0,
        STATE_B = 1'b1
    } state_t;

    state_t state, next_state;

    // State transition logic (combinational)
    always_comb begin
        case (state)
            STATE_B: begin
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_A: begin
                if (in)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            default: next_state = STATE_B;
        endcase
    end

    // State flip-flops (sequential)
    always_ff @(posedge clk) begin
        if (reset)
            state <= STATE_B;
        else
            state <= next_state;
    end

    // Output logic (combinational)
    always_comb begin
        case (state)
            STATE_B: out = 1;
            STATE_A: out = 0;
            default: out = 1;
        endcase
    end

endmodule
