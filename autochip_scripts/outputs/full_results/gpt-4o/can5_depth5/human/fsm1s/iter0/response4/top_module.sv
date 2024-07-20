module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_B = 2'b00,
        STATE_A = 2'b01
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            STATE_B: if (in == 0) next_state = STATE_A; else next_state = STATE_B;
            STATE_A: if (in == 0) next_state = STATE_B; else next_state = STATE_A;
            default: next_state = STATE_B;
        endcase
    end

    // State update logic 
    // (note: synchronous reset)
    always @(posedge clk) begin
        if (reset)
            current_state <= STATE_B;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (current_state)
            STATE_B: out = 1;
            STATE_A: out = 0;
            default: out = 1;
        endcase
    end

endmodule
