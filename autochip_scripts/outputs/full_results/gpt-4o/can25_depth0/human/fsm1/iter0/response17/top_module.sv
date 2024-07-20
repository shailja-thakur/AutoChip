module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;

    state_t state, next_state;

    // State transition logic (combinational)
    always_comb begin
        case (state)
            STATE_B: begin
                out = 1;
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_A: begin
                out = 0;
                if (in)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            default: begin
                next_state = STATE_B; // Default state to recover from illegal state
            end
        endcase
    end

    // State flip-flops with asynchronous reset (sequential)
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_B;
        else
            state <= next_state;
    end

endmodule
