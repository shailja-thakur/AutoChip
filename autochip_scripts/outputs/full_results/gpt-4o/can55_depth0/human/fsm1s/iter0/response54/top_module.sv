module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    // State declaration
    typedef enum reg [1:0] {STATE_B, STATE_A} state_t;
    state_t state, next_state;

    // State transition logic (next state)
    always @(*) begin
        case (state)
            STATE_B: next_state = in ? STATE_B : STATE_A;
            STATE_A: next_state = in ? STATE_A : STATE_B;
            default: next_state = STATE_B; // Default state
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            state <= STATE_B; // Reset state
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    assign out = (state == STATE_B);

endmodule
