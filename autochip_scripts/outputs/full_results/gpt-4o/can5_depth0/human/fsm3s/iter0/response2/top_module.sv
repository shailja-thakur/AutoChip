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

    // State transition logic
    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (in == 1'b0)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end

            STATE_B: begin
                if (in == 1'b0)
                    next_state = STATE_C;
                else
                    next_state = STATE_B;
            end

            STATE_C: begin
                if (in == 1'b0)
                    next_state = STATE_A;
                else
                    next_state = STATE_D;
            end

            STATE_D: begin
                if (in == 1'b0)
                    next_state = STATE_C;
                else
                    next_state = STATE_B;
            end

            default: next_state = STATE_A;
        endcase
    end

    // State register with synchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= STATE_A;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (current_state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b0;
            STATE_C: out = 1'b0;
            STATE_D: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule
