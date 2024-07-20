module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // State encoding
    typedef enum logic {STATE_A, STATE_B} state_t;
    state_t state, next_state;

    // Combinational block to determine the next state
    always @(*) begin
        case (state)
            STATE_A: begin
                if (j)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_B: begin
                if (k)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            default: next_state = STATE_A;
        endcase
    end

    // Clocked block to update the current state
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_A;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(state) begin
        if (state == STATE_B)
            out = 1;
        else
            out = 0;
    end

endmodule
