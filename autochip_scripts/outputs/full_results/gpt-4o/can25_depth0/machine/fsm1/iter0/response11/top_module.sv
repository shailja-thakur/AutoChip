module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    typedef enum logic [0:0] {STATE_A = 1'b0, STATE_B = 1'b1} state_t;
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
        endcase
    end

    always_comb begin
        if (state == STATE_B)
            out = 1'b1;
        else
            out = 1'b0;
    end
endmodule
