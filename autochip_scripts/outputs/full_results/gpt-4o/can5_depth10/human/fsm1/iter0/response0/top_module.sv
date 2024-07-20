module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State declarations
    typedef enum logic [1:0] {
        STATE_A = 1'b0,
        STATE_B = 1'b1
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case(state)
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
            default: next_state = STATE_B; // Default to STATE_B
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_B;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case(state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b1;
            default: out = 1'b1; // Default to 1'b1
        endcase
    end

endmodule
