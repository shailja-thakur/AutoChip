module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    typedef enum reg [1:0] {
        STATE_B = 2'b00,
        STATE_A = 2'b01
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            STATE_B: begin
                out = 1;
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_A: begin
                out = 0;
                if (in)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            default: begin
                next_state = STATE_B;
            end
        endcase
    end

    // State register and synchronous reset
    always @(posedge clk) begin
        if (reset)
            state <= STATE_B;
        else
            state <= next_state;
    end

endmodule
