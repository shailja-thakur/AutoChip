module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (current_state)
            STATE_A: if (in) next_state = STATE_B; else next_state = STATE_A;
            STATE_B: if (in) next_state = STATE_B; else next_state = STATE_C;
            STATE_C: if (in) next_state = STATE_D; else next_state = STATE_A;
            STATE_D: if (in) next_state = STATE_B; else next_state = STATE_C;
            default: next_state = STATE_A;
        endcase
    end

    // State flip-flops with synchronous reset (sequential)
    always @(posedge clk) begin
        if (reset)
            current_state <= STATE_A;
        else
            current_state <= next_state;
    end

    // Output logic (combinational)
    always @(*) begin
        case (current_state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b0;
            STATE_C: out = 1'b0;
            STATE_D: out = 1'b1;
            default: out = 1'b0; // Default case to avoid latches
        endcase
    end
endmodule
