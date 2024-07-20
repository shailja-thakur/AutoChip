module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // Define state encoding
    typedef enum logic [1:0] {
        STATE_A = 1'b0,
        STATE_B = 1'b1
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            STATE_A: next_state = j ? STATE_B : STATE_A;
            STATE_B: next_state = k ? STATE_A : STATE_B;
            default: next_state = STATE_A; // Default transition
        endcase
    end

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        if (state == STATE_B)
            out = 1'b1;
        else
            out = 1'b0;
    end

endmodule
