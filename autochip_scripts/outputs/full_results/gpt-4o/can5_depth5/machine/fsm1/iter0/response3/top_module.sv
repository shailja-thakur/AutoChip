module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // state encoding
    typedef enum reg {STATE_A, STATE_B} state_t;
    state_t state, next_state;

    // state transition logic
    always @(*) begin
        case (state)
            STATE_A: next_state = (in) ? STATE_A : STATE_B;
            STATE_B: next_state = (in) ? STATE_B : STATE_A;
            default: next_state = STATE_B;
        endcase
    end

    // state update logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_B;
        end else begin
            state <= next_state;
        end
    end

    // output logic
    always @(*) begin
        out = (state == STATE_B) ? 1'b1 : 1'b0;
    end

endmodule
