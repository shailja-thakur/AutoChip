module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // State encoding
    typedef enum reg [2:0] {
        STATE_A = 3'd0,
        STATE_B = 3'd1,
        STATE_C = 3'd2,
        STATE_D = 3'd3,
        STATE_E = 3'd4,
        STATE_F = 3'd5
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            STATE_A: next_state = w ? STATE_A : STATE_B;
            STATE_B: next_state = w ? STATE_D : STATE_C;
            STATE_C: next_state = w ? STATE_D : STATE_E;
            STATE_D: next_state = w ? STATE_A : STATE_F;
            STATE_E: next_state = w ? STATE_D : STATE_E;
            STATE_F: next_state = w ? STATE_D : STATE_C;
            default: next_state = STATE_A;
        endcase
    end

    // State registers
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            STATE_E, STATE_F: z = 1;
            default: z = 0;
        endcase
    end

endmodule
