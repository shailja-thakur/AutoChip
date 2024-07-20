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

    // State transition logic
    always @(*) begin
        case (state)
            STATE_A: next_state = (in) ? STATE_A : STATE_B;
            STATE_B: next_state = (in) ? STATE_B : STATE_A;
            default: next_state = STATE_B;
        endcase
    end

    // State register
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_B;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            STATE_A: out = 0;
            STATE_B: out = 1;
            default: out = 1;
        endcase
    end

endmodule
