module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    typedef enum reg {STATE_A, STATE_B} state_t;
    state_t state, next_state;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_B;
        else
            state <= next_state;
    end

    always @(*) begin
        case (state)
            STATE_A: begin
                if (in)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
                out = 0;
            end
            STATE_B: begin
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
                out = 1;
            end
            default: begin
                next_state = STATE_B;
                out = 1;
            end
        endcase
    end

endmodule
