module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    typedef enum reg {STATE_A, STATE_B} state_type;
    state_type state, next_state;

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
            end
            STATE_B: begin
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
        endcase
    end

    always @(*) begin
        case (state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b1;
        endcase
    end
endmodule
