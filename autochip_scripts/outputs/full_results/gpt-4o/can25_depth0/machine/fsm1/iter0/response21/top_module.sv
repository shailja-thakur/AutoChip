module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State encoding
    typedef enum logic [0:0] {
        STATE_A = 1'b0,
        STATE_B = 1'b1
    } state_t;

    state_t current_state, next_state;

    // State Transition
    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (in)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            STATE_B: begin
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            default: next_state = STATE_B;
        endcase
    end

    // State Update on Clock or Asynchronous Reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= STATE_B;
        else
            current_state <= next_state;
    end

    // Output Logic
    always @(*) begin
        case (current_state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b1;
            default: out = 1'b1;  // Default state should be consistent with the reset state
        endcase
    end

endmodule
