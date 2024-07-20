module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding using one-hot encoding
    typedef enum reg [3:0] {
        STATE_A = 4'b0001,
        STATE_B = 4'b0010,
        STATE_C = 4'b0100,
        STATE_D = 4'b1000
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_B: begin
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_C;
            end
            STATE_C: begin
                if (in)
                    next_state = STATE_D;
                else
                    next_state = STATE_A;
            end
            STATE_D: begin
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_C;
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
            STATE_D: out = 1;
            default: out = 0;
        endcase
    end

endmodule
