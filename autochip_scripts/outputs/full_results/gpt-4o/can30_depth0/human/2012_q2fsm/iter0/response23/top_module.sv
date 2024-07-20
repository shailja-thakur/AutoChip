module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);
    
    // State declaration
    typedef enum logic [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101
    } state_t;

    state_t current_state, next_state;

    // State transition logic (State Table)
    always_comb begin
        case (current_state)
            STATE_A: next_state = (w) ? STATE_B : STATE_A;
            STATE_B: next_state = (w) ? STATE_C : STATE_D;
            STATE_C: next_state = (w) ? STATE_E : STATE_D;
            STATE_D: next_state = (w) ? STATE_F : STATE_A;
            STATE_E: next_state = (w) ? STATE_E : STATE_D;
            STATE_F: next_state = (w) ? STATE_C : STATE_D;
            default: next_state = STATE_A;
        endcase
    end

    // State flip-flops with synchronous reset
    always_ff @(posedge clk) begin
        if (reset)
            current_state <= STATE_A;
        else
            current_state <= next_state;
    end

    // State output logic
    always_comb begin
        case (current_state)
            STATE_A, STATE_B, STATE_C, STATE_D: z = 1'b0;
            STATE_E, STATE_F: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule
