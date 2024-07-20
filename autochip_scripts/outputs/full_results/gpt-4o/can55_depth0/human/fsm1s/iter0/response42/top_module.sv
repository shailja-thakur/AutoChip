module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    typedef enum reg [0:0] {
        STATE_B = 1'b0,
        STATE_A = 1'b1
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            STATE_B: begin
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_A: begin
                if (in)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            default: next_state = STATE_B; // default to reset state
        endcase
    end

    // State register
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
            default: out = 1; // default to reset state output
        endcase
    end

endmodule
