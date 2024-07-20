module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;
    
    state_t state, next_state;

    // Update state on clock or reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // Compute next state
    always @(*) begin
        case (state)
            STATE_A: if (in) next_state = STATE_B; else next_state = STATE_A;
            STATE_B: if (in) next_state = STATE_B; else next_state = STATE_C;
            STATE_C: if (in) next_state = STATE_D; else next_state = STATE_A;
            STATE_D: if (in) next_state = STATE_B; else next_state = STATE_C;
            default: next_state = STATE_A;
        endcase
    end

    // Compute output
    always @(posedge clk or posedge reset) begin
        if (reset)
            out <= 1'b0;
        else
            out <= (state == STATE_D) ? 1'b1 : 1'b0;
    end

endmodule
