module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;

    state_t state, next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_B;
        else
            state <= next_state;
    end

    always_comb begin
        case (state)
            STATE_A: begin
                if (in)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            STATE_B: begin
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            default: next_state = STATE_B; // default to prevent latches
        endcase
    end

    always_comb begin
        out = (state == STATE_B) ? 1'b1 : 1'b0;
    end

endmodule
