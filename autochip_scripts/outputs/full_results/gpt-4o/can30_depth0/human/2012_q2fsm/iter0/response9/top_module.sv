module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);
    // Define state codes
    typedef enum logic[2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101
    } state_t;

    // State registers
    state_t current_state, next_state;

    // State flip-flops (with synchronous reset)
    always @(posedge clk) begin
        if (reset)
            current_state <= STATE_A;
        else
            current_state <= next_state;
    end

    // State table (next state logic)
    always @(*) begin
        case (current_state)
            STATE_A: next_state = w ? STATE_B : STATE_A;
            STATE_B: next_state = w ? STATE_C : STATE_D;
            STATE_C: next_state = w ? STATE_E : STATE_D;
            STATE_D: next_state = w ? STATE_F : STATE_A;
            STATE_E: next_state = w ? STATE_E : STATE_D;
            STATE_F: next_state = w ? STATE_C : STATE_D;
            default: next_state = STATE_A; // Default case to avoid latches
        endcase
    end

    // Output logic
    always @(*) begin
        case (current_state)
            STATE_E, STATE_F: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule
