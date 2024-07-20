module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    typedef enum logic [1:0] {STATE_B = 2'b00, STATE_A = 2'b01} state_t;
    state_t state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            STATE_B: next_state = in ? STATE_B : STATE_A;
            STATE_A: next_state = in ? STATE_A : STATE_B;
            default: next_state = STATE_B; // Default state
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_B;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            STATE_B: out = 1'b1;
            STATE_A: out = 1'b0;
            default: out = 1'b1; // Default output
        endcase
    end

endmodule
