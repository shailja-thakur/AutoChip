module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // State encoding
    typedef enum reg [3:0] {
        STATE_A = 4'd0,
        STATE_B = 4'd1,
        STATE_C = 4'd2,
        STATE_D = 4'd3,
        STATE_E = 4'd4,
        STATE_F = 4'd5
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @ (*) begin
        case (state)
            STATE_A: next_state = (w == 0) ? STATE_B : STATE_A;
            STATE_B: next_state = (w == 0) ? STATE_C : STATE_D;
            STATE_C: next_state = (w == 0) ? STATE_E : STATE_D;
            STATE_D: next_state = (w == 0) ? STATE_F : STATE_A;
            STATE_E: next_state = (w == 0) ? STATE_E : STATE_D;
            STATE_F: next_state = (w == 0) ? STATE_C : STATE_D;
            default: next_state = STATE_A;
        endcase
    end

    // State register
    always @ (posedge clk or posedge reset) begin
        if (reset)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // Output logic
    always @ (state) begin
        case (state)
            STATE_E, STATE_F: z = 1'b1;
            default: z = 1'b0;
        endcase
    end
endmodule
