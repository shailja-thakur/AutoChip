module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encodings: 1-bit state representations
    typedef enum logic [1:0] {
        STATE_B = 1'b0, // state B
        STATE_A = 1'b1  // state A
    } state_t;

    state_t current_state, next_state;

    // State transition logic (combinational)
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
            default: next_state = STATE_B; // default to state B
        endcase
    end

    // State register logic (sequential)
    always @(posedge clk) begin
        if (reset) 
            current_state <= STATE_B;
        else
            current_state <= next_state;
    end

    // Output logic (combinational)
    always @(*) begin
        case (current_state)
            STATE_B: out = 1;
            STATE_A: out = 0;
            default: out = 1;
        endcase
    end

endmodule
