module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
    // State encoding
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;

    state_t state, next_state;

    // Synchronous reset and state transition logic
    always @(posedge clk) begin
        if (reset)
            state <= STATE_B; // Reset state
        else
            state <= next_state;
    end

    // Next state and output logic
    always @(*) begin
        case (state)
            STATE_B: begin
                out = 1'b1;
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_A: begin
                out = 1'b0;
                if (in)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            default: begin
                next_state = STATE_B;
                out = 1'b1;
            end
        endcase
    end

endmodule
