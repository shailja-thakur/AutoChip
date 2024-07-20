module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);
    // State Encoding
    typedef enum reg {STATE_A, STATE_B} state_t;
    state_t state, next_state;

    // State Transition Logic
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
            default: next_state = STATE_B;
        endcase
    end

    // State Update Logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_B;
        end else begin
            state <= next_state;
        end
    end

    // Output Logic
    always @(state) begin
        case (state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b1;
            default: out = 1'b0;
        endcase
    end
endmodule
